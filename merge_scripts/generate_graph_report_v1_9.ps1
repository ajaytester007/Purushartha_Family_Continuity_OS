$ErrorActionPreference = "Stop"

Write-Host "== Generating graph report v1.9 ==" -ForegroundColor Cyan

$outDir = "71_Graph_Reports"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$outFile = Join-Path $outDir "event_graph_report_v1_9.md"

$nodes = Import-Csv "68_Event_Graph_Engine\event_graph_nodes.csv"
$edges = Import-Csv "68_Event_Graph_Engine\event_graph_edges.csv"

$lines = @()
$lines += "# Event Graph Report v1.9"
$lines += ""
$lines += "Generated from synthetic graph seed data."
$lines += ""
$lines += "## Summary"
$lines += ""
$lines += "- Nodes: $($nodes.Count)"
$lines += "- Edges: $($edges.Count)"
$lines += ""
$lines += "## Node Types"
$lines += ""
$nodes | Group-Object node_type | Sort-Object Name | ForEach-Object {
    $lines += "- $($_.Name): $($_.Count)"
}
$lines += ""
$lines += "## Edge Types"
$lines += ""
$edges | Group-Object edge_type | Sort-Object Name | ForEach-Object {
    $lines += "- $($_.Name): $($_.Count)"
}
$lines += ""
$lines += "## Guardrail"
$lines += ""
$lines += "Graph relationships are explainable links, not moral verdicts."

$lines | Set-Content -Encoding UTF8 $outFile
Write-Host "Generated $outFile" -ForegroundColor Green
