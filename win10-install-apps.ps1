<# INSTALL APPS #>

<#
> add features
- install by group list
- install all apps at one
- update all at once
#>

###

$Tweaks = @(
    "InitiateChocolatey"
    
    <# App - General #>
    "InstallChrome"
    "InstallBrave"
    "InstallQBittorrent"

    <# APP - Communication #>
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
#    "InstallTaskBarX" #FIXIT
	"InstallFlux"
    "Install7Zip"

    ###

    <# Design - Tools #>
#    "InstallAdobeXD" #ADDIT
#    "InstallFigma" #FIXIT
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
    "InstallWSL"
    "InstallUbuntu"
    "InstallWinTerminal"
    "InstallPowershellCore"
    "InstallGit"

    <# DEV - Databases #>
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
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
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
            # Read-Host "Press enter to continue"
        }
        'n' { Break }
        'q' { Exit  }
        }
    } Until (($Selection -match "[YNQ]") -and ($Selection.Length -eq 1))
}



########
# APP LIST
########


<# APP - General #>


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


<# APP - Communication #>


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


<# APP - Productivity #>


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


<# APP - Other #>


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



########
# WIN10 LIST
########

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
#	Show-Choco-Menu -Link $Link -Title "" -ChocoInstall ""
}

Function InstallFlux {
	$Link = "https://justgetflux.com/"
	Show-Choco-Menu -Link $Link -Title "f.lux" -ChocoInstall "f.lux"
}

Function Install7Zip {
    $Link = "https://www.7-zip.org/"
	Show-Choco-Menu -Link $Link -Title "7-Zip" -ChocoInstall "7zip"
}


<# Design - Tools #>


Function InstallAdobeXD {
	$Link = "https://www.adobe.com/products/xd.html"
}

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

Function InstallInsomnia {
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