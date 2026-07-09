$ErrorActionPreference = "Stop"
Write-Host "== Merging Purushartha OS v3.5 assets ==" -ForegroundColor Cyan
$docs = @{
"165_Journey_Identity\Journey_Identity.md" = "# Journey Identity`n`nA warm couple profile: relationship name, current chapter, guiding values, strengths, growth theme, shared dream, and preferred bonding style."
"166_Quest_System\Quest_System.md" = "# Quest System`n`nSmall positive quests that raise relationship momentum through appreciation, curiosity, teamwork, joy, repair, and future planning."
"167_Celebrations_Streaks\Celebrations_Streaks.md" = "# Celebrations and Streaks`n`nStars, XP, streaks, chapter badges, celebration cards, and kind encouragement."
"168_Weekly_Story_Recap\Weekly_Story_Recap.md" = "# Weekly Story Recap`n`nA narrative recap of wins, tenderness points, growth areas, completed quests, and next week's intention."
"169_Future_Postcards\Future_Postcards.md" = "# Future Postcards`n`nWrite a note from your future selves thanking today's couple for one wise choice."
"170_Release_Safety_Gate\Release_Safety_Gate.md" = "# Release Safety Gate`n`nEvery release compiles app.py and validates duplicate Streamlit keys before publishing, tagging, or Wiki updates."
"171_Release_Notes\v3.5_Journey_Identity_and_Quest_System.md" = "# v3.5 Release Notes`n`nAdds Journey Identity, Quest Board, XP/streaks, weekly story recap, future postcards, Genie home upgrade, and mandatory release safety gate."
"172_Backlog_vNext\v3.6_Backlog.md" = "# v3.6 Backlog`n`nPWA manifest, mobile home screen, app icons, reminder preferences, push-notification design, offline local mode, onboarding walkthrough."
}
foreach ($path in $docs.Keys) {
    $dir = Split-Path $path
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    $docs[$path] | Set-Content -Encoding UTF8 $path
}
@'
quest_id,quest_name,dimension,xp,description
Q001,Appreciation Spark,Friendship,10,Share one specific appreciation today.
Q002,Promise Keeper,Trust,15,Make one small promise and keep it.
Q003,Curiosity Date,Friendship,15,Ask three new questions with warmth.
Q004,Team Us,Teamwork,15,Complete one practical task together.
Q005,Joy Spark,Joy,10,Recreate a tiny happy memory.
Q006,Calm Repair,Communication,20,Name one fact one impact and one request kindly.
Q007,Future Postcard,Shared Vision,15,Write a note from your future selves.
'@ | Set-Content -Encoding UTF8 "166_Quest_System\quest_catalog.csv"
Write-Host "v3.5 assets merged." -ForegroundColor Green
