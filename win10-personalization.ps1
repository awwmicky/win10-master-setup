<# PERSONALIZATION #>

<#
> [ ] System
- [x] background
  - bg > SELECT: solid color > PICK: metal blue
- [x] colors
  - choose your color > SELECT: custom
    - DARK: default windows mode
    - DARK: default app mode
  - show accent colors... > ON: tittle bar and window borders
- [x] lock screen
  - bg > SELECT: picture > BROWSE: %WINDIR%\Web\Wallpaper\Windows\img0.jpg
  - OFF: get fun...lock screen
- [x] start
  - OFF: show suggestions...
  - choose which folders appear on start
    - ON: file explorer / downloads
    - OFF: documents / pictures
- [x] taskbar
  - ON: use peek to preview...
  - notification areas
    - turn system icons...
      - ON: touch keyboard
  - DISABLE: people

> [ ] Personalization
- [x] display
  - scale & layout > adv. sacling settings > custom scaling > ENTER: 125
- [x] notifications & actions
  - quick actions > edit your quick actions
    - KEEP: bluetooth / battery saver / focus assist / night light / nearby sharing / connect / vpn / settings
  - notifications
    - OFF: show...lock screen (2x) / show...windows / suggest...windows / get...windows
- [~] focus assist
  - priority only > customize priority list
  - automatic rules
    - OFF: during / game / app
    - ON: show me a summary...
- [x] power & sleep
  - screen
    - on battery: 5 min
    - when plugged: 10 min
  - sleep
      - on battery: 15 min
      - when plugged: 30 min
  - more > power option > system settings
- [x] tablet mode
  - disable all
- [x] multitasking
  - snap windows
    - DISABLE: show what I can snap into
    - DISABLE: simultaneously resize...
  - timeline
    - DISABLE: show suggestions in your timeline
- [ ] shared experiences
  - nearby sharing > ...share & receive... > SELECT: only my devices
  - save files I receive to > CHANGE: E:\
#>

If (!(Get-PSDrive HKU -ErrorAction SilentlyContinue)) { New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null }
If (!(Get-PSDrive HKCC -ErrorAction SilentlyContinue)) { New-PSDrive -Name HKCC -PSProvider Registry -Root HKEY_CURRENT_CONFIG | Out-Null }
If (!(Get-PSDrive HKCU -ErrorAction SilentlyContinue)) { New-PSDrive -Name HKCU -PSProvider Registry -Root HKEY_CURRENT_USER | Out-Null }
If (!(Get-PSDrive HKCR -ErrorAction SilentlyContinue)) { New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null }
If (!(Get-PSDrive HKLM -ErrorAction SilentlyContinue)) { New-PSDrive -Name HKLM -PSProvider Registry -Root HKEY_LOCAL_MACHINE | Out-Null }

###

$Tweaks = @(
    "EnableDevMode",
    "EnableWinInsiderProgram",

    "SetDesktopWallpaper",
    "EnableDarKMode",
    # "EnableWinAccentColor", #FIXIT
    # "EnableWinAccentOpt1",
    "EnableWinAccentOpt2",

    # "SetLockSrceenBackground", #FIXIT
    "DisableLockScreenTips",
    # "DisableStartSuggestions",
    # "ChooseStartFolders", #FIXIT
    "EnableAeroPeek",
    "HideSearchBox",
    "HideCortanaButton",
    "ShowKeyboardButton",
    "InkWorkspaceButton", 
    "HideMeetNowButton",
    "HidePeopleButton",
    
    "SetDPIScale",
    "DisableNotificationOpt",
    "UpdatePowerPlan",
    "DisableTabletMode",
    "DisableWinSnapOpt",
    "DisableTimeLineSuggestion",

    "RemoveFileExplorerAds",
    "ShowFileExtensions",
    # "DisableRecentFiles",
    "DisableFrequentFolders",
    "EnableRecycleBinNavPane",
    "AddCustomQuickAccessBar",

    "EnableContextMenuOpts",
    # "EnableWinFloatSearch",
    "EnablePCLogMessage",
    "DisableWinShake",
    "EnableLaunchLastClick",
    "SetIconSpacingX"
    # "DefaultRecycleBinIcon"
)

###

Function EnableDevMode {
    Write-Host "Enabling Developer Mode..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
}

Function EnableWinInsiderProgram {
    Write-Host "Enabling Windows Insider Program..."
    $Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }    
    Set-ItemProperty -Path $Path -Name "AllowBuildPreview" -Type Dword -Value 1
}

#---

