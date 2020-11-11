#Requires -RunAsAdministrator

$PSScriptRoot

$PowerShellContextMenuReg = $PSScriptRoot + "\RegistryTweaks\PowerShell Context Menu Hacks\Add PowerShell to Context Menu.reg"

$ChocoInstallScript = $PSScriptRoot + "\Scripts\ChocolateyInstallNonAdmin.ps1"
if (!(Test-Path $ChocoInstallScript)) {
    Write-Error "Could not find Chocolatey install script"
    exit 1
}

$OpenSSHInstallScript = $PSScriptRoot + "\Scripts\OpenSSHServerInstall.ps1"
if (!(Test-Path $OpenSSHInstallScript)) {
    Write-Error "Could not find OpenSSH install script"
    exit 1
}

$PresetPackagesFilePath = $PSScriptRoot + "\presets.json"
if (!(Test-Path $PresetPackagesFilePath)) {
    Write-Error "Could not find presets.json"
    exit 1
} else {
    $PresetPackages = Get-Content $PresetPackagesFilePath | ConvertFrom-Json
}

# Ask the user to select an installation type
$InstallType = Read-Host -Prompt "Choose installation type:
[0] Detect automatically (default)
[1] Chocolatey Only
[2] OpenSSH Server
[3] Laptop Preset
[4] Desktop Preset
"

switch ($InstallType) {
    0 {
        # Attempt to detect computer by checking the computer name
        switch ($env:COMPUTERNAME) {
            "DESKTOP-GRIFFIN" {
                $InstallType = 4; break
            }
            default {
                $InstallType = 3; break
            }
        }
        break
    }
    1 {
        Write-Host "Installing Chocolatey only."; break
    }
    2 {
        Write-Host "Installing OpenSSH Server "; break
    }
    3 {
        Write-Host "Installing Desktop preset."; break
    }
    4 {
        Write-Host "Installing Laptop preset."; break
    }
    "q" { exit }
    default {
        # Write-Error "Invalid response: $InstallType"; exit
        switch ($env:COMPUTERNAME) {
            "DESKTOP-GRIFFIN" {
                $InstallType = 4; break
            }
            default {
                $InstallType = 3; break
            }
        }
        break
    }
}

# Initialize the array with some default packages
$ChocoPackageArray = New-Object System.Collections.ArrayList

Write-Host "Checking for existing Chocolatey install..."
do {
    $selection = 'q'
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        Write-Host "It appears Chocolatey is already installed" -ForegroundColor Green
        $selection = Read-Host "Would you like reinstall Chocolatey? [y/n]"
    } else {
        Write-Host "Chocolatey install not found on this PC." -ForegroundColor Yellow
        $selection = 'y'
    }
    switch ($selection) {
        'y' {
            Write-Output "Installing Chocolatey"
            Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            choco install chocolatey-core.extension -y
            if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
                Write-Host "Chocolatey was installed successfully" -ForegroundColor Green
            } else {
                Write-Error "Test failed to run the choco command.
If the installer output above indicates that the installation was in fact successful, then
please close and restart the powershell instance and try running this script again"
                exit 1
            }
        }
        'n' {
            Write-Host "Skipping Chocolatey installation..." -ForegroundColor Green
            Write-Host
            break
        }
        'q' { exit }
        default { Write-Host "" }
    }
}
until ($selection -match "y" -or $selection -match "n" -or $selection -match "q")

# Read the chocolatey packages from presets.json
foreach ($Category in $PresetPackages.chocolatey) {
    foreach ($PackageName in $Category.packages) {
        $Package = New-Object System.Object
        $Package | Add-Member -MemberType NoteProperty -Name "PackageName" -Value $PackageName
        $Package | Add-Member -MemberType NoteProperty -Name "Category" -Value $Category.name
        $Package | Add-Member -MemberType NoteProperty -Name "Preset" -Value "Chocolatey"
        $ChocoPackageArray.Add($Package) | Out-Null
    }
}

if ($InstallType -gt 1) {
    # Read the OpenSSH packages from presets.json
    foreach ($Category in $PresetPackages.openSSH) {
        foreach ($PackageName in $Category.packages) {
            $Package = New-Object System.Object
            $Package | Add-Member -MemberType NoteProperty -Name "PackageName" -Value $PackageName
            $Package | Add-Member -MemberType NoteProperty -Name "Category" -Value $Category.name
            $Package | Add-Member -MemberType NoteProperty -Name "Preset" -Value "OpenSSH"
            $ChocoPackageArray.Add($Package) | Out-Null
        }
    }

    if ($InstallType -gt 2) {
        # Read the default packages from presets.json
        foreach ($Category in $PresetPackages.default) {
            foreach ($PackageName in $Category.packages) {
                $Package = New-Object System.Object
                $Package | Add-Member -MemberType NoteProperty -Name "PackageName" -Value $PackageName
                $Package | Add-Member -MemberType NoteProperty -Name "Category" -Value $Category.name
                $Package | Add-Member -MemberType NoteProperty -Name "Preset" -Value "Default"
                $ChocoPackageArray.Add($Package) | Out-Null
            }
        }

        if ($InstallType -gt 3) {
            # Read the desktop  packages from presets.json
            foreach ($Category in $PresetPackages.desktop) {
                foreach ($PackageName in $Category.packages) {
                    $Package = New-Object System.Object
                    $Package | Add-Member -MemberType NoteProperty -Name "PackageName" -Value $PackageName
                    $Package | Add-Member -MemberType NoteProperty -Name "Category" -Value $Category.name
                    $Package | Add-Member -MemberType NoteProperty -Name "Preset" -Value "Desktop"
                    $ChocoPackageArray.Add($Package) | Out-Null
                }
            }
        } elseif ($InstallType -eq 3) {
            # Read the laptop  packages from presets.json
            foreach ($Category in $PresetPackages.laptop) {
                foreach ($PackageName in $Category.packages) {
                    $Package = New-Object System.Object
                    $Package | Add-Member -MemberType NoteProperty -Name "PackageName" -Value $PackageName
                    $Package | Add-Member -MemberType NoteProperty -Name "Category" -Value $Category.name
                    $Package | Add-Member -MemberType NoteProperty -Name "Preset" -Value "Laptop"
                    $ChocoPackageArray.Add($Package) | Out-Null
                }
            }
        }
    }
}

