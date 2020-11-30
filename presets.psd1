class Group {
	[string]$Name
	[string]$Description
	[string[]]$MandatoryPackages
	[string[]]$DefaultPackages
	[string[]]$OptionalPackages
}
class EnvironmentGroup {
	[string]$Name
	[string]$Description
	[string[]]$MandatoryGroups
	[string[]]$DefaultGroups
	[string[]]$OptionalGroups
}
@{
	EnvironmentGroups = @{
		'Workstation' = @{
			Description     = 'Workstation is a user-friendly desktop system for laptops and PCs.'
			MandatoryGroups = @(
				'Core',
				'Fonts',
				'Guest Desktop Agents',
				'RGB and Gaming Peripherals',
				'Internet Browser',
				'GNOME -> Microsoft Windows',
				'Multimedia',
				'Standard',
				'Workstation product core'
			)
			OptionalGroups  = @(
				'Backup Client',
				'GNOME Applications -> Microsoft Windows Applications',
				'Internet Applications',
				'Office Suite and Productivity',
				'Remote Desktop Clients'
			)
		}
	}
	Groups            = @{
		'Fonts' = @{
			Description       = 'Fonts packages for rendering text on the desktop.'
			MandatoryPackages = @('chocolatey-font-helpers.extension')
			DefaultPackages   = @('cascadia-code-nerd-font', 'cascadiafonts')
		}
	},
	@{
		'Backup Client' = @{
			Description       = 'Client tools for connecting to a backup server and doing backups.'
			MandatoryPackages = @(
				'choco-package-list-backup'
			)
			OptionalPackages  = @(
				'nextcloud-client',
				'googledrive',
				'google-backup-and-sync'
			)
		}
	},
	@{
		'Remote Desktop Clients' = @{
			OptionalPackages = @('freerdp',
				'vnc-viewer',
				'parsec')
		}
	},
	@{
		'Office Suite and Productivity' = @{
			Description       = 'A full-purpose office suite, and other productivity tools.'
			MandatoryPackages = @('')
			DefaultPackages   = @(
				'adobereader',
				'libreoffice-fresh'
			)
			OptionalPackages  = @(
				'calibre',
				'kindle'
			)
		}
	},
	@{
		'Template' = @{
			Description       = 'Template for the structure of package groups'
			MandatoryPackages = @(
				'chocolatey'
			)
			DefaultPackages   = @(
				'chocolatey'
			)
			OptionalPackages  = @(
				'chocolatey'
			)
		}
	},
	@{
		'Core' = @{
			Description       = 'Smallest possible installation of Chocolatey and command line tools'
			MandatoryPackages = @(
				'chocolatey-core.extension',
				'chocolatey-dotnetfx.extension',
				'chocolatey-font-helpers.extension',
				'chocolatey-misc-helpers.extension',
				'psutils',
				'unzip',
				'wsl',
				'zip'
			)
			DefaultPackages   = @(
				'awk',
				'grep',
				'llvm',
				'nano',
				'ssh-copy-id'
			)
		}
	},
	@{
		'.NET Core Development' = @{
			Description       = 'Tools to develop .NET applications'
			MandatoryPackages = @(
				'chocolatey-dotnetfx.extension'
			)
			DefaultPackages   = @(
				'dotnetcore-aspnetruntime',
				'dotnetcore-desktopruntime',
				'dotnetcore-runtime',
				'dotnetcore-sdk',
				'dotnetcore-windowshosting',
				'dotnetcore'
			)
			OptionalPackages  = @(
				'dotnet-aspnetruntime',
				'dotnet-desktopruntime',
				'dotnet-runtime',
				'dotnet-sdk',
				'dotnet-windowshosting',
				'dotnet',
				'dotnetcore-2.1-aspnetruntime',
				'dotnetcore-2.1-desktopruntime',
				'dotnetcore-2.1-runtime',
				'dotnetcore-2.1-sdk',
				'dotnetcore-2.1-windowshosting',
				'dotnetcore-3.0-aspnetruntime',
				'dotnetcore-3.0-desktopruntime',
				'dotnetcore-3.0-runtime',
				'dotnetcore-3.0-sdk',
				'dotnetcore-3.0-windowshosting',
				'dotnetcore-3.1-aspnetruntime',
				'dotnetcore-3.1-desktopruntime',
				'dotnetcore-3.1-runtime',
				'dotnetcore-3.1-sdk',
				'dotnetcore-3.1-windowshosting'
			)
		}
	},
	@{
		'Desktop Debugging and Performance Tools' = @{
			Description       = 'GUI tools for debugging applications and performance.'
			MandatoryPackages = @(
				''
			)
			DefaultPackages   = @(
				'cpu-z',
				'gpu-z',
				'hwinfo',
				'hwmonitor',
				'plasso'
			)
			OptionalPackages  = @(
				'furmark',
				'heaven-benchmark',
				'msiafterburner',
				'procexp',
				'procmon',
				'superpostion-benchmark',
				'valley-benchmark'
			)
		}
	},
	@{
		'Standard' = @{
			Description       = 'The standard installation of Chocolatey and GNU tools on Windows 10.'
			MandatoryPackages = @(
				'chocolatey-core.extension',
				'chocolatey-dotnetfx.extension',
				'chocolatey-fastanswers.extension',
				'chocolatey-font-helpers.extension',
				'chocolatey-misc-helpers.extension',
				'ChocolateyDeploymentUtils',
				'ChocolateyExplorer',
				'ChocolateyGUI',
				'ChocolateyPackageUpdater',
				'chocolateypowershell',
				'Gpg4win',
				'keepass',
				'llvm',
				'notepadplusplus',
				'psutils',
				'shutup10',
				'winaero-tweaker',
				'wsl'
			)
			DefaultPackages   = @(
				'7zip',
				'choco-package-list-backup',
				'choco-upgrade-all-at',
				'freefilesync',
				'nano',
				'partitionwizard',
				'powertoys',
				'procmon',
				'rsync',
				'unzip',
				'zip'
			)
			OptionalPackages  = @(
				'choco-shortcuts-winconfig',
				'chocolatey-visualstudio.extension',
				'chocolatey-vscode.extension',
				'snappy-driver-installer',
				'etcher',
				'filebot',
				'rufus',
				'fuse-nfs',
				'tuxboot',
				'windowsrepair'
			)
		}
	},
	@{
		'Platform Development' = @{
			Description       = 'Recommended development headers and libraries for developing applications to run on Windows 10.'
			MandatoryPackages = @(
				'dotnetcore-sdk',
				'electron',
				'nvm'
			)
			DefaultPackages   = @(
				'visualstudio2017community',
				'vscode'
			)
			OptionalPackages  = @(
				'jsonedit'
			)
		}
	},
	@{
		'Unity Game Development' = @{
			DefaultPackages = @(
				'unity',
				'unity-hub'
			)
		}
	},
	@{
		'Internet Browsers' = @{
			Description       = 'The Brave web browser and others'
			MandatoryPackages = @(
				'brave'
			)
			DefaultPackages   = @(
				'chromium', 'firefox'
			)
			OptionalPackages  = @(
				'googlechrome'
			)
		}
	},
	@{
		'Internet Applications' = @{
			Description     = 'Email, chat, and video conferencing software.'
			DefaultPackages = @(
				'slack',
				'discord',
				'telegram',
				'jitsi-meet-electron',
				'zoom'
			)
		}
	},
	@{
		'Virtualization Client' = @{
			Description       = 'Clients for installing and managing virtualization instances.'
			OptionalPackages  = @(
				'virtualbox'
			)
			MandatoryPackages = @(
				'vmwareworkstation'
			)
		}
	},
	@{
		'Scientific Support' = @{
			Description      = 'Tools for mathematical and scientific computations, and parallel computing.'
			OptionalPackages = @(
				'geogebra',
				'gnuplot',
				'octave',
				'python3'
			)
		}
	},
	@{
		'TeX formatting system' = @{
			Description       = 'The TeX system for editing, typesetting, previewing, and printing TeX documents.'
			OptionalPackages  = @(
				'texmaker'
			)
			MandatoryPackages = @(
				'texlive'
			)
		}
	},
	@{
		'Debugging Tools' = @{
			Description      = 'Tools for debugging misbehaving applications and diagnosing performance problems.'
			OptionalPackages = @(
				'heapmemview',
				'procexp',
				'procmon',
				'simpleprogramdebugger '
			)
		}
	},
	@{
		'Performance Tools' = @{
			Description       = 'Tools for diagnosing system and application-level performance problems.'
			MandatoryPackages = @(
				'procmon',
				'procexp'
			)
			DefaultPackages   = @(
				'gperf',
				'plasso'
			)
		}
	},
	@{
		'Graphical Administration Tools' = @{
			Description      = 'Graphical system administration tools for managing many aspects of a system.'
			OptionalPackages = @(
				'plasso ',
				'procexp',
				'procmon',
				'wireshark'
			)
		}
	},
	@{
		'Lua' = @{
			DefaultPackages = @(
				'Lua',
				'luarocks'
			)
		}
	},
	@{
		'Video Games and Game Launchers' = @{
			DefaultPackages   = @(
				'cemu',
				'dolphin',
				'minecraft-launcher'
			)
			MandatoryPackages = @(
				'goggalaxy',
				'steam',
				'steam-cleaner',
				'steamlibrarymanager.portable'
			)
			OptionalPackages  = @(
				'epicgameslauncher',
				'flightgear',
				'uplay',
				'origin',
				'twitch'
			)
		}
	},
	@{
		'RGB and Gaming Peripherals' = @{
			DefaultPackages  = @(
				'logitechgaming'
			)
			OptionalPackages = @(
				'icue'
			)
		}
	},
	@{
		'Game Utilities and Cheats' = @{
			DefaultPackages = @(
				'cheatengine',
				'gamesavemanager',
				'steam-cleaner',
				'steamlibrarymanager.portable'
			)
		}
	},
	@{
		'Hardware Monitoring Utilities' = @{
			DefaultPackages  = @(
				'plasso',
				'procexp',
				'procmon',
				'msiafterburner',
				'hwmonitor'
			)
			Description      = 'A set of tools to monitor server hardware.'
			OptionalPackages = @(
				'cpu-z',
				'hwinfo',
				'gpu-z'
			)
		}
	},
	@{
		'Multimedia' = @{
			Description       = 'Audio/video framework common to desktops'
			OptionalPackages  = @(
				'audacity',
				'blender',
				'gimp',
				'irfanview',
				'obs-studio'
			)
			MandatoryPackages = @(
				'foobar2000',
				'freeencoderpack',
				'fsviewer',
				'k-litecodecpackfull',
				'vlc'
			)
		}
	},
	@{
		'Graphics Creation Tools' = @{
			Description     = 'Software for creation and manipulation of still images.'
			DefaultPackages = @(
				'blender', 'gimp'
			)
		}
	},
	@{
		'GNU' = @{
			Description     = 'Packages that are a part of, the related to, the GNU Project.'
			DefaultPackages = @(
				'awk',
				'diffutils',
				'findutils',
				'gimp',
				'gnuwin',
				'grep',
				'gnuplot',
				'gperf',
				'make',
				'nano',
				'octave',
				'patch',
				'sed',
				'wget'
			)
		}
	},
	@{
		'Python Web' = @{
			Description       = 'Basic Python web application support.'
			MandatoryPackages = @(
				'curl',
				'python3'
			)
		}
	},
	@{
		'Development Tools' = @{
			Description       = 'A basic development environment.'
			MandatoryPackages = @(
				'editor-services-command-suite',
				'gnuwin',
				'llvm',
				'make',
				'mingw',
				'pkgconfiglite',
				'winflexbison'
			)
			DefaultPackages   = @(
				'diffmerge',
				'diffutils',
				'findutils',
				'git',
				'Gpg4win',
				'jsonedit',
				'meld',
				'notepadplusplus',
				'patch',
				'StrawberryPerl',
				'universal-ctags',
				'vscode',
				'winmerge'
			)
			OptionalPackages  = @(
				'cmake',
				'gh',
				'git-credential-manager-for-windows',
				'hxd'
			)
		}
	},
	@{
		'Additional Development' = @{
			Description       = 'Additional development headers and libraries for building open-source applications.'
			MandatoryPackages = @(
				'dotnetcore-sdk',
				'dotnetcore',
				'electron',
				'nvm',
				'octave',
				'openjdk',
				'openjdk8',
				'openjdk11',
				'pip',
				'python',
				'python3',
				'StrawberryPerl'
			)
		}
	},
	@{
		'Java Platform' = @{
			Description       = 'Java support for the Windows Server and Desktop Platforms'
			MandatoryPackages = @(
				'openjdk',
				'openjdk8'
			)
			DefaultPackages   = @(
				'icedtea-web'
			)
		}
	},
	@{
		'Workstation product core' = @{
			Description       = 'Packages mandatory for the workstation product.'
			MandatoryPackages = @(
				'cascadia-code-nerd-font',
				'cascadiafonts',
				'choco-upgrade-all-at',
				'chocolatey-core.extension',
				'chocolatey-dotnetfx.extension',
				'chocolatey-fastanswers.extension',
				'chocolatey-font-helpers.extension',
				'chocolatey-misc-helpers.extension',
				'ChocolateyDeploymentUtils',
				'ChocolateyExplorer',
				'ChocolateyGUI',
				'ChocolateyPackageUpdater',
				'chocolateypowershell',
				'curl',
				'dos2unix',
				'ext2fsd',
				'ext2ifs',
				'fuse-nfs',
				'git',
				'Gpg4win',
				'grep',
				'jdk8',
				'keepass',
				'nano',
				'notepadplusplus',
				'psutils',
				'rsync',
				'tartool',
				'telnet',
				'tree',
				'unzip',
				'wsl',
				'zip'
			)
			DefaultPackages   = @(
				'7zip',
				'choco-package-list-backup',
				'choco-shortcuts-winconfig',
				'filebot',
				'freefilesync'
			)
			OptionalPackages  = @(
				'etcher',
				'junction-link-magic',
				'partitionwizard',
				'rufus',
				'tuxboot'
			)
		}
	},
	@{
		'Powerline for PowerShell' = @{
			MandatoryPackages = @(
				'git',
				'oh-my-posh',
				'Posh-GitHub',
				'poshgit',
				'cascadia-code-nerd-font',
				'cascadiafonts'
			)
		}
	},
	@{
		'GitHub Tools' = @{
			MandatoryPackages = @(
				'git',
				'Gpg4win'
			)
			DefaultPackages   = @(
				'diffmerge',
				'gh',
				'git-credential-manager-for-windows',
				'gitkraken'
			)
			OptionalPackages  = @(
				'gitdiffmargin',
				'gitextensions'
			)
		}
	},
	@{
		'VMware platform specific packages' = @{
			Description     = 'Virtualization utilities and drivers for VMware'
			DefaultPackages = @(
				'vmware-tools'
			)
		}
	},
	@{
		'Virtio drivers' = @{
			Description     = 'Virtualization drivers for RHEL VirtIO and QEMU'
			DefaultPackages = @(
				'virtio-drivers'
			)
		}
	},
	@{
		'Network File System Client' = @{
			Description       = 'Enables the system to attach to network storage.'
			MandatoryPackages = @(
				'ext2fsd',
				'ext2ifs',
				'fuse-nfs',
				'filezilla',
				'Wget',
				'winscp'
			)
			DefaultPackages   = @(
				'nextcloud-client'
			)
			OptionalPackages  = @(
				'googledrive',
				'google-backup-and-sync'
			)
		}
	},
	@{
		'Download Clients' = @{
			OptionalPackages = @(
				'qbittorrent',
				'megasync'
			)
		}
	},
	@{
		'Distributed Computing' = @{
			DefaultPackages = @(
				'fah'
			)
		}
	},
	@{
		'Networking Tools' = @{
			Description      = 'Tools for configuring and analyzing computer networks.'
			OptionalPackages = @(
				'advanced-ip-scanner',
				'iperf2',
				'netscan',
				'putty',
				'wireshark',
				'winscp'
			)
		}
	}
}