Function SetDesktopWallpaper {    
    Write-Host "Changing Desktop Wallpaper..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaper" -Type String -Value ""
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "Background" -Type String -Value "51 51 51"
}

Function EnableDarKMode {
    Write-Host "Enabling Dark Mode..."
    $Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Set-ItemProperty -Path $Path -Name "SystemUsesLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "AppsUseLightTheme" -Type DWord -Value 0
}

<# FIXIT #>
Function EnableWinAccentColor {
    Write-Host "Applying Windows Color..."
    $Path = "HKCU:\SOFTWARE\Microsoft\Windows\DWM"
    Set-ItemProperty -Path $Path -Name "AccentColor" -Type DWord -Value 4285f4
    Set-ItemProperty -Path $Path -Name "AccentColorInactive" -Type DWord -Value 6C6066
}

Function EnableWinAccentOpt1 {
    Write-Host "Showing Accent Colors: Start, Taskbar, and Action Center..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Type Dword -Value 1
}

Function EnableWinAccentOpt2 {
    Write-Host "Showing Accent Colors: Title Bars and Window Borders..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorPrevalence" -Type Dword -Value 1
}

#---

<# FIXIT #>
Function SetLockSrceenBackground {
    Write-Host "Changing Lock Screen Background..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "LockScreenImage" -Type String -Value "%WINDIR%\Web\Wallpaper\Windows\img0.jpg"
}

Function DisableLockScreenTips {
    Write-Host "Disabling Lock Screen option: fun facts, tips, and more..."
	$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    Set-ItemProperty -Path $Path -Name "RotatingLockScreenOverlayEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path $Path -Name "RotatingLockScreenOverlayVisible" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
}

Function DisableStartSuggestions {
    Write-Host "Disabling Star Menu Options: App Suggestions..."
	$Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
	Set-ItemProperty -Path $Path -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path $Path -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
}

<# FIXIT #>
Function ChooseStartFolders {
    Write-Host "Choosing Which Folder Appear on Start..."
    $Path = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Start"
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderDocuments" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderDownloads" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderFileExplorer" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderMusic" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderNetwork" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderPersonalFolder" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderPictures" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderSettings" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderVideos" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderDocuments_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderDownloads_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderFileExplorer_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderMusic_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderNetwork_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderPersonalFolder_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderPictures_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderSettings_ProviderSet" -Type DWord -Value 1
    Set-ItemProperty -Path $Path -Name "AllowPinnedFolderVideos_ProviderSet" -Type DWord -Value 1
}

#---

Function EnableAeroPeek {
    Write-Host "Enabling Aero Peek (corner hover)"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewDesktop"  -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
}

Function HideSearchBox {
   	Write-Output "Hiding Taskbar Search Box..."
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
}

Function HideCortanaButton {
 	Write-Output "Hiding Taskbar Cortana Button..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
}

Function ShowKeyboardButton {
    Write-Host "Showing Touch Keyboard Button..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Type DWord -Value 1
}

Function InkWorkspaceButton {
    Write-Host "Showing Ink Workspace Button..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" -Name "PenWorkspaceButtonDesiredVisibility" -Type DWord -Value 1
}

Function HideMeetNowButton {
    Write-Host "Hiding Meet Now Button on Taskbar..."
    $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name "HideSCAMeetNow" -Type DWord -Value 1
}

Function HidePeopleButton {
    Write-Host "Hiding People Button on Taskbar..."
    $Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name "HidePeopleBar" -Type DWord -Value 1
   	#Write-Output "Hiding People icon..."
    $Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
	Set-ItemProperty -Path $Path -Name "PeopleBand" -Type DWord -Value 0
}

#---
#---

Function SetDPIScale {
    Write-Host "Setting Custom DPI Scaling Level..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Type DWord -Value 120 # 125%
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Type DWord -Value 1
}

#---

Function DisableNotificationOpt {
    Write-Host "Disabling Notification Options: lock screen, suggestions..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" -Name "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
    $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }    
    Set-ItemProperty -Path $Path -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
}

#---

Function UpdatePowerPlan {
    Write-Host "Updating Screen Timeout..."
    Powercfg -Change -monitor-timeout-ac 5 # on battery
    Powercfg -Change -monitor-timeout-dc 10 # plugged in

    Write-Host "Updating Sleep Timeout..."
    Powercfg -Change -standby-timeout-ac 15 # on battery
    Powercfg -Change -standby-timeout-dc 30 # plugged in
}

#---

Function DisableTabletMode {
    Write-Host "Disabling Tablet Mode..."
    $Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell"
    Set-ItemProperty -Path $Path -Name "TabletMode" -Type DWord -Value 0
    Set-ItemProperty -Path $Path -Name "SignInMode" -Type DWord -Value 2
}

