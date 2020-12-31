<# INSTALL APPS #>

<#
> add features
- install by group list
- install all apps at one
- update all at once
#>

###

# C:\ProgramData\chocolatey\logs\chocolatey.log
<#
> FIXIT
- figma: unmatched hash issue - FA0D98788E713B071FDFF30A1790BBCFBC0E31BDB35035AC2AA08E105564C1EB
- minibin: unable to zip file
#>

$Tweaks = @(
    "InitiateChocolatey"
    
    <# App - General #>
    "InstallChrome"
    "InstallBrave"
    "InstallQBittorrent"

    <# APP - Communition #>
    "InstallZoom"
    "InstallSlack"
    "InstallDiscord"
    
    <# APP - Productivity #>
    "InstallEvernote"
    "InstallNotion"
    "InstallNotepad3"
    # "InstallNotepadplusplus"

    <# APP - Other #>
    "InstallShareX"
    #"InstallIrfanview"
    "InstallMasterPDFEditor"
    #"InstallAdobeReader"
    #"InstallVLC"

    ###

    <# WIN10 - Extensions #>
    "InstallPowerToys"
    "InstallQuickLook"
    "InstallMiniBin"
    "InstallTClock"
    "InstallQTTabBar"
    "InstallTaskBarX"
    "Install7Zip"

    ###

    <# Design - Tools #>
    "InstallFigma"
    "InstallInkscape"
    "InstallGIMP"
    "InstallFontBase"    

    ###

    <# DEV - Tools #>
    "InstallVSCode"
    "InstallNode"
    "InstallDeno"
    "InstallPython"
    "InstallGitHubApp"
    "InstallGitHubCLI"
    "InstallInsomnia"

    <# DEV - Terminals #>
    "IntstallWSL"
    "InstallUbuntu"
    "InstallWinTerminal"
    "InstallPowershellCore"
    "InstallGit"

    <# DEV - DB #>
    "InstallMySQL"
    "InstallPostgreSQL"
    "InstallPGAdmin"
    "InstallMongoDB"
    "InstallRobo3T"
)
###

Function InitiateChocolatey {

    Write-Output "Administrative permissions required. Detecting permissions ..."
	Set-ExecutionPolicy Bypass -Scope Process -Force
    Get-ExecutionPolicy

    If(Test-Path -Path "$($env:ProgramData)\Chocolatey") {
        Write-Output "Chocolatey is already installed, updating ..."
        choco upgrade chocolatey chocolatey-core.extension chocolateygui -y
    }
    Else {
        Write-Output "Installing Chocolatey ..."
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        choco install chocolatey-core.extension chocolateygui -y
    }
}

#---

Function Show-Choco-Menu {
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$Link,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$Title,
    
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$ChocoInstall
    )
   
    Do {
        Clear-Host
        Write-Host "$Title - $Link"
        Write-Host "================ Do you want to install $Title ? ================"
        Write-Host "Y : Press 'Y' to do this."
        Write-Host "N : Press 'N' to skip this."
	    Write-Host "Q : Press 'Q' to stop the entire script."
        $Selection = Read-Host "Please make a selection"
        
        Switch ($Selection) {
        'y' { 
            choco install $ChocoInstall -y 
            Read-Host "Press enter to continue"
        }
        'n' { Break }
        'q' { Exit  }
        }
    } Until ($Selection -match "y" -or $selection -match "n" -or $selection -match "q")
}



########
# APP LIST
########


<# App - General #>


Function InstallChrome {
    $Link = "https://www.google.com/chrome/"
	Show-Choco-Menu -Link $Link -Title "Chrome" -ChocoInstall "googlechrome"
}

Function InstallBrave {
    $Link = "https://brave.com/"
	Show-Choco-Menu -Link $Link -Title "Brave" -ChocoInstall "brave"
}

Function InstallqBittorrent {
    $Link = "https://www.qbittorrent.org/"
	Show-Choco-Menu -Link $Link -Title "qBittorrent" -ChocoInstall "qbittorrent"
}


<# App - Communication #>


Function InstallZoom {
    $Link = "https://zoomgov.com/download"
	Show-Choco-Menu -Link $Link -Title "Zoom" -ChocoInstall "zoom"
}

Function InstallSlack {
    $Link = "https://slack.com/downloads/windows"
	Show-Choco-Menu -Link $Link -Title "Slack" -ChocoInstall "slack"
}

Function InstallDiscord {
    $Link = "https://discord.com/"
	Show-Choco-Menu -Link $Link -Title "Discord" -ChocoInstall "discord"
}


<# App - Productivity #>


Function InstallEvernote {
    $Link = "https://evernote.com/"
	Show-Choco-Menu -Link $Link -Title "Evernote" -ChocoInstall "evernote"
}

Function InstallNotion {
    $Link = "https://www.notion.so/"
	Show-Choco-Menu -Link $Link -Title "Notion" -ChocoInstall "notion"
}

