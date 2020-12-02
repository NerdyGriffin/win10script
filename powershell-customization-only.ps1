##########
# Installer for only Powerline (and some other PowerShell modules)
# Author: NerdyGriffin (Christian Kunis) <ckunis98@gmail.com>
#
##########

# Default preset
$tweaks = @(
	"UpdatePackageManagement",
	"InstallPowerline",
	"InstallPSReadline", # Sets PSReadline to emulate Bash-like behavior
	"InstallPipeworks"
)

Function UpdatePackageManagement {
	Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
	# Install-PackageProvider Nuget -Force -Verbose
	# Install-Module -Name PowerShellGet -Scope AllUsers -AllowClobber -SkipPublisherCheck -Force -AcceptLicense -Verbose
	# Install-Module -Name PackageManagement -Scope AllUsers -AllowClobber -SkipPublisherCheck -Force -AcceptLicense -Verbose
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber
	# Update-Module -AcceptLicense -Verbose
	Get-Module
}

Function InstallPowerline {
	try {
		Write-Host "Installing Posh-Git and Oh-My-Posh - [Dependencies for Powerline]"
		if (-Not(Get-Module -ListAvailable -Name posh-git)) {
			Install-Module posh-git -Scope AllUsers -AllowClobber -SkipPublisherCheck -Force -AcceptLicense -Verbose
		} else { Write-Host "Module 'posh-git' already installed" }
		if (-Not(Get-Module -ListAvailable -Name oh-my-posh)) {
			Install-Module oh-my-posh -Scope AllUsers -AllowClobber -SkipPublisherCheck -Force -AcceptLicense -Verbose
		} else { Write-Host "Module 'oh-my-posh' already installed" }

		Write-Host "Appending Configuration for Powerline to PowerShell Profile..."
		$PowerlineProfile = @(
			"# Dependencies for powerline",
			"Import-Module posh-git",
			"Import-Module oh-my-posh",
			"Set-Theme Paradox"
		)
		Write-Host >> $PROFILE # This will create the file if it does not already exist, otherwise it will leave the existing file unchanged
		foreach ($ProfileString in $PowerlineProfile) {
			if (-Not(Select-String -Pattern $ProfileString -Path $PROFILE)) {
				Add-Content -Path $PROFILE -Value $ProfileString
			}
		}
		if (Get-Command refreshenv -ErrorAction SilentlyContinue) { refreshenv }
	} catch {
		Write-Warning 'Powerline failed to install'
		# Move on if Powerline install fails due to error
	}
	Get-Module
}

Function InstallPSReadline {
	try {
		Write-Host "Installing PSReadLine -- [Bash-like CLI features and Optional Dependency for Powerline]"
		if (-Not(Get-Module -ListAvailable -Name PSReadLine)) {
			Install-Module -Name PSReadLine -Scope AllUsers -AllowClobber -SkipPublisherCheck -Force -AcceptLicense -Verbose
		} else { Write-Host "Module 'PSReadLine' already installed" }

		Write-Host "Appending Configuration for PSReadLine to PowerShell Profile..."
		$PSReadlineProfile = @(
			"# Customize PSReadline to make PowerShell behave more like Bash",
			"Import-Module PSReadLine",
			"Set-PSReadLineOption -EditMode Emacs -HistoryNoDuplicates -HistorySearchCursorMovesToEnd",
			"Set-PSReadLineOption -BellStyle Audible -DingTone 512",
			"# Creates an alias for ls like I use in Bash",
			"Set-Alias -Name v -Value Get-ChildItem"
		)
		Write-Host >> $PROFILE # This will create the file if it does not already exist, otherwise it will leave the existing file unchanged
		foreach ($ProfileString in $PSReadlineProfile) {
			if (-Not(Select-String -Pattern $ProfileString -Path $PROFILE)) {
				Add-Content -Path $PROFILE -Value $ProfileString
			}
		}
		if (Get-Command refreshenv -ErrorAction SilentlyContinue) { refreshenv }
	} catch {
		Write-Warning 'PSReadline failed to install'
		# Move on if PSReadline install fails due to errors
	}
	Get-Module
}

Function InstallPipeworks {
	try {
		Write-Host "Installing Pipeworks -- [CLI Tools for PowerShell]"
		Write-Host "Description: PowerShell Pipeworks is a framework for writing Sites and Software Services in Windows PowerShell modules."
		if (-Not(Get-Module -ListAvailable -Name Pipeworks)) {
			Install-Module -Name Pipeworks -Scope AllUsers -AllowClobber -SkipPublisherCheck -Force -AcceptLicense -Verbose
		} else { Write-Host "Module 'Pipeworks' already installed" }
		if (Get-Command refreshenv -ErrorAction SilentlyContinue) { refreshenv }
	} catch {
		Write-Warning 'Pipeworks failed to install'
		# Move on if Pipeworks install fails due to errors
	}
	Get-Module
}

# Call the desired tweak functions
$tweaks | ForEach-Object { Invoke-Expression $_ }