#---

Function DisableWinSnapOpt {
    Write-Host "Disabling Windows Snap Option..."
    $Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Write-Host "...automatically size it to fill available space"
    Set-ItemProperty -Path $Path -Name "SnapFill" -Type DWord -Value 0
    Write-Host "...show what I can snap next to it"
    Set-ItemProperty -Path $Path -Name "SnapAssist" -Type DWord -Value 0
    Write-Host "...simultaneously resize any adjacent snapped window"
    Set-ItemProperty -Path $Path -Name "JointResize" -Type DWord -Value 0    
}

Function DisableTimeLineSuggestion {
    Write-Host "Disabling Timeline Suggestions..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
}

#---
#---
 
Function RemoveFileExplorerAds {
    Write-Host "Removing Sync Provider Notifications (file explorer ads)..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications" -Type DWord -Value 0
}

Function ShowFileExtensions {
    Write-Host "Showing File Extensions..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
}

Function DisableRecentFiles {
    Write-Host "Disable Quick Access: Recent Files..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
}

Function DisableFrequentFolders {
    Write-Host "Disable Quick Access: Frequent Folders..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
}

Function EnablingRecycleBinNavPane {
    Write-Host "Enabling File Explore Nav Pane: Recycle Bin..."
    $Path = "HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name "System.IsPinnedToNameSpaceTree" -Type DWord -Value 1
}

Function AddCustomQuickAccessBar {
    Write-Host "Adding Custom Quick Access Tool Bar Options..."
    Write-Host "...properties, new folder, size all columns to fit, empty recycle bin, eject, undo"

    $BinaryHEX = (
        "hex:3c,73,69,71,3a,63,75,73,74,6f,6d,55,49,20,78,6d,6c,6e,73,3a,73,\
        69,71,3d,22,68,74,74,70,3a,2f,2f,73,63,68,65,6d,61,73,2e,6d,69,63,72,6f,73,\
        6f,66,74,2e,63,6f,6d,2f,77,69,6e,64,6f,77,73,2f,32,30,30,39,2f,72,69,62,62,\
        6f,6e,2f,71,61,74,22,3e,3c,73,69,71,3a,72,69,62,62,6f,6e,20,6d,69,6e,69,6d,\
        69,7a,65,64,3d,22,74,72,75,65,22,3e,3c,73,69,71,3a,71,61,74,20,70,6f,73,69,\
        74,69,6f,6e,3d,22,30,22,3e,3c,73,69,71,3a,73,68,61,72,65,64,43,6f,6e,74,72,\
        6f,6c,73,3e,3c,73,69,71,3a,63,6f,6e,74,72,6f,6c,20,69,64,51,3d,22,73,69,71,\
        3a,31,32,33,38,34,22,20,76,69,73,69,62,6c,65,3d,22,74,72,75,65,22,20,61,72,\
        67,75,6d,65,6e,74,3d,22,30,22,20,2f,3e,3c,73,69,71,3a,63,6f,6e,74,72,6f,6c,\
        20,69,64,51,3d,22,73,69,71,3a,31,32,33,33,36,22,20,76,69,73,69,62,6c,65,3d,\
        22,74,72,75,65,22,20,61,72,67,75,6d,65,6e,74,3d,22,30,22,20,2f,3e,3c,73,69,\
        71,3a,63,6f,6e,74,72,6f,6c,20,69,64,51,3d,22,73,69,71,3a,31,32,33,35,37,22,\
        20,76,69,73,69,62,6c,65,3d,22,66,61,6c,73,65,22,20,61,72,67,75,6d,65,6e,74,\
        3d,22,30,22,20,2f,3e,3c,73,69,71,3a,63,6f,6e,74,72,6f,6c,20,69,64,51,3d,22,\
        73,69,71,3a,31,36,31,32,39,22,20,76,69,73,69,62,6c,65,3d,22,66,61,6c,73,65,\
        22,20,61,72,67,75,6d,65,6e,74,3d,22,30,22,20,2f,3e,3c,73,69,71,3a,63,6f,6e,\
        74,72,6f,6c,20,69,64,51,3d,22,73,69,71,3a,31,32,33,35,32,22,20,76,69,73,69,\
        62,6c,65,3d,22,66,61,6c,73,65,22,20,61,72,67,75,6d,65,6e,74,3d,22,30,22,20,\
        2f,3e,3c,73,69,71,3a,63,6f,6e,74,72,6f,6c,20,69,64,51,3d,22,73,69,71,3a,31,\
        32,34,38,35,22,20,76,69,73,69,62,6c,65,3d,22,74,72,75,65,22,20,61,72,67,75,\
        6d,65,6e,74,3d,22,30,22,20,2f,3e,3c,73,69,71,3a,63,6f,6e,74,72,6f,6c,20,69,\
        64,51,3d,22,73,69,71,3a,31,34,35,39,32,22,20,76,69,73,69,62,6c,65,3d,22,74,\
        72,75,65,22,20,61,72,67,75,6d,65,6e,74,3d,22,30,22,20,2f,3e,3c,73,69,71,3a,\
        63,6f,6e,74,72,6f,6c,20,69,64,51,3d,22,73,69,71,3a,31,35,34,32,35,22,20,76,\
        69,73,69,62,6c,65,3d,22,74,72,75,65,22,20,61,72,67,75,6d,65,6e,74,3d,22,30,\
        22,20,2f,3e,3c,73,69,71,3a,63,6f,6e,74,72,6f,6c,20,69,64,51,3d,22,73,69,71,\
        3a,31,36,31,32,38,22,20,76,69,73,69,62,6c,65,3d,22,74,72,75,65,22,20,61,72,\
        67,75,6d,65,6e,74,3d,22,30,22,20,2f,3e,3c,2f,73,69,71,3a,73,68,61,72,65,64,\
        43,6f,6e,74,72,6f,6c,73,3e,3c,2f,73,69,71,3a,71,61,74,3e,3c,2f,73,69,71,3a,\
        72,69,62,62,6f,6e,3e,3c,2f,73,69,71,3a,63,75,73,74,6f,6d,55,49,3e"
    )

    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" -Name "QatItems" -Type Binary -Value $BinaryHEX
}

