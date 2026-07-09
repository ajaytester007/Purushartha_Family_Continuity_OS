# Purushartha Family Continuity OS v4.4

Theme: Real Anonymous Pilot Lab + Multi-Rater Engine + First Decision Maze.

## What this activates

- Anonymous pilot setup
- Partner-A / Partner-B self-ratings
- Parent / sibling / friend / seer / support-system ratings
- Multi-rater disagreement gap detection
- Moment-of-truth episode logger
- Fact / feeling / assumption separation
- First playable decision maze
- Perspective pivots
- Purushartha quadrant decision map
- Seer lens comparison
- Coaching quest and retest plan
- Anonymous pilot decision report
- Mobile evaluation checklist
- GitHub Pages mobile shell update

## Run

```powershell
cd C:\GitHub\Purushartha_Family_Continuity_OS_v1.0
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$Zip = ".\Purushartha_Family_Continuity_OS_v4.4_Merge_Pack.zip"
$Temp = ".\_merge_temp_v4.4"

Expand-Archive -Path $Zip -DestinationPath $Temp -Force
Copy-Item -Path "$Temp\Purushartha_Family_Continuity_OS_v4.4_Merge_Pack\*" -Destination . -Recurse -Force
Remove-Item $Temp -Recurse -Force
Remove-Item $Zip -Force

.\merge_scripts\run_v4_4_full_flow.ps1
```
