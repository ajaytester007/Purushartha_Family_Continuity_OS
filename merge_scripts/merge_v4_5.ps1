$ErrorActionPreference = "Stop"
Write-Host "== Merging v4.5 Sacred Maze assets ==" -ForegroundColor Cyan

$dirs = @("228_Sacred_Maze_Engine","229_Mind_Map_Game","230_Symbolic_Journey_Skins","231_Chakra_Tollgate_Model","232_Sadhana_Quest_Library","233_Karma_Imprint_Reflection","234_Seer_Wisdom_Intake","235_Mobile_Evaluation_v4_5","236_Release_Notes","237_Backlog_vNext")
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

"# Sacred Maze Engine`n`nOptional symbolic and metaphorical maze layer over the relationship decision engine. It helps users pivot across self, partner, family, support-system, seer, and Purushartha perspectives. It does not claim diagnosis, certainty, or spiritual judgment." | Set-Content -Encoding UTF8 "228_Sacred_Maze_Engine\Sacred_Maze_Engine.md"

@'
node_id,node_name,node_type,next_nodes,question
N001,Entry Sankalpa,Start,N002|N003,What intention are we entering the maze with?
N002,Self Chamber,Perspective,N004,What did I intend and what did I fear?
N003,Partner Chamber,Perspective,N004,What might my partner have experienced?
N004,Family Gate,System,N005|N006,What family expectation or protection instinct appeared?
N005,Artha Corridor,Constraint,N007,What money time distance health or logistics constraint mattered?
N006,Kama Garden,Bonding,N007,What joy affection or companionship is being preserved or lost?
N007,Dharma Mirror,Truth,N008,What is the fair truthful dignified action?
N008,Moksha Window,Freedom,N009,What choice helps both souls mature rather than shrink?
N009,Repair Bridge,Action,N010,What visible repair or boundary is needed?
N010,Tollgate,Milestone,,Continue incubate pause or exit?
'@ | Set-Content -Encoding UTF8 "228_Sacred_Maze_Engine\sacred_maze_nodes_v4_5.csv"

"# Mind Map Game`n`nMind-map mode shows how each decision point links to perspectives, emotions, practical constraints, and Purushartha quadrants. The first implementation uses Mermaid graph output." | Set-Content -Encoding UTF8 "229_Mind_Map_Game\Mind_Map_Game.md"

@'
graph TD
    A[Entry Sankalpa] --> B[Self Chamber]
    A --> C[Partner Chamber]
    B --> D[Family Gate]
    C --> D
    D --> E[Artha Corridor]
    D --> F[Kama Garden]
    E --> G[Dharma Mirror]
    F --> G
    G --> H[Moksha Window]
    H --> I[Repair Bridge]
    I --> J[Tollgate: Continue / Incubate / Pause / Exit]
'@ | Set-Content -Encoding UTF8 "229_Mind_Map_Game\sacred_maze_mind_map_v4_5.mmd"

@'
skin_id,skin_name,symbolic_focus,when_to_use
SK001,Shiva Karana Path,Movement transformation discipline,When the issue needs maturity through action and restraint
SK002,Ganesha Obstacle Path,Obstacle removal beginnings wisdom,When the couple is blocked by practical or family obstacles
SK003,Devi Shakti Path,Nurturing protection courage,When emotional repair strength and protection are needed
SK004,Nature River Path,Flow patience adaptation,When distance time or healing requires gradual movement
SK005,Secular Compass Path,Values logic and life design,When users prefer non-religious framing
'@ | Set-Content -Encoding UTF8 "230_Symbolic_Journey_Skins\symbolic_journey_skins_v4_5.csv"

"# Symbolic Journey Skins`n`nUsers may choose Shiva, Ganesha, Devi, Nature, or Secular skins. All skins use the same decision engine; only language and quest flavor change." | Set-Content -Encoding UTF8 "230_Symbolic_Journey_Skins\Symbolic_Journey_Skins.md"

