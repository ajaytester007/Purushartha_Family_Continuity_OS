$ErrorActionPreference="Stop"
$repo="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n,$t){Write-Host "`n[$n] $t" -ForegroundColor Cyan}
Set-Location $repo
Step "1/9" "Preflight"; .\merge_scripts\preflight_check.ps1
Step "2/9" "Safety gate before"; python .\merge_scripts\release_safety_gate_v4_6.py
Step "3/9" "Merge v4.6 assets"; .\merge_scripts\merge_v4_6.ps1
Step "4/9" "Patch Streamlit"; python .\merge_scripts\patch_streamlit_checklist_intake_v4_6.py
Step "5/9" "Validate"; python .\merge_scripts\validate_streamlit_v4_6.py; python .\merge_scripts\release_safety_gate_v4_6.py
Step "6/9" "Validate repo and Pages"; .\merge_scripts\validate_repo.ps1; .\merge_scripts\update_pages_v4_6.ps1
Step "7/9" "Publish Wiki"; .\merge_scripts\publish_wiki_v4_6.ps1; Set-Location $repo
Step "8/9" "Publish main"; .\merge_scripts\git_publish_main_only_v4_6.ps1
Step "9/9" "Tag"; .\merge_scripts\tag_release_v4_6.ps1
Write-Host "v4.6 complete. Mobile shell and Streamlit should redeploy from main." -ForegroundColor Green
