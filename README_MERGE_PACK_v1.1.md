# Purushartha Family Continuity OS — Merge Pack v1.1

This pack is designed to be copied into the root of the existing `Purushartha_Family_Continuity_OS` Git repository and run from that same base repo location.

It does not require replacing the v1.0 repository. It adds v1.1 publishing, validation, index, dashboard, and roadmap assets through merge scripts.

## Use

From the root of your existing repo:

```bash
bash merge_scripts/merge_v1_1.sh
```

Then optionally:

```bash
bash merge_scripts/publish_snapshot.sh
bash merge_scripts/validate_repo.sh
```

## What It Adds

- v1.1 changelog
- publishing index
- master navigation page
- scoring formula starter files
- dashboard spec
- event graph model
- local implementation backlog
- synthetic dataset seed
- validation checks
- GitHub Pages publishing helper
