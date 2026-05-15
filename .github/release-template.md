# Release Notes Template

Use this template when preparing a release tag and GitHub release notes.

## Version
- `vX.Y.Z`

## Date
- `YYYY-MM-DD`

## Summary
- One-paragraph overview of the release.

## Added
- Bullet list from `CHANGELOG.md` (`[Unreleased]` → `Added`).

## Changed
- Bullet list from `CHANGELOG.md` (`[Unreleased]` → `Changed`).

## Fixed
- Bullet list from `CHANGELOG.md` (`[Unreleased]` → `Fixed`).

## Security
- Bullet list from `CHANGELOG.md` (`[Unreleased]` → `Security`).

## Upgrade / Operator Notes
- Any manual migration or re-run steps.

## Checklist
- [ ] Every user-visible script behavior change has a corresponding `CHANGELOG.md` entry.
- [ ] `CHANGELOG.md` entries are categorized under Added/Changed/Fixed/Security.
- [ ] `[Unreleased]` entries included in this release are moved to a versioned section.
- [ ] README / CONTRIBUTING docs reflect any process updates introduced in this release.
- [ ] Scripts pass syntax checks (`bash -n scripts/*.sh clawtier.sh`).
