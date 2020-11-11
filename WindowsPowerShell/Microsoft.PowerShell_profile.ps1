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

## The following Bash-styled KeyHandlers
## are automatically created by EditMode = "Emacs"
# Set-PSReadLineKeyHandler -Key Tab -Function Complete
# Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit
# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

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
