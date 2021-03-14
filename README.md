# win10script
This is the Ultimate Windows 10 Script from a creation from multiple debloat scripts and gists from github. I also added Chocolatey and other tools to the script that I install on every machine.

## This fork is no longer being actively maintained
This project is no longer being actively maintained, it was replaced by my newer [Boxstarter scripts](https://github.com/NerdyGriffin/Boxstarter-Scripts)
Please refer to the original project at [ChrisTitusTech/win10script](https://github.com/ChrisTitusTech/win10script)

## NerdyGriffin Additions

- JSON file `preset.json` which contains customized lists of programs to install, categorized by program type and group together as "presets" (such as "default", "desktop", "laptop"
  - The choice of programs in each of these presets is customized my own personal computers, 
- Added function to install programs via Chocolatey by parsing the JSON files to retrieve the package names
  - This function will prompt the user to select which preset they desire, or attempt to automatically detect the right preset
    - If auto-detect is selected, the program will use the Computer Name to detect either desktop or laptop. By default, the computer name in Windows 10 is typically set to "DESKTOP-..." on desktop or "LAPTOP-..." on laptop. If the computer name contains "DESKTOP", then the desktop preset will be selected, otherwise the laptop preset will be selected by default
  - Once a preset is selected, the program will print out a table showing all of the programs that will be installed, including the category name of each program and the name of the corresponding preset for each program. The user will be prompted to confirm whether this list is correct before the install is allowed to begin.

## Chris Titus Additions

- Dark Mode
- One Command to launch and run
- Chocolatey Install
- O&O Shutup10 CFG and Run
- Added Install Programs
- Added Debloat Microsoft Store Apps

## Modifications
I encourage people to fork this project and comment out things they don't like! Here is a list of normal things people change:
- Uninstalling OneDrive (This is on in my script)
- Installing Adobe, Chocolatey, Notepad++, MPC-HC, and 7-Zip

Comment any thing you don't want out... Example:

```
########## NOTE THE # SIGNS! These disable lines This example shows UACLow being set and Disabling SMB1
### Security Tweaks ###
	"SetUACLow",                  # "SetUACHigh",
	"DisableSMB1",                # "EnableSMB1",

########## NOW LETS SWAP THESE VALUES AND ENABLE SMB1 and Set UAC to HIGH
### Security Tweaks ###
	"SetUACHigh",
	"EnableSMB1",
```