Function InstallNotepad3 {
    $Link = "https://github.com/rizonesoft/Notepad3"
	Show-Choco-Menu -Link $Link -Title "Notepad3" -ChocoInstall "notepad3"    
}

Function InstallNotepadplusplus {
	$Link = "https://notepad-plus-plus.org/"
    Show-Choco-Menu -Link $Link -Title "Notepad++" -ChocoInstall "notepadplusplus"
}


<# WIN10 - Extensions #>


Function InstallPowerToys {
    $Link = "https://github.com/microsoft/PowerToys"
	Show-Choco-Menu -Link $Link -Title "PowerToys" -ChocoInstall "powertoys"
}

Function InstallQuickLook {
    $Link = "https://github.com/QL-Win/QuickLook"
	Show-Choco-Menu -Link $Link -Title "QuickLook" -ChocoInstall "quicklook"
}

Function InstallMiniBin {
    # FIXIT - find way to install
    $Link = "https://e-sushi.net/"
	Show-Choco-Menu -Link $Link -Title "MiniBin" -ChocoInstall "minibin"
}

Function InstallTClock {
    $Link = "https://github.com/ygoe/T-Clock"
	Show-Choco-Menu -Link $Link -Title "T-Clock" -ChocoInstall "t-clock"
}

Function InstallQTTabBar {
    $Link = "http://qttabbar.sourceforge.net/"
	Show-Choco-Menu -Link $Link -Title "QT Tab Bar" -ChocoInstall "qttabbar"
}

Function InstallTaskBarX {
    # EDIT - find way to install
    $Link = "https://github.com/ChrisAnd1998/TaskbarX"
	Show-Choco-Menu -Link $Link -Title "TaskBarX" -ChocoInstall ""
}

Function Install7Zip {
    $Link = "https://www.7-zip.org/"
	Show-Choco-Menu -Link $Link -Title "7-Zip" -ChocoInstall "7zip"
}


<# App - Other #>

Function InstallShareX {
    $Link = "https://getsharex.com/"
	Show-Choco-Menu -Link $Link -Title "ShareX" -ChocoInstall "sharex"
}

Function InstallIrfanview {
    $Link = "https://www.irfanview.com/"
	Show-Choco-Menu -Link $Link -Title "Irfanview" -ChocoInstall "irfanview"
}

Function InstallMasterPDFEditor {
    $Link = "https://code-industry.net/masterpdfeditor/"
	Show-Choco-Menu -Link $Link -Title "Master PDF Editor" -ChocoInstall "master-pdf-editor"
}

Function InstallAdobeReader {
    $Link = "https://acrobat.adobe.com/us/en/acrobat/pdf-reader.html"
	Show-Choco-Menu -Link $Link -Title "Adobe Acrobat Reader" -ChocoInstall "adobereader"
}

Function InstallVLC {
    $Link = "https://www.videolan.org/vlc/"
	Show-Choco-Menu -Link $Link -Title "VLC" -ChocoInstall "vlc"
}


<# Design - Tools #>

Function InstallFigma {
    $Link = "https://www.figma.com/"
    Show-Choco-Menu -Link $Link -Title "Figma" -ChocoInstall "figma"
}
# InstallFigma # FIXIT

Function InstallInkscape {
    $Link = "https://inkscape.org/release/inkscape-1.0.1/"
    Show-Choco-Menu -Link $Link -Title "Inkscape" -ChocoInstall "inkscape"
}

Function InstallGIMP {
    $Link = "https://www.gimp.org/"
    Show-Choco-Menu -Link $Link -Title "GIMP" -ChocoInstall "gimp"
}

Function InstallFontBase {
    $Link = "https://fontba.se/"
    Show-Choco-Menu -Link $Link -Title "FontBase" -ChocoInstall "fontbase"
}



########
# DEV LIST
########


<# Development - Tools #>


Function InstallVSCode {
    $Link = "https://code.visualstudio.com/"
	Show-Choco-Menu -Link $Link -Title "Visual Studio Code" -ChocoInstall "vscode"
}

Function InstallNode {
	$Link = "https://nodejs.org/en/download/"
    Show-Choco-Menu -Link $Link -Title "Node" -ChocoInstall "nodejs"
}

Function InstallDeno {
	$Link = "https://deno.land/manual/getting_started/installation"
    Show-Choco-Menu -Link $Link -Title "Deno" -ChocoInstall "deno"
}

Function InstallPython {
	$Link = "https://www.python.org/download/releases/3.0/"
    Show-Choco-Menu -Link $Link -Title "Python" -ChocoInstall "python"
}

Function InstallGitHubApp {
	$Link = "https://desktop.github.com/"
    Show-Choco-Menu -Link $Link -Title "GitHub App" -ChocoInstall "github-desktop"
}

Function InstallGitHubCLI {
	$Link = "https://cli.github.com/"
    Show-Choco-Menu -Link $Link -Title "GitHub CLI" -ChocoInstall "gh"
}

