$ErrorActionPreference = "Stop"

Write-Host "== Generating event graph Mermaid v1.9 ==" -ForegroundColor Cyan

$nodesPath = "68_Event_Graph_Engine\event_graph_nodes.csv"
$edgesPath = "68_Event_Graph_Engine\event_graph_edges.csv"
$outDir = "21_Auto_Maps"
$outFile = Join-Path $outDir "generated_event_graph_v1_9.mmd"

New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$nodes = Import-Csv $nodesPath
$edges = Import-Csv $edgesPath

$lines = @()
$lines += "flowchart TD"

foreach ($n in $nodes) {
    $label = "$($n.node_type): $($n.label)" -replace '"', "'"
    $lines += "  $($n.node_id)[`"$label`"]"
}

foreach ($e in $edges) {
    $edgeLabel = $e.edge_type -replace "_", " "
    $lines += "  $($e.from_node) -- $edgeLabel --> $($e.to_node)"
}

$lines | Set-Content -Encoding UTF8 $outFile
Write-Host "Generated $outFile" -ForegroundColor Green
