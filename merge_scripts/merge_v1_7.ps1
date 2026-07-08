$ErrorActionPreference = "Stop"

Write-Host "== Merging Purushartha OS v1.7 assets ==" -ForegroundColor Cyan

$Dirs = @(
"docs",
"58_GitHub_Pages",
"59_Public_Experience",
"60_Release_Notes",
"61_Backlog_vNext",
".github\workflows"
)

foreach ($d in $Dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

@'
# Release Notes - v1.7 GitHub Pages Public Experience Layer

## Purpose

v1.7 adds a free public website experience through GitHub Pages.

## Added

- Public landing page.
- Links to live Streamlit MVP, Wiki, and repository.
- Public journey map.
- Purushartha quadrant overview.
- Case engine preview.
- Scoring model preview.
- Roadmap.
- GitHub Actions Pages deployment workflow.

## Architecture

- GitHub Repo: source of truth
- GitHub Wiki: knowledgebase
- Streamlit App: live interactive MVP
- GitHub Pages: public website and project experience layer
'@ | Set-Content -Encoding UTF8 "60_Release_Notes\v1.7_GitHub_Pages_Public_Experience.md"

@'
# v1.8 Backlog

## Theme

App UX and Persistent State Upgrade

## Candidate Enhancements

- Better Streamlit navigation.
- Persistent event graph views.
- SQLite-backed case filtering.
- Chart dashboard.
- Exportable family continuity report.
- Consent ledger screen.
- SCD2 state timeline.
- GitHub Pages data cards fed from CSV.
'@ | Set-Content -Encoding UTF8 "61_Backlog_vNext\v1.8_Backlog.md"

@'
# GitHub Pages Public Experience

## Purpose

The Pages site is the public, polished front door for the project.

## URL

https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/

## Content

- Project overview
- Live app link
- Wiki link
- Repo link
- Journey map
- Purushartha model
- Case engine preview
- Scoring preview
- Roadmap
'@ | Set-Content -Encoding UTF8 "58_GitHub_Pages\GitHub_Pages_Public_Experience.md"

@'
# Public Experience Model

## Layers

1. Landing page
2. Knowledgebase links
3. Live app link
4. Journey map
5. Case engine preview
6. Scoring preview
7. Roadmap
8. Guardrails

## Rule

The public experience must not publish private real-life logs, health records, intimate correspondence, or third-party evidence.
'@ | Set-Content -Encoding UTF8 "59_Public_Experience\Public_Experience_Model.md"

@'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Purushartha Family Continuity OS</title>
  <meta name="description" content="Consent-first relationship, family continuity, resilience, wealth, and legacy intelligence framework.">
  <style>
    :root {
      --bg: #0f172a;
      --panel: #111827;
      --panel2: #1f2937;
      --text: #f8fafc;
      --muted: #cbd5e1;
      --accent: #f59e0b;
      --accent2: #38bdf8;
      --line: rgba(255,255,255,.12);
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
      background: radial-gradient(circle at top left, #1e3a8a 0, var(--bg) 35%, #020617 100%);
      color: var(--text);
      line-height: 1.6;
    }
    a { color: var(--accent2); text-decoration: none; }
    a:hover { text-decoration: underline; }
    header {
      padding: 64px 24px 36px;
      max-width: 1100px;
      margin: auto;
    }
    .eyebrow { color: var(--accent); font-weight: bold; letter-spacing: .08em; text-transform: uppercase; font-size: 13px; }
    h1 { font-size: clamp(38px, 6vw, 72px); line-height: 1.02; margin: 12px 0 18px; }
    .lead { font-size: 20px; color: var(--muted); max-width: 900px; }
    .buttons { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 28px; }
    .btn {
      display: inline-block;
      padding: 12px 18px;
      border-radius: 999px;
      border: 1px solid var(--line);
      background: rgba(255,255,255,.08);
      color: white;
      font-weight: bold;
    }
    .btn.primary { background: var(--accent); color: #111827; }
    main { max-width: 1100px; margin: auto; padding: 0 24px 64px; }
    section { margin: 28px 0; padding: 28px; background: rgba(17,24,39,.82); border: 1px solid var(--line); border-radius: 22px; }
    h2 { margin-top: 0; font-size: 30px; }
    .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(230px, 1fr)); gap: 16px; }
    .card { background: rgba(31,41,55,.82); padding: 18px; border-radius: 16px; border: 1px solid var(--line); }
    .card h3 { margin-top: 0; color: var(--accent); }
    .map { overflow-x: auto; white-space: nowrap; padding: 10px 0; }
    .node {
      display: inline-block;
      padding: 12px 16px;
      margin: 6px;
      border-radius: 14px;
      background: rgba(56,189,248,.13);
      border: 1px solid rgba(56,189,248,.35);
      color: white;
      font-weight: bold;
    }
    .arrow { color: var(--muted); }
    table { width: 100%; border-collapse: collapse; margin-top: 12px; }
    th, td { text-align: left; padding: 10px; border-bottom: 1px solid var(--line); }
    th { color: var(--accent); }
    footer { color: var(--muted); text-align: center; padding: 36px 24px; border-top: 1px solid var(--line); }
    .guardrail { border-left: 5px solid var(--accent); }
  </style>
</head>
<body>
  <header>
    <div class="eyebrow">Relationship • Family • Wealth • Legacy Intelligence</div>
    <h1>Purushartha Family Continuity OS</h1>
    <p class="lead">
      A consent-first operating system for navigating relationships, marriage, parenting, crisis recovery,
      family continuity, wealth resilience, and legacy through Dharma, Artha, Kama, and Moksha.
    </p>
    <div class="buttons">
      <a class="btn primary" href="https://purusharthafamilycontinuityos-jakkkbzwpuv5pxapptc5up2.streamlit.app/">Open Live App</a>
      <a class="btn" href="https://github.com/ajaytester007/Purushartha_Family_Continuity_OS/wiki">Read the Wiki</a>
      <a class="btn" href="https://github.com/ajaytester007/Purushartha_Family_Continuity_OS">View GitHub Repo</a>
    </div>
  </header>

  <main>
    <section class="guardrail">
      <h2>Guardrail</h2>
      <p>
        This is decision support, not legal, medical, financial, mental-health, or emergency advice.
        It must not be used for secret surveillance, diagnosis, punishment, or publication of private real-life evidence without consent.
      </p>
    </section>

    <section>
      <h2>System Architecture</h2>
      <div class="grid">
        <div class="card"><h3>GitHub Repo</h3><p>Source of truth, scripts, schemas, app code, release history.</p></div>
        <div class="card"><h3>GitHub Wiki</h3><p>Human-readable knowledgebase and relationship intelligence bible.</p></div>
        <div class="card"><h3>Streamlit App</h3><p>Interactive MVP for event entry, scoring, cases, repair plans, and report export.</p></div>
        <div class="card"><h3>GitHub Pages</h3><p>Public front door for the project, roadmap, and usage model.</p></div>
      </div>
    </section>

    <section>
      <h2>Life Journey Map</h2>
      <div class="map">
        <span class="node">Self Readiness</span><span class="arrow">→</span>
        <span class="node">New Relationship</span><span class="arrow">→</span>
        <span class="node">Exclusivity</span><span class="arrow">→</span>
        <span class="node">Engagement</span><span class="arrow">→</span>
        <span class="node">Marriage</span><span class="arrow">→</span>
        <span class="node">Household OS</span><span class="arrow">→</span>
        <span class="node">Parenting</span><span class="arrow">→</span>
        <span class="node">Midlife</span><span class="arrow">→</span>
        <span class="node">Renewal</span><span class="arrow">→</span>
        <span class="node">Aging</span><span class="arrow">→</span>
        <span class="node">Legacy</span>
      </div>
    </section>

    <section>
      <h2>Purushartha Balance</h2>
      <div class="grid">
        <div class="card"><h3>Dharma</h3><p>Duty, ethics, caregiving, fairness, promises, and right order.</p></div>
        <div class="card"><h3>Artha</h3><p>Security, income, assets, insurance, resilience, and sustainable prosperity.</p></div>
        <div class="card"><h3>Kama</h3><p>Love, affection, beauty, joy, intimacy, celebration, and aliveness.</p></div>
        <div class="card"><h3>Moksha</h3><p>Meaning, wisdom, inner freedom, spiritual alignment, and legacy.</p></div>
      </div>
    </section>

    <section>
      <h2>Case Engine Preview</h2>
      <table>
        <thead><tr><th>Case</th><th>Domain</th><th>Tollgate</th><th>Purpose</th></tr></thead>
        <tbody>
          <tr><td>Family Boundary Bypass</td><td>Family Integration</td><td>Continue / Correct / Reconsider / Exit</td><td>Test decision rights and family influence.</td></tr>
          <tr><td>Gifted Child Overload</td><td>Parenting</td><td>Parenting Load Tollgate</td><td>Protect opportunity without family capture.</td></tr>
          <tr><td>Midlife Drift</td><td>Lifestyle</td><td>Crisis or Renewal</td><td>Detect relationship drift before collapse.</td></tr>
          <tr><td>New Partner Coauthorship</td><td>Recovery</td><td>New Partner Entry</td><td>Preserve continuity without replacing a person.</td></tr>
        </tbody>
      </table>
    </section>

    <section>
      <h2>Scoring Preview</h2>
      <div class="grid">
        <div class="card"><h3>Relationship Health</h3><p>Safety, trust, reciprocity, affection, respect, teamwork, repair, and growth.</p></div>
        <div class="card"><h3>Karma Bond</h3><p>Goodwill capital, emotional debt, repair credits, and unresolved harm.</p></div>
        <div class="card"><h3>Burden Skew</h3><p>Tracks household, emotional, financial, caregiving, and mental-load imbalance.</p></div>
        <div class="card"><h3>Family QoL</h3><p>Complexity-adjusted quality of life for parenting, giftedness, crisis, health, and support load.</p></div>
      </div>
    </section>

    <section>
      <h2>Roadmap</h2>
      <div class="grid">
        <div class="card"><h3>v1.8</h3><p>App UX and persistent state upgrade.</p></div>
        <div class="card"><h3>v1.9</h3><p>SCD2 timeline and event graph visualizer.</p></div>
        <div class="card"><h3>v2.0</h3><p>Local relationship intelligence workbench with reports and governance.</p></div>
      </div>
    </section>
  </main>

  <footer>
    Purushartha Family Continuity OS - public experience layer.
  </footer>
</body>
</html>
'@ | Set-Content -Encoding UTF8 "docs\index.html"

@'
# GitHub Pages Deployment

## Enable Pages

1. Open the repository on GitHub.
2. Go to Settings.
3. Select Pages.
4. Under Build and deployment, select GitHub Actions.
5. Push v1.7.
6. Open the Pages URL once the workflow completes.

Expected URL:

https://ajaytester007.github.io/Purushartha_Family_Continuity_OS/
'@ | Set-Content -Encoding UTF8 "58_GitHub_Pages\GitHub_Pages_Deployment.md"

@'
name: Deploy GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ '${{ steps.deployment.outputs.page_url }}' }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v5
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: './docs'
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
'@ | Set-Content -Encoding UTF8 ".github\workflows\pages.yml"

Write-Host "v1.7 assets merged successfully." -ForegroundColor Green