Function InstallInsomniaCore {
    $Link = "https://insomnia.rest/download/"
    Show-Choco-Menu -Link $Link -Title "Insomnia" -ChocoInstall "insomnia-rest-api-client"
}


<# Development - Terminals #>


Function IntstallWSL {
    $Link = "https://ubuntu.com/wsl"
    Show-Choco-Menu -Link $Link -Title "Windows Subsystem for Linux" -ChocoInstall "wsl"
}

Function InstallUbuntu {
    $Link = "https://ubuntu.com/"
    Show-Choco-Menu -Link $Link -Title "Ubuntu" -ChocoInstall "wsl-ubuntu-2004"
}

Function InstallPowershellCore {
    $Link = "https://github.com/PowerShell/PowerShell/releases"
	Show-Choco-Menu -Link $Link -Title "Powershell Core" -ChocoInstall "powershell-core"
}

Function InstallGit {
    $Link = "https://git-scm.com/downloads"
    Show-Choco-Menu -Link $Link -Title "Git + Bash" -ChocoInstall "git"
}

Function InstallWinTerminal {
    $Link = "https://github.com/microsoft/terminal/releases"
	Show-Choco-Menu -Link $Link -Title "Microsoft Windows Terminal" -ChocoInstall "microsoft-windows-terminal"
}


<# Development - Database Servers #>


Function InstallMySQL {
    $Link = "https://dev.mysql.com/downloads/workbench/"
    Show-Choco-Menu -Link $Link -Title "MySQL Workbench" -ChocoInstall "mysql.workbench"
}

Function InstallPostgreSQL {
    $Link = "https://www.postgresql.org/download/"
	Show-Choco-Menu -Link $Link -Title "PostgreSQL" -ChocoInstall "postgresql"
}

Function InstallPGAdmin {
    $Link = "https://www.pgadmin.org/download/"
	Show-Choco-Menu -Link $Link -Title "pgAdmin 4" -ChocoInstall "pgadmin4"
}

Function InstallMongoDB {
    $Link = "https://www.mongodb.com/try/download/community"
	Show-Choco-Menu -Link $Link -Title "MongoDB" -ChocoInstall "mongodb"
}

Function InstallRobo3T {
    $Link = "https://robomongo.org/download"
	Show-Choco-Menu -Link $Link -Title "Robo3T" -ChocoInstall "robo3t"
}

###

# Invoke Selected Tweaks
#$Tweaks | ForEach { Invoke-Expression $_ }

###

<#
> Microsoft Store App To Install
- fluent search
- mytube (youtube)
- kanban tasker
- notepad x
- quick pad
- pantherbar
- socialize up
#>

<#
> Other Apps To Install
- vivaldi
- getsharex
- bitwarden
- foxitsoftware
- protonvpn
- ccleaner
- voidtools
- onlyoffice
- rufus (ISO boot)
- handbrake

- ccleaner
- cthing
- implbits
- riseup
- sourcefoundry
- ghostwriter
- jabref
- balena
- rapidee
- entropy6

- open shell (start menu classic)
- winscp
~ win32diskimager
~ winfsp
~ winmerge
- windirstat
- typora
- wincompose (char mapper)
- winamp (music player)

- windirstat
- sysinternals
- procexp
- procmon
- winmerge
- autohotkey
- fiddler4
- virtualbox.extensionpack
- nugetpackageexplorer
- linqpad4 
#>

<#
> Fonts
- power font
- mac type
- nerd fonts
#>

<#
**************************************************************************************
*  As of OpenSSH 0.0.22.0 Universal Installer, a script is distributed that allows   *
*  setting the default shell for openssh. You could call it with code like this:     *
*    If (Test-Path "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1")         *
*      {& "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1" [PARAMETERS]}     *
*  Learn more with this:                                                             *
*    Get-Help "C:\Program Files\openssh-win64\Set-SSHDefaultShell.ps1"               *
*  Or here:                                                                          *
*    https://github.com/DarwinJS/ChocoPackages/blob/master/openssh/readme.md         *
**************************************************************************************
#>

<#
Error - hashes do not match. Actual value was '0B1ABE8D5DC3FF416A06C9524E4F61A1FDF6CED583CB9B297EE72DF1732FF403'.
ERROR: Checksum for 'C:\Users\MFA-PC\AppData\Local\Temp\chocolatey\wsl-ubuntu-1804\18.04.1.020181923\Ubuntu_1804.2019.522.0_x64.appx' did not meet '96E4E3E336F08DDE1DF81FA9C266C5C7750BA92729857E92BDE36BF84A1DB002' for checksum type 'sha256'. Consider passing the actual checksums through with --checksum --checksum64 once you validate the checksums are appropriate. A less secure option is to pass --ignore-checksums if necessary.
The install of wsl-ubuntu-1804 was NOT successful.
Error while running 'C:\ProgramData\chocolatey\lib\wsl-ubuntu-1804\tools\ChocolateyInstall.ps1'.
 See log for details.
#>