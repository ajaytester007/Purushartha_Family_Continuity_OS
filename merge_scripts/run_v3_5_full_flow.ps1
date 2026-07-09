$ErrorActionPreference = "Stop"
$repo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n,$t){ Write-Host "`n[$n] $t" -ForegroundColor Cyan }
Set-Location $repo
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v3.5 Full Flow" -ForegroundColor Cyan
Write-Host " Journey Identity + Quest System + Safety Gate" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Step "1/10" "Preflight"; .\merge_scripts\preflight_check.ps1
Step "2/10" "Release safety gate before changes"; python .\merge_scripts\release_safety_gate_v3_5.py
Step "3/10" "Merge v3.5 assets"; .\merge_scripts\merge_v3_5.ps1
Step "4/10" "Patch Streamlit"; python .\merge_scripts\patch_streamlit_journey_quests_v3_5.py
Step "5/10" "Validate v3.5 Streamlit and safety gate"; python .\merge_scripts\validate_streamlit_v3_5.py; python .\merge_scripts\release_safety_gate_v3_5.py
Step "6/10" "Validate repository"; .\merge_scripts\validate_repo.ps1
Step "7/10" "Update Pages"; .\merge_scripts\update_pages_v3_5.ps1
Step "8/10" "Publish Wiki"; .\merge_scripts\publish_wiki_v3_5.ps1
Set-Location $repo
Step "9/10" "Publish main repo"; .\merge_scripts\git_publish_main_only_v3_5.ps1
Step "10/10" "Tag release"; .\merge_scripts\tag_release_v3_5.ps1
Write-Host "v3.5 complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