@'
tollgate_id,tollgate_name,chakra_metaphor,relationship_lesson
TG001,Grounding Gate,Root,Can the relationship feel safe and stable?
TG002,Joy Gate,Sacral,Can joy affection and creativity remain alive?
TG003,Will Gate,Solar Plexus,Can both act responsibly without domination?
TG004,Compassion Gate,Heart,Can hurt be repaired with care?
TG005,Truth Gate,Throat,Can truth be spoken without cruelty?
TG006,Insight Gate,Third Eye,Can patterns and projections be seen clearly?
TG007,Meaning Gate,Crown,Can the relationship align with purpose and peace?
'@ | Set-Content -Encoding UTF8 "231_Chakra_Tollgate_Model\chakra_tollgates_v4_5.csv"

"# Chakra Tollgate Model`n`nSymbolic gates: safety, joy, responsible will, compassion, truth, insight, and meaning." | Set-Content -Encoding UTF8 "231_Chakra_Tollgate_Model\Chakra_Tollgate_Model.md"

@'
quest_id,quest_name,focus,practice
SQ001,Grounding Sadhana,Safety,Take 10 calm breaths before discussing the issue
SQ002,Truth Sadhana,Dharma,State one fact one feeling and one request
SQ003,Artha Sadhana,Logistics,Create one practical cost/time/distance plan
SQ004,Kama Sadhana,Joy,Create one low-cost shared joyful moment
SQ005,Moksha Sadhana,Freedom,Name one way each person can grow without control
SQ006,Repair Sadhana,Compassion,Offer one apology correction or boundary with dignity
SQ007,Seer Sadhana,Perspective,Ask what a wise neutral observer would see
'@ | Set-Content -Encoding UTF8 "232_Sadhana_Quest_Library\sadhana_quests_v4_5.csv"

"# Sadhana Quest Library`n`nSadhana means effort/practice. In the app it becomes a small reflective or behavioral quest." | Set-Content -Encoding UTF8 "232_Sadhana_Quest_Library\Sadhana_Quest_Library.md"
"# Karma Imprint Reflection`n`nReflective questions about repeating patterns, old wounds, assumptions, loosening patterns through effort, and skills being learned at a tollgate. This remains reflective, not deterministic." | Set-Content -Encoding UTF8 "233_Karma_Imprint_Reflection\Karma_Imprint_Reflection.md"
"# Seer Wisdom Intake`n`nSeers or mentors can contribute observation, dharmic risk, blind spot, suggested sadhana, and retest period. Advisory only, never coercive authority." | Set-Content -Encoding UTF8 "234_Seer_Wisdom_Intake\Seer_Wisdom_Intake.md"

@'
feature,check_from_iphone,pass_criteria
Sacred Maze Lab,Streamlit v4.5 section,User can select symbolic skin and navigate maze nodes
Mind Map,Streamlit v4.5 section,Path summary is visible
Sadhana Quest,Streamlit v4.5 section,Quest changes based on selected focus
Tollgate,Streamlit v4.5 section,User receives continue/incubate/pause/exit direction
Mobile Shell,Home Screen icon,Shows v4.5 Sacred Maze update after Pages deploy
Report,Download button,Downloads symbolic maze report
Guardrail,Screen text,Symbolic layer is optional and metaphorical
'@ | Set-Content -Encoding UTF8 "235_Mobile_Evaluation_v4_5\mobile_evaluation_v4_5.csv"

"# v4.5 Release Notes`n`nAdds Sacred Maze Engine v1, mind-map game, symbolic journey skins, chakra/tollgate model, sadhana quest library, karma-imprint reflection, seer wisdom intake, and Streamlit Sacred Maze Lab." | Set-Content -Encoding UTF8 "236_Release_Notes\v4.5_Sacred_Maze_Engine.md"
"# v4.6 Backlog`n`nClickable graph view, avatar selector, skin language packs, seer wisdom upload, saved maze reports, chakra/tollgate progress wheel, animated mobile roadmap." | Set-Content -Encoding UTF8 "237_Backlog_vNext\v4.6_Backlog.md"

Write-Host "v4.5 assets merged." -ForegroundColor Green
