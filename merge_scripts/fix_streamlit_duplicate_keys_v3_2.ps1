$ErrorActionPreference = "Stop"

$app = "51_Streamlit_MVP\app.py"
$content = Get-Content $app -Raw

$content = $content -replace 'st\.slider\("Current Severity", 0, 5, 2\)', 'st.slider("Current Severity", 0, 5, 2, key="consult_current_severity")'
$content = $content -replace 'st\.slider\("Severity", 0, 5, 2\)', 'st.slider("Severity", 0, 5, 2, key="grievance_severity")'
$content = $content -replace 'st\.slider\("Partner Accountability Shown", 0, 10, 5\)', 'st.slider("Partner Accountability Shown", 0, 10, 5, key="grievance_partner_accountability")'
$content = $content -replace 'st\.slider\("Repair Willingness Shown", 0, 10, 5\)', 'st.slider("Repair Willingness Shown", 0, 10, 5, key="grievance_repair_willingness")'
$content = $content -replace 'st\.slider\("Trust / Fidelity Concern", 0, 5, 1\)', 'st.slider("Trust / Fidelity Concern", 0, 5, 1, key="grievance_trust_concern")'

$matches = [regex]::Matches($content, 'st\.slider\("Repeated Pattern Count", 0, 10, 1\)')
if ($matches.Count -ge 1) {
    $content = [regex]::Replace($content, 'st\.slider\("Repeated Pattern Count", 0, 10, 1\)', 'st.slider("Repeated Pattern Count", 0, 10, 1, key="consult_repeated_pattern_count")', 1)
}
if ([regex]::IsMatch($content, 'st\.slider\("Repeated Pattern Count", 0, 10, 1\)')) {
    $content = [regex]::Replace($content, 'st\.slider\("Repeated Pattern Count", 0, 10, 1\)', 'st.slider("Repeated Pattern Count", 0, 10, 1, key="grievance_repeated_pattern_count")', 1)
}

$content | Set-Content -Encoding UTF8 $app

Write-Host "Duplicate Streamlit slider keys fixed." -ForegroundColor Green
