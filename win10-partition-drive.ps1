<# PARTITION DRIVE #>

<#
> add feature
- customize folder icon
- quick auto for D: & E:
- create utility shortcuts (E:\- general\shortcuts)

> drives
- E:\-generals\utilities:
  - winver / disk clean / restore / registry editor / drive partition / windows features / environment variables / reliability monitor / resource monitor / manage account (admin)
  - wifi report info / power config / task manager / DNS site info / encrypt & decrypt file/folder / hide/show folder directory / list of programs installed (admin)
#>

###

$Tweaks = @(
    #"PromptNewDrive",
    #"Drives_D_And_E",
    #"UpdateDriveIcons",
    #"CreateDriveFolders"
)

###

Function PromptNewDrive {
    Do {
    Clear-Host
    Write-Host "================ Do You Want to Create a New Drive? ================"
    Write-Host "Y: Press 'Y' to do this."
    Write-Host "N: Press 'N' to skip this."
	Write-Host "Q: Press 'Q' to stop the entire script."
    $Selection = Read-Host -Prompt "Please select".ToLower()

    Switch ($Selection) {
    'y' { InputNewDrive }
    'n' { Break }
    'q' { Exit  }
    }
    } until ($Selection -match "y" -or $selection -match "n" -or $selection -match "q")
}

Function InputNewDrive {
    $Size = Read-Host -Prompt "Input the Drive Size (GB)"
    $Letter = Read-Host -Prompt "Input the Drive Letter"
    $Name = Read-Host -Prompt "Input the Drive Name"

    $Size = $Size.Trim()
    $Letter = $Letter.Trim().toUpper()
    $Name = $Name.Trim()
    $Name = (Get-Culture).TextInfo.ToTitleCase($Name)

    Write-Host "================ Confirm This Drive: $Name ($Letter :) - $Size GB ? ================"
    Write-Host "Y: Press 'Y' to do this."
    Write-Host "T: Press 'T' to try again."
    Write-Host "N: Press 'N' to skip this."
	Write-Host "Q: Press 'Q' to stop the entire script."
        
    Do {
    $Selection = Read-Host -Prompt "Please select".ToLower()
    
    Switch ($Selection) {
    'y' { 
        $isSize = ($Size -match "^[\d]+$") -and ([Int]$Size -gt 0)
        $Drives = (Get-PSDrive -PSProvider FileSystem).Name
        $isLetter = ($Drives -NotContains $Letter) -and ($Letter.Length -eq 1) -and ($Letter -match "[A-Z]")
        $isName = ($Name -ne "") -and ($Name.Length -ge 3) -and ($Name -match "^[\w\s\-]+$")

        If ($isSize -and $isLetter -and $isName) { 
        $Convert = [String](([Int]$Size * 1024) + 0.566) + "MB"
        $Size = ($Convert / 1MB) * 1MB # convert GB to MB for NTFS Size
        $Letter = [Char]$Letter
        CreateNewDrive -Size $Size -Letter $Letter -Name $Name
        }
        Else { 
        Write-Host "Invalid Input: Size, Letter, or Name... or check partition"
        Read-Host "Press 'enter' to try again..."
        PromptNewDrive
        }
    }
    't' { PromptNewDrive }
    'n' { Break }
    'q' { Exit  }
    }
    } until ($Selection -match "y" -or $selection -match "t" -or $selection -match "n" -or $selection -match "q")
}

Function CreateNewDrive {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [UInt64]$Size,
    
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [Char]$Letter,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String]$Name
    )

    $Space = [math]::Round(($Size / 1GB),1)
    Write-Host "================ Creating Drive: $Name ($Letter :) - $Space GB... ================"
    
    $Main = [Char]"C"
    Get-Volume -DriveLetter $Main
    
    $MainDriveSize = (Get-Partition -DriveLetter $Main).Size
    $DiffSize = $MainDriveSize - $Size
    Write-Host "$Letter - $DiffSize"
    # Resize-Partition -DriveLetter $Main -Size $DiffSize

    # Stop-Service -Name ShellHWDetection
    # New-Partition -DiskNumber 0 -UseMaximumSize -DriveLetter $Letter 
    # Format-Volume -DriveLetter $Letter -FileSystem "NTFS" -NewFileSystemLabel $Name -Full -Force
    # Start-Service -Name ShellHWDetection
 
    Get-Volume -DriveLetter $Main,$Letter
}

