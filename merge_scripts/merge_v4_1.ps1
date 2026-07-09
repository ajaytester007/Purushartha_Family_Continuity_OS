$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.1 assets ==" -ForegroundColor Cyan
$dirs = @("191_iPhone_PWA_Shell","192_Compatibility_Checklists","193_Trusted_Circle_Ratings","194_Game_Mode_Requirements","195_Diary_Mode_Requirements","196_Compatibility_Scoring_Model","197_Exit_Report_Model","199_Release_Notes","200_Backlog_vNext")
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }
"# iPhone PWA Shell`n`nZero-cost install path: Safari -> Share -> Add to Home Screen -> Add. If available, enable Open as Web App." | Set-Content -Encoding UTF8 "191_iPhone_PWA_Shell\iPhone_PWA_Shell.md"
@'
checklist_id,category,item,weight,answer_type,notes
P001,Primary Partners,Shared life purpose,5,scale_1_5,Long-term direction
P002,Primary Partners,Emotional maturity,5,scale_1_5,Anger repair regulation
P003,Primary Partners,Communication clarity,5,scale_1_5,Hard topics without contempt
P004,Primary Partners,Trust and fidelity posture,5,scale_1_5,Honesty boundaries transparency
P005,Primary Partners,Conflict repair capacity,5,scale_1_5,Apology correction retest
P006,Primary Partners,Household responsibility fit,4,scale_1_5,Chores errands bills routines
P007,Primary Partners,Financial compatibility,5,scale_1_5,Spending savings debt budget
P008,Primary Partners,Distance and logistics feasibility,4,scale_1_5,Travel relocation commute
P009,Primary Partners,Health and recovery support,4,scale_1_5,Sickness caregiving recovery
P010,Primary Partners,Happiness quotient,4,scale_1_5,Joy affection humor companionship
F001,Parents,Respectful family boundaries,5,scale_1_5,Support without control
F002,Parents,Cultural alignment,4,scale_1_5,Rituals food values celebrations
F003,Parents,Wedding union support,4,scale_1_5,Constructive launch support
F004,Parents,Budget realism,5,scale_1_5,Practical expectations
S001,Siblings and Friends,Trusted circle encouragement,3,scale_1_5,Lift the couple
S002,Siblings and Friends,Drama interference risk,4,scale_1_5,Low gossip triangulation
L001,Modern Life,Work-life balance,4,scale_1_5,Time energy availability
L002,Modern Life,Cost and logistics resilience,5,scale_1_5,Survive constraints
L003,Modern Life,Substitution creativity,3,scale_1_5,Happiness with alternatives
R001,Role Play,Episode teamwork,5,scale_1_5,Stress episode handling
R002,Role Play,Leadership and followership,4,scale_1_5,Lead support handoff
R003,Role Play,Recovery after mistake,5,scale_1_5,Mature after episode
'@ | Set-Content -Encoding UTF8 "192_Compatibility_Checklists\compatibility_checklist_seed.csv"
"# Compatibility Checklists`n`nFamilies: primary partners, parents, siblings, close friends, culture, budget, logistics, health, recovery, distance, happiness quotient, role-play, wedding launch, married-life readiness, exit reflection." | Set-Content -Encoding UTF8 "192_Compatibility_Checklists\Compatibility_Checklists.md"
"# Trusted Circle Ratings`n`nConstructive ratings from parents, siblings, close friends, mentors, or elders." | Set-Content -Encoding UTF8 "193_Trusted_Circle_Ratings\Trusted_Circle_Ratings.md"
"# Game Mode Requirements`n`nLevels, XP, stars, checklists, role-play timers, milestone signposts, trusted-circle ratings, weekly recaps, and exit reports." | Set-Content -Encoding UTF8 "194_Game_Mode_Requirements\Game_Mode_Requirements.md"
"# Diary Mode Requirements`n`nMood, episode notes, gratitude, concern, repair attempt, role-play outcome, budget/logistics, sickness/recovery, happiness substitutions." | Set-Content -Encoding UTF8 "195_Diary_Mode_Requirements\Diary_Mode_Requirements.md"
"# Compatibility Scoring Model`n`nScores: partner, family, trusted circle, budget/logistics, culture, health/recovery, happiness, role-play, repair, union readiness." | Set-Content -Encoding UTF8 "196_Compatibility_Scoring_Model\Compatibility_Scoring_Model.md"
"# Exit Report Model`n`nDignified exit report with lessons, maturity gained, gaps, repeated patterns, and advice for a future relationship game." | Set-Content -Encoding UTF8 "197_Exit_Report_Model\Exit_Report_Model.md"
"# v4.1 Release Notes`n`nAdds iPhone PWA shell, compatibility checklists, trusted-circle ratings, game mode, diary mode, scoring, and exit report requirements." | Set-Content -Encoding UTF8 "199_Release_Notes\v4.1_iPhone_PWA_and_Compatibility_Game_Mode.md"
"# v4.2 Backlog`n`nInteractive checklist engine, scoring reports, trusted-circle input, game cards, countdowns, avatars, themes, animated roadmap." | Set-Content -Encoding UTF8 "200_Backlog_vNext\v4.2_Backlog.md"
Write-Host "v4.1 assets merged." -ForegroundColor Green
