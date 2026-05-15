# Upgrade Policy

This policy defines safe upgrade and rollback expectations for ClawTier-managed hosts.

## Supported upgrade paths

ClawTier supports in-place updates for:

- **Patch releases** within the same minor line.
- **Minor releases** within the same major line, when release notes do not call out manual migration requirements.

Use the built-in update commands:

```bash
sudo bash clawtier.sh -u
sudo bash clawtier.sh -uc all
```

`-u` refreshes local scripts from the configured source repository. `-uc` updates installed component versions (Caddy proxy, OpenClaw, and ZeroTier).

## Upgrades that require manual steps

Treat upgrades as **manual-change required** when any of the following apply:

- **Major version changes** for ClawTier-managed components.
- **Configuration format/schema changes** (new required keys, renamed fields, removed options).
- Release notes requiring operator actions such as secret rotation, network reconfiguration, or data migration.

Before running update commands in these cases:

1. Read release notes/changelogs for all affected components.
2. Stage config changes in your env/config files.
3. Schedule downtime or a maintenance window if behavior changes are not guaranteed to be backward compatible.
4. Run updates first on a disposable/staging VPS when possible.

## Rollback guidance

If an update causes regressions, roll back to a known-good tag.

1. Record the current state and collect logs.
2. Check out the prior known-good ClawTier tag.
3. Re-run provisioning/update commands from that tag to redeploy the previous scripts/config behavior.
4. Validate service health (ZeroTier join state, proxy reachability, OpenClaw startup).

Example rollback flow:

```bash
cd /opt/ClawTier
sudo git fetch --tags
sudo git checkout <known-good-tag>
sudo bash clawtier.sh -n YOUR_ZEROTIER_NETWORK_ID
```

If component-level updates were applied with `-uc`, use the same known-good repository tag and redeploy from that tag so script-managed versions and configuration logic are aligned.

## Data and backup expectations before updates

Before running `-u` or `-uc`:

- Snapshot the VPS (provider snapshot preferred for full-host rollback).
- Back up OpenClaw persistent data/volumes.
- Back up runtime configuration and credentials (`/root/clawtier-bootstrap.env`, token files, and any custom overrides).
- Confirm you can access the host out-of-band (provider console or SSH path) in case ZeroTier/proxy behavior changes during upgrade.

Do not run production updates without a restorable backup and a documented known-good version/tag to return to.
