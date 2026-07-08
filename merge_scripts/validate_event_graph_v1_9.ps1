$ErrorActionPreference = "Stop"

Write-Host "== Validating event graph v1.9 ==" -ForegroundColor Cyan

$nodesPath = "68_Event_Graph_Engine\event_graph_nodes.csv"
$edgesPath = "68_Event_Graph_Engine\event_graph_edges.csv"

if (-not (Test-Path $nodesPath)) { throw "Missing nodes CSV." }
if (-not (Test-Path $edgesPath)) { throw "Missing edges CSV." }

$nodes = Import-Csv $nodesPath
$edges = Import-Csv $edgesPath

if ($nodes.Count -lt 10) { throw "Expected at least 10 graph nodes." }
if ($edges.Count -lt 8) { throw "Expected at least 8 graph edges." }

$nodeIds = $nodes.node_id
foreach ($e in $edges) {
    if ($nodeIds -notcontains $e.from_node) { throw "Edge $($e.edge_id) has missing from_node $($e.from_node)" }
    if ($nodeIds -notcontains $e.to_node) { throw "Edge $($e.edge_id) has missing to_node $($e.to_node)" }
}

Write-Host "Event graph validation passed. Nodes: $($nodes.Count), Edges: $($edges.Count)" -ForegroundColor Green
