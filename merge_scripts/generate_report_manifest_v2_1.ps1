$ErrorActionPreference = "Stop"

Write-Host "== Generating report manifest v2.1 ==" -ForegroundColor Cyan

$outDir = "83_Report_Manifest"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir "report_manifest.csv"

$rows = @(
    [PSCustomObject]@{ report_id="RPT001"; report_name="Workbench Summary v2.0"; report_type="Workbench"; local_path="77_Report_Builder/workbench_summary_v2_0.md"; wiki_page_hint="77-Report-Builder-workbench-summary-v2-0"; public_private_mode="Public Demo"; generated_by="generate_workbench_reports_v2_0.ps1"; audience="Project viewer"; guardrail_status="Synthetic safe" },
    [PSCustomObject]@{ report_id="RPT002"; report_name="Family Continuity Summary v1.8"; report_type="Family Continuity"; local_path="53_Report_Exporter/family_continuity_summary_v1_8.md"; wiki_page_hint="53-Report-Exporter-family-continuity-summary-v1-8"; public_private_mode="Public Demo"; generated_by="generate_family_continuity_report_v1_8.ps1"; audience="Project viewer"; guardrail_status="Synthetic safe" },
    [PSCustomObject]@{ report_id="RPT003"; report_name="Event Graph Report v1.9"; report_type="Event Graph"; local_path="71_Graph_Reports/event_graph_report_v1_9.md"; wiki_page_hint="71-Graph-Reports-event-graph-report-v1-9"; public_private_mode="Public Demo"; generated_by="generate_graph_report_v1_9.ps1"; audience="Project viewer"; guardrail_status="Synthetic safe" },
    [PSCustomObject]@{ report_id="RPT004"; report_name="Decision Explanations"; report_type="Case Engine"; local_path="43_Decision_Explanations/decision_explanations.md"; wiki_page_hint="43-Decision-Explanations-decision-explanations"; public_private_mode="Public Demo"; generated_by="run_tollgate_simulator.ps1"; audience="Project viewer"; guardrail_status="Synthetic safe" },
    [PSCustomObject]@{ report_id="RPT005"; report_name="Repair Plan Outputs"; report_type="Repair"; local_path="44_Repair_Plans/repair_plan_outputs.md"; wiki_page_hint="44-Repair-Plans-repair-plan-outputs"; public_private_mode="Public Demo"; generated_by="generate_repair_plans.ps1"; audience="Project viewer"; guardrail_status="Synthetic safe" },
    [PSCustomObject]@{ report_id="RPT006"; report_name="Retest Schedule"; report_type="Retest"; local_path="45_Retest_Scheduler/generated_retest_schedule.csv"; wiki_page_hint="45-Retest-Scheduler-Retest-Scheduler"; public_private_mode="Public Demo"; generated_by="generate_repair_plans.ps1"; audience="Project viewer"; guardrail_status="Synthetic safe" }
)

$rows | Export-Csv $out -NoTypeInformation
Write-Host "Generated $out" -ForegroundColor Green
