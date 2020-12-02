##########
# Installer for only Powerline (and some other PowerShell modules)
# Author: NerdyGriffin (Christian Kunis) <ckunis98@gmail.com>
#
##########

# Default preset
$tweaks = @(
	"InstallPowerlineInPowerShell",
	"SetupPSReadlineForPowerShell", # Sets PSReadline to emulate Bash-like behavior
	"InstallPipeworks"
)

Function InstallPowerlineInPowerShell {
	Write-Host "Installing Posh-Git and Oh-My-Posh - [Dependencies for Powerline]"
	Install-Module posh-git -Scope CurrentUser -ErrorAction SilentlyContinue
	Install-Module oh-my-posh -Scope CurrentUser -ErrorAction SilentlyContinue
	Write-Host "Installing PSReadLine -- [Bash-like CLI features and Optional Dependency for Powerline]"
	Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
	Write-Host "Adding Modules for Powerline to PowerShell Profile..."
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
}

Function SetupPSReadlineForPowerShell {
	if (-Not(Get-Module -ListAvailable -Name PSReadLine)) {
		Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
	}
	if (Get-Module -ListAvailable -Name PSReadLine) {
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
	}
}

Function InstallPipeworks {
	Write-Host "Installing Pipeworks -- [CLI Tools for PowerShell]"
	Write-Host "Description: PowerShell Pipeworks is a framework for writing Sites and Software Services in Windows PowerShell modules."
	Install-Module -Name Pipeworks -Scope CurrentUser -Force -SkipPublisherCheck -AllowClobber -ErrorAction SilentlyContinue
	RefreshEnv
}

# Call the desired tweak functions
$tweaks | ForEach-Object { Invoke-Expression $_ }