#---
#---

Function EnableContextMenuOpts {
    Write-Host "Enabling Context Menu Options..."
    $Path = "HKCR:\Allfilesystemobjects\shellex\ContextMenuHandlers"
    Write-Host "...Adding 'Copy To'"
    If (!(Test-Path ("$Path\Copy To..."))) { New-Item -Path ("$Pa -Forceth\Copy To...") | Out-Null }
    Set-Item -Path ("$Path\Copy To...") -Value "{C2FBB630-2971-11d1-A18C-00C04FD75D13}"
    Write-Host "...Adding 'Move To'"
    If (!(Test-Path ("$Path\Move To..."))) { New-Item -Path ("$Pa -Forceth\Move To...") | Out-Null }
    Set-Item -Path ("$Path\Move To...") -Value "{C2FBB631-2971-11d1-A18C-00C04FD75D13}" 
}

Function EnableWinFloatSearch {
    Write-Host "Enabling Windows Search Bar (Float)..."
    $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
    Set-ItemProperty -Path $Path -Name "ImmersiveSearch" -Type DWord -Value 1
    $Path = "$Path\Flighting\Override"
	If (!(Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
    Set-ItemProperty -Path $Path -Name "CenterScreenRoundedCornerRadius" -Type DWord -Value 9
    Set-ItemProperty -Path $Path -Name "ImmersiveSearchFull" -Type DWord -Value 0
}

Function EnablePCLogMessage {
    Write-Host "Enabling Verbose Log Message on StartUp/ShutDown..."
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Type DWord -Value 1
}

Function DisableWinShake {
    Write-Host "Disabling Shake To Minimize..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -Type DWord -Value 1
}

Function EnableLaunchLastClick {
    # Default: ctrl + click
    Write-Host "Enabling Last Active Click (Launcher App)..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LastActiveClick" -Type DWord -Value 1
}

Function SetIconSpacingX {
    # horizontal spacing, e.g. -480 (near) | -2750 (far) | -1130 (default)
    Write-Host "Changing Desktop Icon Spacing..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Type String -Value "-1100"
}

Function DefaultRecycleBinIcon {
    Write-Host "Defaulting to Recycle Bin Icon..."
    $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon"
    Set-ItemProperty -Path $Path -Name "empty" -Type ExpandString -Value "%SystemRoot%\System32\imageres.dll,-55"
    Set-ItemProperty -Path $Path -Name "full" -Type ExpandString -Value "%SystemRoot%\System32\imageres.dll,-54"
}

###

# Invoke Selected Tweaks
# $Tweaks | ForEach { Invoke-Expression $_ }

###

#TEST
#Windows Action Center: Quick Action
#HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions
#\DefaultPins -Name "0" -Type String -Value "Add Quick Action Name"
