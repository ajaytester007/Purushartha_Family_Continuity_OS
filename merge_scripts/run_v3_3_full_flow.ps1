$ErrorActionPreference = "Stop"
$MainRepo = "C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"

function Step($n, $text) { Write-Host "`n[$n] $text" -ForegroundColor Cyan }

Set-Location $MainRepo

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " Purushartha OS v3.3 Full Flow" -ForegroundColor Cyan
Write-Host " Persistent Logs + App Stabilization" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

Step "1/9" "Preflight"
.\merge_scripts\preflight_check.ps1

Step "2/9" "Merge v3.3 assets"
.\merge_scripts\merge_v3_3.ps1

Step "3/9" "Patch Streamlit persistent logs"
.\merge_scripts\patch_streamlit_persistent_logs_v3_3.ps1

Step "4/9" "Auto-fix and validate duplicate Streamlit keys"
python .\merge_scripts\auto_fix_duplicate_streamlit_keys_v3_3.py
python .\merge_scripts\validate_no_duplicate_streamlit_keys_v3_3.py

Step "5/9" "Validate Streamlit and repo"
.\merge_scripts\validate_streamlit_v3_3.ps1
.\merge_scripts\validate_repo.ps1

Step "6/9" "Update Pages"
.\merge_scripts\update_pages_v3_3.ps1

Step "7/9" "Publish Wiki"
.\merge_scripts\publish_wiki_v3_3.ps1

Set-Location $MainRepo

Step "8/9" "Publish main repo"
.\merge_scripts\git_publish_main_only_v3_3.ps1

Step "9/9" "Tag release"
.\merge_scripts\tag_release_v3_3.ps1

Write-Host "v3.3 full flow complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
