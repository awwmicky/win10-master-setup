<# DEBLOAT APP #>

###

$Tweaks = @(
#    "ShowAllList"
#    "ShowCustomList"
#    "ShowSoftwareList"
#    "ShowMicrosoftStoreList"
#    "ShowWindowsList"

    #"DisableOneDrive"
    #"DisableCortana"
    #"DisableMsftEdge"

    # "UninstallMsftBloat"
    # "UninstallThirdPartyBloat"
    # "DebloatWindowsApps"

    "InstallApp_1"
    # "UninstallApp_1"
)

###

Function ShowAllList {
    Clear-Host

#    Write-Host "Showing All Windows Installed Apps & Packages List..."
#    Get-AppxPackage | Select-Object Name, PackageFullName | Format-Table -AutoSize

#    Write-Host "Showing Microsoft Store Apps List..."
#    Get-AppxProvisionedPackage -Online | Select-Object DisplayName,PackageName | Format-Table -AutoSize

#    Write-Host "Showing Vendor's Apps List..."
#    Get-CimInstance -Class Win32_Product | Select-Object Name, Vendor, Version | Format-Table -AutoSize

#    Write-Host "Showing Windows System Programs List..."
#    Get-AppxPackage -PackageTypeFilter Main | ? { $_.SignatureKind -eq "System" } | Sort Name | Format-Table Name, InstallLocation

#    Write-Host "Showing List of Running Apps List..."
#    Get-Process | Where-Object { $_.MainWindowTitle } | Format-Table ID, Name, Mainwindowtitle �AutoSize
}

Function ShowCustomList {
    Clear-Host

    Write-Host "Showing Software Applications List..."
    
    Get-ItemProperty "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object {$_.DisplayName -ne $null -and $_.SystemComponent -ne "1"} |
            Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | 
                Format-Table �AutoSize

    Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
        Where-Object {$_.DisplayName -ne $null -and $_.SystemComponent -ne "1"} |
            Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
                Format-Table �AutoSize
}

Function ShowSoftwareList {

}

Function ShowMicrosoftStoreList {

}

Function ShowWindowsList {

}

###

Function UninstallMsftBloat {
	Write-Output "Uninstalling Default Microsoft Applications..."
	
    $MsftAppsList = @(
        "Microsoft.3DBuilder"
    	"Microsoft.AppConnector"
    	"Microsoft.BingFinance"
    	"Microsoft.BingNews"
    	"Microsoft.BingSports"
	    "Microsoft.BingTranslator"
	    # "Microsoft.BingWeather"
	    "Microsoft.CommsPhone"
	    "Microsoft.ConnectivityStore"
	    "Microsoft.GetHelp"
	    "Microsoft.Getstarted"
	    "Microsoft.Messaging"
	    "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
	    "Microsoft.MicrosoftPowerBIForWindows"
	    "Microsoft.MicrosoftSolitaireCollection"
	    "Microsoft.MicrosoftStickyNotes"
        "Microsoft.MixedReality.Portal"
        "Microsoft.MSPaint"
	    "Microsoft.NetworkSpeedTest"
	    "Microsoft.Office.OneNote"
	    "Microsoft.Office.Lens"
	    "Microsoft.Office.Sway"
	    "Microsoft.OneConnect"
	    "Microsoft.People"
	    "Microsoft.Print3D"
	    "Microsoft.RemoteDesktop"
	    "Microsoft.Wallet"
	    "Microsoft.WindowsAlarms"
	    "Microsoft.WindowsCamera"
	    # "microsoft.windowscommunicationsapps"
	    "Microsoft.WindowsFeedbackHub"
	    "Microsoft.WindowsMaps"
	    "Microsoft.WindowsPhone"
	    "Microsoft.WindowsSoundRecorder"
        # "Microsoft.Windows.Photos"
        # "Microsoft.ZuneMusic"
        # "Microsoft.ZuneVideo"

        # "Microsoft.MicrosoftEdge"
        # "Microsoft.549981C3F5F10" # Cortana
    )

    ForEach ($MsftApp in $MsftAppsList) {
    	Get-AppxPackage -Name $MsftApp | Remove-AppxPackage
        Write-Output "Removed App - $MsftApp"
    }
}

###

Function UninstallThirdPartyBloat {
	Write-Output "Uninstalling Default Third Party Applications..."
	
    $ThirdPartyAppsList = @(
        "2414FC7A.Viber"
    	"41038Axilesoft.ACGMediaPlayer"
	    "46928bounde.EclipseManager"
	    "4DF9E0F8.Netflix"
	    "64885BlueEdge.OneCalendar"
	    "7EE7776C.LinkedInforWindows"
	    "828B5831.HiddenCityMysteryofShadows"
	    "89006A2E.AutodeskSketchBook"
	    "9E2F88E3.Twitter"
	    "A278AB0D.DisneyMagicKingdoms"
	    "A278AB0D.MarchofEmpires"
	    "ActiproSoftwareLLC.562882FEEB491"
	    "AdobeSystemsIncorporated.AdobePhotoshopExpress"
	    "CAF9E577.Plex"
	    "D52A8D61.FarmVille2CountryEscape"
	    "D5EA27B7.Duolingo-LearnLanguagesforFree"
	    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
#        "DolbyLaboratories.DolbyAccess"
	    "Drawboard.DrawboardPDF"
	    "Facebook.Facebook"
	    "flaregamesGmbH.RoyalRevolt2"
	    "GAMELOFTSA.Asphalt8Airborne"
	    "KeeperSecurityInc.Keeper"
	    "king.com.BubbleWitch3Saga"
	    "king.com.CandyCrushSodaSaga"
	    "PandoraMediaInc.29680B314EFC2"
	    "SpotifyAB.SpotifyMusic"
	    "WinZipComputing.WinZipUniversal"
	    "XINGAG.XING"
    )

    ForEach ($TPApp in $ThirdPartyAppsList) {
    	Get-AppxPackage -Name $TPApp | Remove-AppxPackage
        Write-Output "Removed App - $TPApp"
    }
}

