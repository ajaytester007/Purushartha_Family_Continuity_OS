$ErrorActionPreference = "Stop"
$src = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
$wiki = "C:\GitHub\Purushartha_Family_Continuity_OS.wiki"
Set-Location $wiki
git pull --rebase | Out-Host
$dirs = @("173_Mobile_App_Readiness_Suite","174_App_Store_Preparation","175_Mobile_Onboarding_Wizard","176_Couple_Profile_Setup","177_Relationship_Stage_Router","178_Daily_Companion_Home","179_Journey_Quest_Center","180_Report_Center","181_Reminder_Preference_Center","182_Privacy_Consent_Center","183_Export_Center","184_Mobile_Screen_Inventory","185_Native_App_Architecture","186_PWA_Bridge_Plan","187_App_Store_Metadata","188_Safety_Crisis_Mode","189_Release_Notes","190_Backlog_vNext")
foreach ($d in $dirs) {
    Get-ChildItem (Join-Path $src $d) -Recurse -Filter *.md | ForEach-Object {
        $rel = $_.FullName.Substring($src.Length).TrimStart("\")
        $name = $rel -replace "\\","-" -replace "_","-" -replace "\.md$",".md"
        Copy-Item $_.FullName (Join-Path $wiki $name) -Force
    }
}
@'
# Purushartha Family Continuity OS

## v4.0 Mobile App Readiness Suite

- [[Mobile App Readiness Suite|173-Mobile-App-Readiness-Suite-Mobile-App-Readiness-Suite]]
- [[App Store Preparation|174-App-Store-Preparation-App-Store-Preparation]]
- [[Mobile Onboarding Wizard|175-Mobile-Onboarding-Wizard-Mobile-Onboarding-Wizard]]
- [[Privacy and Consent Center|182-Privacy-Consent-Center-Privacy-and-Consent-Center]]
- [[Native App Architecture|185-Native-App-Architecture-Native-App-Architecture]]
- [[PWA Bridge Plan|186-PWA-Bridge-Plan-PWA-Bridge-Plan]]
- [[App Store Metadata|187-App-Store-Metadata-App-Store-Metadata]]
- [[Safety and Crisis Mode|188-Safety-Crisis-Mode-Safety-and-Crisis-Mode]]
- [[v4.0 Release Notes|189-Release-Notes-v4.0-Mobile-App-Readiness-Suite]]
- [[v4.1 Backlog|190-Backlog-vNext-v4.1-Backlog]]
'@ | Set-Content -Encoding UTF8 "Home.md"
git add .
git commit -m "Publish Wiki from v4.0 mobile app readiness pipeline"
if ($LASTEXITCODE -ne 0) { Write-Host "No Wiki changes to commit." -ForegroundColor Yellow }
git push | Out-Host
Set-Location $src
Write-Host "Wiki publish complete." -ForegroundColor Green
