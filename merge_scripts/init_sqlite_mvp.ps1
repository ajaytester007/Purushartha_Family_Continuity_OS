$ErrorActionPreference = "Stop"
Write-Host "== Initializing SQLite MVP database ==" -ForegroundColor Cyan

$DbDir = "52_SQLite_MVP"
$DbPath = Join-Path $DbDir "purushartha_os_mvp.sqlite"
New-Item -ItemType Directory -Force -Path $DbDir | Out-Null

$py = @'
import sqlite3
from pathlib import Path
import csv

db_path = Path("52_SQLite_MVP/purushartha_os_mvp.sqlite")
db_path.parent.mkdir(parents=True, exist_ok=True)
conn = sqlite3.connect(db_path)

conn.execute("""
CREATE TABLE IF NOT EXISTS local_event_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT,
    stage TEXT,
    domain TEXT,
    harm_level INTEGER,
    impact_score REAL,
    repair_score REAL,
    learning_score REAL,
    summary TEXT,
    safety_override INTEGER DEFAULT 0
)
""")

conn.execute("""
CREATE TABLE IF NOT EXISTS synthetic_case_cache (
    case_id TEXT PRIMARY KEY,
    title TEXT,
    stage TEXT,
    domain TEXT,
    harm_level INTEGER,
    impact_score REAL,
    repair_score REAL,
    learning_score REAL,
    recurrence_count INTEGER,
    safety_override TEXT,
    recommended_tollgate TEXT,
    summary TEXT
)
""")

conn.execute("""
CREATE TABLE IF NOT EXISTS mvp_run_log (
    run_id INTEGER PRIMARY KEY AUTOINCREMENT,
    run_at TEXT DEFAULT CURRENT_TIMESTAMP,
    note TEXT
)
""")

case_path = Path("41_Case_Engine/synthetic_case_library_50.csv")
if case_path.exists():
    with case_path.open("r", encoding="utf-8-sig", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            conn.execute("""
            INSERT OR REPLACE INTO synthetic_case_cache
            (case_id,title,stage,domain,harm_level,impact_score,repair_score,learning_score,recurrence_count,safety_override,recommended_tollgate,summary)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
            """, (
                row["case_id"], row["title"], row["stage"], row["domain"], int(row["harm_level"]),
                float(row["impact_score"]), float(row["repair_score"]), float(row["learning_score"]),
                int(row["recurrence_count"]), row["safety_override"], row["recommended_tollgate"], row["summary"]
            ))

conn.execute("INSERT INTO mvp_run_log(note) VALUES (?)", ("Initialized v1.6 MVP database",))
conn.commit()
conn.close()
print(f"Initialized {db_path}")
'@

$ScriptPath = Join-Path $DbDir "_init_sqlite_mvp.py"
$py | Set-Content -Encoding UTF8 $ScriptPath
python $ScriptPath
Remove-Item $ScriptPath -Force
Write-Host "SQLite MVP initialized: $DbPath" -ForegroundColor Green