###

Function DebloatWindowsApps {
	Write-Output "Remove Unnecessary Windows Applications..."

    $BloatwareList = @(

        ## Unnecessary Windows 10 AppX Apps
        "Microsoft.BingFoodAndDrink"
        "Microsoft.BingHealthAndFitness"
        "Microsoft.BingNews"
        "Microsoft.BingTravel"
        # "Microsoft.BingWeather"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftSolitaireCollection"
        # "Microsoft.MicrosoftStickyNotes"
        "Microsoft.MSPaint"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.News"
        "Microsoft.Office.OneNote"
        "Microsoft.Office.Lens"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.SkypeApp"
        # "Microsoft.Todos"
        # "Microsoft.Whiteboard"
        "Microsoft.WindowsAlarms"
        # "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        # "Microsoft.StorePurchaseApp"

        ## Microsoft Office Appx Apps
        "*Microsoft.Office.Desktop.Access*" 
        "*Microsoft.Office.Desktop.Excel*" 
        "*Microsoft.Office.Desktop.Outlook*" 
        "*Microsoft.Office.Desktop.PowerPoint*" 
        "*Microsoft.Office.Desktop.Publisher*" 
        "*Microsoft.Office.Desktop.Word*" 
        "*Microsoft.Office.Desktop*"

        ## Sponsored Windows 10 AppX Apps
        ## Add sponsored/featured apps to remove in the "*AppName*" format
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*BubbleWitch3Saga*"
        "*CandyCrush*"
#        "*Dolby*"
        "*Duolingo-LearnLanguagesforFree*"
        "*EclipseManager*"
        "*Facebook*"
        "*FalloutShelter*"
        "*FarmVille2CountryEscape*"
        "*Flipboard*"
        "*GardenScapes*"
        "*Hulu*"
        "*Lens*"
        "*Minecraft*"
        "*Netflix*"
        "*PandoraMediaInc*"
        "*Royal Revolt*"
        "*Speed Test*"
        "*Spotify*"
        "*SkypeApp*"
        "*Sway*"
        "*Twitter*"
        "*Wunderlist*"
        "*XboxApp*"

        
        ## Optional: Typically not removed but optional
#        "*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
#        "*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
#        "*Microsoft.WindowsStore*"
#        "*Microsoft.WindowsCalculator*"
#        "*Microsoft.Windows.Photos*"
#        "*Microsoft.ZuneMusic*"
#        "*Microsoft.ZuneVideo*"
    )

    ForEach ($Bloat in $BloatwareList) {
        Get-AppxPackage -Name $Bloat| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | 
            Where-Object DisplayName -like $Bloat | 
                Remove-AppxProvisionedPackage -Online
        Write-Output "Removed App - $Bloat"
    }
}

#---

Function InstallApp_1 {
    $App = "microsoft.windowscommunicationsapps"
	Get-AppxPackage -AllUsers $App | ForEach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
}

Function UninstallApp_1 {}

###

# Invoke Selected Tweaks
$Tweaks | ForEach { Invoke-Expression $_ }

###

#Check & Delete

## Microsoft.Advertising.Xaml

# Microsoft.MicrosoftEdge.Stable
# Microsoft.MicrosoftEdgeDevToolsClient

# Windows.CBSPreview
# MicrosoftWindows.Client.CBS

###

#People Hub	
# Microsoft.Windows.PeopleExperienceHost
# Microsoft.Windows.PinningConfirmationDialog
# Microsoft.Windows.SecHealthUI
# Microsoft.Windows.SecondaryTileExperience
# Microsoft.Windows.SecureAssessmentBrowser

#Cortana	
# Microsoft.Windows.Cortana
# Microsoft.Windows.Holographic.FirstRun
# Microsoft.Windows.OOBENetworkCaptivePort
# Microsoft.Windows.OOBENetworkConnectionFlow
# Microsoft.Windows.ParentalControls

#Microsoft Edge
# Microsoft.MicrosoftEdge
# Microsoft.MicrosoftEdgeDevToolsClient
# Microsoft.PPIProjection
# Microsoft.Win32WebViewHost
# Microsoft.Windows.Apprep.ChxApp
# Microsoft.Windows.AssignedAccessLockApp
# Microsoft.Windows.CapturePicker
# Microsoft.Windows.CloudExperienceHost
# Microsoft.Windows.ContentDeliveryManager

#Xbox
#... Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage               # xbox live in-game experience
##- Get-AppxPackage *Microsoft.XboxGameCallableUI* | Remove-AppxPackage    # xbox feedback
# Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage         # xbox game bar plugin
#- Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage      # xbox game bar
# Get-appxpackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage # xbox game speech window
# Get-appxpackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage    # xbox identity provider
#- Get-AppxPackage *XboxOneSmartGlass* | Remove-AppxPackage                # xbox one smartglass

#remove xbox game bar
# Get-appxprovisionedpackage �online | where-object {$_.packagename �like "*Microsoft.XboxGamingOverlay*"} | remove-appxprovisionedpackage �online