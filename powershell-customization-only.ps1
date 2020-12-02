##########
# Installer for only Powerline (and some other PowerShell modules)
# Author: NerdyGriffin (Christian Kunis) <ckunis98@gmail.com>
#
##########

# Default preset
$tweaks = @(
	"InstallPowerline",
	"InstallPSReadline", # Sets PSReadline to emulate Bash-like behavior
	"InstallPipeworks"
)

Function InstallPowerline {
	try {
		Write-Host "Installing Posh-Git and Oh-My-Posh - [Dependencies for Powerline]"
		if (-Not(Get-Module -ListAvailable -Name posh-git)) {
			Install-Module posh-git -Scope AllUsers -Force -SkipPublisherCheck
		} else { Write-Host "Module 'posh-git' already installed" }
		if (-Not(Get-Module -ListAvailable -Name oh-my-posh)) {
			Install-Module oh-my-posh -Scope AllUsers -Force -SkipPublisherCheck
		} else { Write-Host "Module 'oh-my-posh' already installed" }

		Write-Host "Appending Configuration for Powerline to PowerShell Profile..."
		$PowerlineProfile = @(
			"# Dependencies for powerline",
			"Import-Module posh-git",
			"Import-Module oh-my-posh",
			"Set-Theme Paradox"
		)
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
}

Function InstallPSReadline {
	try {
		Write-Host "Installing PSReadLine -- [Bash-like CLI features and Optional Dependency for Powerline]"
		if (-Not(Get-Module -ListAvailable -Name PSReadLine)) {
			Install-Module -Name PSReadLine -Scope AllUsers -Force -SkipPublisherCheck
		} else { Write-Host "Module 'PSReadLine' already installed" }

		Write-Host "Appending Configuration for PSReadLine to PowerShell Profile..."
		$PSReadlineProfile = @(
			"Import-Module PSReadLine",
			"Set-PSReadLineOption -EditMode Emacs -HistoryNoDuplicates -HistorySearchCursorMovesToEnd",
			"Set-PSReadLineOption -BellStyle Audible -DingTone 512",
			"# Creates an alias for ls like I use in Bash",
			"Set-Alias -Name v -Value Get-ChildItem"
		)
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
}

Function InstallPipeworks {
	try {
		Write-Host "Installing Pipeworks -- [CLI Tools for PowerShell]"
		Write-Host "Description: PowerShell Pipeworks is a framework for writing Sites and Software Services in Windows PowerShell modules."
		if (-Not(Get-Module -ListAvailable -Name Pipeworks)) {
			Install-Module -Name Pipeworks -Scope AllUsers -Force -SkipPublisherCheck -AllowClobber
		} else { Write-Host "Module 'Pipeworks' already installed" }
		if (Get-Command refreshenv -ErrorAction SilentlyContinue) { refreshenv }
	} catch {
		Write-Warning 'Pipeworks failed to install'
		# Move on if Pipeworks install fails due to errors
	}
}

# Call the desired tweak functions
$tweaks | ForEach-Object { Invoke-Expression $_ }
