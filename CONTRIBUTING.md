# Contributing

Thanks for helping improve ClawTier.

## Changelog policy

Before tagging a release, every user-visible script behavior change **must** have a matching entry in `CHANGELOG.md`.

Use these sections under `[Unreleased]`:

- **Added**: New user-visible capabilities or scripts.
- **Changed**: Behavior changes to existing user workflows.
- **Fixed**: User-visible bug fixes.
- **Security**: Security-impacting hardening or vulnerability fixes.

If a change affects script behavior and no changelog entry is present, do not tag the release until the entry is added.

## Release notes process

Use `.github/release-template.md` to prepare release notes from the pending `CHANGELOG.md` entries.

## Workflow notes

- See `AGENTS.md` for active agent branch and PR workflow requirements.
- Prefer squash merges for stacked implementation PRs.
