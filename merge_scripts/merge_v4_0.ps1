$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v4.0 assets ==" -ForegroundColor Cyan

$docs = @{
"173_Mobile_App_Readiness_Suite\Mobile_App_Readiness_Suite.md" = "# Mobile App Readiness Suite`n`nPrepares the product for app-store style use: onboarding, privacy, reminders, mobile-first flows, reports, and native/PWA architecture."
"174_App_Store_Preparation\App_Store_Preparation.md" = "# App Store Preparation`n`nApp name, subtitle, description, keywords, screenshots, privacy policy, terms, support URL, safety disclaimers, and review-risk notes."
"175_Mobile_Onboarding_Wizard\Mobile_Onboarding_Wizard.md" = "# Mobile Onboarding Wizard`n`nGuides users through purpose, relationship stage, privacy choices, reminder preferences, companion style, and first daily check-in."
"176_Couple_Profile_Setup\Couple_Profile_Setup.md" = "# Couple Profile Setup`n`nCaptures relationship nickname, stage, shared values, goals, bonding style, preferred rituals, communication preferences, and privacy level."
"177_Relationship_Stage_Router\Relationship_Stage_Router.md" = "# Relationship Stage Router`n`nRoutes users into Just Starting, Dating, Engaged, Married, Parenting, Renewal, Recovery, or Makeover flows."
"178_Daily_Companion_Home\Daily_Companion_Home.md" = "# Daily Companion Home`n`nMobile home with mood, score-lift quest, reminder, Genie prompt, memory cue, and quick log button."
"179_Journey_Quest_Center\Journey_Quest_Center.md" = "# Journey Quest Center`n`nQuest catalog, completion tracking, XP, streaks, celebrations, weekly challenges, and future postcards."
"180_Report_Center\Report_Center.md" = "# Report Center`n`nDaily cards, grievance reports, weekly recaps, makeover reports, and score-lift plans."
"181_Reminder_Preference_Center\Reminder_Preference_Center.md" = "# Reminder Preference Center`n`nDaily log reminders, after-meeting reminders, weekly recaps, quest nudges, and quiet hours."
"182_Privacy_Consent_Center\Privacy_Consent_Center.md" = "# Privacy and Consent Center`n`nPublic/demo vs private mode, consent, data deletion, export, retention, and safety disclaimer."
"183_Export_Center\Export_Center.md" = "# Export Center`n`nExport Markdown, CSV, PDF-ready reports, sanitized summaries, weekly recaps, and journey packs."
"184_Mobile_Screen_Inventory\Mobile_Screen_Inventory.md" = "# Mobile Screen Inventory`n`nSplash, onboarding, privacy, home, daily log, quest, Genie, reports, trends, settings, export, and safety screens."
"185_Native_App_Architecture\Native_App_Architecture.md" = "# Native App Architecture`n`nRecommended: React Native/Expo, Flutter, or Capacitor/PWA shell. Streamlit remains demo/admin/workbench surface."
"186_PWA_Bridge_Plan\PWA_Bridge_Plan.md" = "# PWA Bridge Plan`n`nManifest, icons, service worker strategy, home-screen install, offline-safe drafts, and responsive routes."
"187_App_Store_Metadata\App_Store_Metadata.md" = "# App Store Metadata Draft`n`nName: Purushartha Companion. Subtitle: Relationship growth, rituals, and daily repair."
"188_Safety_Crisis_Mode\Safety_Crisis_Mode.md" = "# Safety and Crisis Mode`n`nNever optimize relationship continuation over safety. Provide emergency reminders and professional help prompts."
"189_Release_Notes\v4.0_Mobile_App_Readiness_Suite.md" = "# v4.0 Release Notes`n`nAdds app-store preparation, onboarding, profile setup, reminders, privacy center, report center, export center, native architecture, and PWA bridge."
"190_Backlog_vNext\v4.1_Backlog.md" = "# v4.1 Backlog`n`nPWA manifest, mobile CSS, app icons, local storage, reminder mock scheduler, onboarding persistence, profile persistence, report export hardening."
}

foreach ($path in $docs.Keys) {
    $dir = Split-Path $path
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $docs[$path] | Set-Content -Encoding UTF8 $path
}

@'
screen_id,screen_name,purpose,priority
M001,Splash and Safety Intro,Introduce app and safety disclaimer,High
M002,Onboarding Wizard,Capture stage privacy reminders and goals,High
M003,Companion Home,Daily hub for mood quest Genie and reminders,High
M004,Daily Log,One-minute check-in,High
M005,Quest Center,Positive score-lift activities,High
M006,Genie Companion,Guided navigation and encouragement,High
M007,Grievance Report Builder,Structured concerns into action plans,High
M008,Report Center,Download and view reports,Medium
M009,Trend Dashboard,View scores streaks and patterns,Medium
M010,Privacy Center,Consent export retention and delete controls,High
M011,Reminder Settings,Daily and event-triggered reminders,Medium
M012,Export Center,Markdown CSV PDF-ready exports,Medium
'@ | Set-Content -Encoding UTF8 "184_Mobile_Screen_Inventory\mobile_screen_inventory.csv"

@'
metadata_key,value
app_name,Purushartha Companion
subtitle,Relationship growth rituals and daily repair
category,Lifestyle
secondary_category,Health and Fitness
keywords,relationship,journal,couples,habits,gratitude,communication,repair,goals
support_url,https://github.com/ajaytester007/Purushartha_Family_Continuity_OS
privacy_url,To be created before App Store submission
terms_url,To be created before App Store submission
medical_disclaimer,Not therapy medical legal or crisis service
'@ | Set-Content -Encoding UTF8 "187_App_Store_Metadata\app_store_metadata_seed.csv"

Write-Host "v4.0 assets merged." -ForegroundColor Green
