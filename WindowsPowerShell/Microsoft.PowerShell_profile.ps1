# Bash-like terminal features and optional Powerline dependency
Import-Module PSReadLine
$PSReadLineOptions = @{
	EditMode                      = "Emacs"
	HistoryNoDuplicates           = $true
	HistorySearchCursorMovesToEnd = $true
	BellStyle                     = "Audible"
	# DingDuration = 64
	DingTone                      = 512
}
Set-PSReadLineOption @PSReadLineOptions
# Creates an alias for ls like I use in Bash
Set-Alias -Name v -Value Get-ChildItem
# Dependencies for powerline
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}
