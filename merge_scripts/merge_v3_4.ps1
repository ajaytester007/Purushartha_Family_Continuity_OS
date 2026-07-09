$ErrorActionPreference="Stop"
$docs=@{
"156_Feed_Forward_Journey_Studio\Feed_Forward_Journey_Studio.md"="# Feed Forward Journey Studio`n`nBuild the next chapter instead of only analyzing the last problem."
"157_Relationship_Makeover\Relationship_Makeover.md"="# Relationship Makeover`n`nPreserve strengths, release one habit, begin one ritual, create one memory."
"158_Narrative_Storyboard_Engine\Narrative_Storyboard_Engine.md"="# Narrative Storyboard Engine`n`nWhere We Are -> What We Value -> What We Want More Of -> Our Next Adventure -> The Memory We Create."
"159_Genie_Companion\Genie_Companion.md"="# Genie Companion`n`nA warm guide for onboarding, quests, makeovers, repair prompts, and celebrations."
"160_Positive_Quest_Engine\Positive_Quest_Engine.md"="# Positive Quest Engine`n`nAppreciation Spark, Curiosity Date, Memory Lane, Shared Dream Hour, Team Us, Future Postcard."
"161_Journey_Map\Journey_Map.md"="# Journey Map`n`nTrust, Friendship, Communication, Repair, Teamwork, Shared Vision, Joy, Boundaries, Affection, Growth."
"162_Mobile_Positive_UX\Mobile_Positive_UX.md"="# Mobile Positive UX`n`nOne-minute check-ins, story cards, swipeable quests, Genie entry point, progress rings, celebrations, optional reminders."
"163_Release_Notes\v3.4_Feed_Forward_Journey_Studio.md"="# v3.4 Release Notes`n`nFeed Forward Mode, Makeovers, Storyboards, Genie Companion, Positive Quests, Journey Maps."
"164_Backlog_vNext\v3.5_Backlog.md"="# v3.5 Backlog`n`nJourney profiles, chapter history, quest tracking, celebrations, PWA shell, voice reflections, consent-based Genie memory."
}
foreach($x in $docs.Keys){$d=Split-Path $x;New-Item -ItemType Directory -Force $d|Out-Null;$docs[$x]|Set-Content -Encoding UTF8 $x}
Write-Host "v3.4 assets merged." -ForegroundColor Green