#---

Function Drives_D_And_E {
    $Size = [String]10
    $Check = [String](([Int]$Size * 1024) + 0.566) + "MB"
    $Conv = ($Check / 1MB) * 1MB

    Write-Host $Size, $Check, $Conv
    CreateNewDrive -Size $Conv -Letter "D" -Name "Development"
    CreateNewDrive -Size $Conv -Letter "E" -Name "External"
}

Function UpdateDriveIcon {
    Write-Host "Updating Drive Icons..."

    $Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\DriveIcons"
    $Drives = @(
        @{ Letter="D"; Icon="%systemroot%\system32\imageres.dll,86"; },
        @{ Letter="E"; Icon="%systemroot%\system32\imageres.dll,265"; }
    )

    ForEach ($Drive in $Drives) {
        If (!(Test-Path "$Path\$($Drive.Letter)")) {
            New-Item -Path "$Path\$($Drive.Letter)" | Out-Null
            New-Item -Path "$Path\$($Drive.Letter)\DefaultIcon" | Out-Null
        }

        Set-Item -Path "$Path\$($Drive.Letter)\DefaultIcon" -Value $Drive.Icon
    }
}

Function CreateDriveFolders {
    #Clear-Host

    Function NewDirectories {
        Param( [String] $Dir, [Object[]] $FoldersList )

        Write-Host "Creating ($Dir) New Directories (Folders)..."

        If (Test-Path $Dir) {
            ForEach ($Folder in $FoldersList) { 
                $Path = "$Dir\$Folder"
                If (!(Test-Path $Path)) { New-Item -Path $Path -ItemType "Directory" | Out-Null }
            }
        }
    }

    ###
    
    $FoldersD = @("- boilerplate", "Challenge", "In-Development", "In-Production", "Learning", "Projects", "Practice", "Testing")
    $FoldersD_Boilerplates = @("client-side", "full-stack_MERN", "server-side")
    $DriveD = "D:"

    NewDirectories -Dir "$DriveD" -FoldersList $FoldersD
    NewDirectories -Dir "$DriveD\-boilerplate" -FoldersList $FoldersD_Boilerplates
    
#    Get-ChildItem -Path "$DriveD" –Recurse -Directory

    #---#

    Write-Host "Creating (E:) New Directories (Folders)..."
    
    $FoldersE = @("- general", "Documents", "Downloads", "Images", "Music", "Videos")
    $FoldersE_Generals = @("icons", "utilities", "shortcuts")
    $FoldersE_Shortcuts = @(
        @{ Name="Wallpaper"; Path="$Env:WINDIR\Web"; },
        @{ Name="SendTo"; Path="$Env:APPDATA\Microsoft\Windows\SendTo"; },
        @{ Name="Startup"; Path="$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"; }
    )
    $DriveE = "E:"

    NewDirectories -Dir "$DriveE" -FoldersList $FoldersE
    NewDirectories -Dir "$DriveE\- general" -FoldersList $FoldersE_Generals

    If (Test-Path "$DriveE\- general\shortcuts"){
        ForEach ($Folder in $FoldersE_Shortcuts) {
            $Path = "$DriveE\- general\shortcuts\$($Folder.Name)"
            If (!(Test-Path $Path)) { 
                $Location = "$Path" + ".lnk"
                $WScriptShell = New-Object -ComObject WScript.Shell
                $Shortcut = $WScriptShell.CreateShortcut($Location)
                $Shortcut.TargetPath = $Folder.Path
                $Shortcut.Save()
            }
        }
    }

    Get-ChildItem -Path "$DriveE" –Recurse -Directory
}

###

# Invoke Selected Tweaks
$Tweaks | ForEach { Invoke-Expression $_ }

###