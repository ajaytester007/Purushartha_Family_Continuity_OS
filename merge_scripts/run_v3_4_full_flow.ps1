$ErrorActionPreference="Stop";$r="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0";function S($n,$t){Write-Host "`n[$n] $t" -ForegroundColor Cyan};Set-Location $r
S "1/9" "Preflight";.\merge_scripts\preflight_check.ps1
S "2/9" "Merge assets";.\merge_scripts\merge_v3_4.ps1
S "3/9" "Patch Streamlit";python .\merge_scripts\patch_streamlit_feed_forward_v3_4.py
S "4/9" "Validate Streamlit";python .\merge_scripts\validate_streamlit_v3_4.py
S "5/9" "Validate repo";.\merge_scripts\validate_repo.ps1
S "6/9" "Update Pages";.\merge_scripts\update_pages_v3_4.ps1
S "7/9" "Publish Wiki";.\merge_scripts\publish_wiki_v3_4.ps1;Set-Location $r
S "8/9" "Publish main";.\merge_scripts\git_publish_main_only_v3_4.ps1
S "9/9" "Tag";.\merge_scripts\tag_release_v3_4.ps1
Write-Host "v3.4 complete. Streamlit Cloud should redeploy from main." -ForegroundColor Green
