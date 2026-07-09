$ErrorActionPreference="Stop"
$repo="C:\GitHub\Purushartha_Family_Continuity_OS_v1.0"
function Step($n,$t){Write-Host "`n[$n] $t" -ForegroundColor Cyan}
Set-Location $repo
Step "1/10" "Preflight"; .\merge_scripts\preflight_check.ps1
Step "2/10" "Merge v4.1 assets"; .\merge_scripts\merge_v4_1.ps1
Step "3/10" "Create PWA shell"; python .\merge_scripts\create_pwa_shell_v4_1.py
Step "4/10" "Safety gate"; python .\merge_scripts\release_safety_gate_v4_1.py
Step "5/10" "Patch Streamlit"; python .\merge_scripts\patch_streamlit_compatibility_requirements_v4_1.py
Step "6/10" "Validate"; python .\merge_scripts\validate_streamlit_v4_1.py; python .\merge_scripts\release_safety_gate_v4_1.py
Step "7/10" "Validate repo and Pages"; .\merge_scripts\validate_repo.ps1; .\merge_scripts\update_pages_v4_1.ps1
Step "8/10" "Publish Wiki"; .\merge_scripts\publish_wiki_v4_1.ps1; Set-Location $repo
Step "9/10" "Publish main"; .\merge_scripts\git_publish_main_only_v4_1.ps1
Step "10/10" "Tag"; .\merge_scripts\tag_release_v4_1.ps1
Write-Host "v4.1 complete. Open GitHub Pages mobile shell on iPhone and Add to Home Screen." -ForegroundColor Green