Write-Host
Write-Warning "The following packages have been selected by this preset:"
Write-Host

# Print out a table of all the selected packages
$ChocoPackageArray | Format-Table -Property @{Label = "index"; Expression = { $ChocoPackageArray.IndexOf($_) } }, "PackageName", "Category", "Preset"

Write-Host "Please confirm that the above list of packages is correct"
Write-Host
# Get the total number of packages that have been selected for this preset
$PackageCount = $ChocoPackageArray.Count
Write-Host "$PackageCount packages have been selected for install."
Write-Host
$FinalConfirmation = Read-Host -Prompt "Are you sure you want to continue? (This is going to take a while) [y/n]"

switch -regex ($FinalConfirmation.ToLower()) {
    "y(es)?" {
        Write-Host "Beginning install..." -ForegroundColor Green

        foreach ($Package in $ChocoPackageArray) {
            Write-Host "Installing "$Package.PackageName""
            choco install $Package.PackageName -y --force --limit-output
        }
        refreshenv

        if ($InstallType -lt 1) {
            Invoke-Expression $OpenSSHInstallScript

            refreshenv

            if ($InstallType -gt 2) {
                Write-Host 'Installing Node.js and npm '
                nvm install -lts
                nvm install 9.11.1

                refreshenv

                powershell.exe -NoLogo -NoProfile -Command 'Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber'

                refreshenv

                Write-Host "Installing Posh-Git and Oh-My-Posh - [Dependencies for Powerline]"
                Install-Module posh-git -Scope CurrentUser
                "A"
                Install-Module oh-my-posh -Scope CurrentUser
                "A"

                Write-Host "Installing PSReadLine -- [Dependency for Powerline and allows bash-like terminal features"
                Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
                "A"

                Write-Host "Installing 'Export-Icon' -- PowerShell script for exporting icons from .exe and .dll"
                Install-Module IconExport
                "A"

                Write-Host "Copying custom powershell profile..."
                if (Test-Path "$BackupPowerShellProfilePath") {
                    Copy-Item "$BackupPowerShellProfilePath" "$PROFILE.AllUsersAllHosts"
                    # Copy-Item "$BackupPowerShellProfilePath" "$PROFILE.AllUsersCurrentHost"
                    # Copy-Item "$BackupPowerShellProfilePath" "$PROFILE.CurrentUserAllHosts"
                    # Copy-Item "$BackupPowerShellProfilePath" "$PROFILE.CurrentUserCurrentHost"
                }

                if (Test-Path "$PowerShellContextMenuReg") {
                    Write-Host 'Adding "Open PowerShell Here" to Context Menu'
                    reg import $PowerShellContextMenuReg
                }

                Write-Host 'Creating a scheduled job that runs an `Update-Help` command.'
                $jobParams = @{
                    Name        = 'UpdateHelpJob'
                    Credential  = 'Domain01\User01'
                    ScriptBlock = '{Update-Help}'
                    Trigger     = (New-JobTrigger -Daily -At "3 AM")
                }
                Register-ScheduledJob @jobParams

                $WindowsTerminalBackupSettingsPath = "\\GRIFFINUNRAID\backup\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
                $WindowsTerminalLocalSettingsPath = "C:\Users\NerdyGriffin\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
                if (Test-Path "$WindowsTerminalBackupSettingsPath") {
                    Write-Host "Copying custom Windows Terminal config..."
                    Copy-Item "$WindowsTerminalBackupSettingsPath" "$WindowsTerminalLocalSettingsPath"
                }

                Write-Warning "
|----------------------------------------------------------------
|  Make sure to set the terminal fonts to Cascadia Code PL so that
|  the Powerline features will display correctly
|----------------------------------------------------------------"
            }
        }

        Write-Host
        Write-Host "Custom install complete!" -ForegroundColor Green
        Write-Host

        $OptionalReboot = Read-Host -Prompt "Would you like to reboot the computer now? [y/n]"

        switch -regex ($OptionalReboot.ToLower()) {
            "y(es)?" {
                Write-Warning "Rebooting the computer..."
                shutdown /g /d p:0:0 /c "Planned restart after custom chocolatey install script"
            }
            default {
                Write-Host
                Write-Host "Enjoy your computer!" -ForegroundColor Green
                Write-Host
            }
        }
    }
    "d(ebug)?" {
        $DebugPreference = "Continue"
        Write-Debug "DEBUG: Calling 'choco list <PackageName>' for each package..." -ForegroundColor Green

        foreach ($Package in $ChocoPackageArray) {
            Write-Debug "DEBUG: Listing "$Package.PackageName"" -ForegroundColor Cyan
            choco list $Package.PackageName #--limit-output
        }
    }
    default {
        Write-Warning "Package install canceled by the user"
    }
}
