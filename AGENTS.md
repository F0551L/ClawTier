# AGENTS.md

## Codex instruction

Always follow this workflow when making changes unless explicitly told otherwise.

---

## Git workflow

Use stacked branches for non-trivial work.

### Branch structure

* Do not put unrelated work into one branch.
* Prefer small, dependent branches over one large branch.
* Each branch should represent one logical step.
* If a task depends on previous changes, create the new branch from the previous branch, not from `main`.
* Branch names should use workflow prefixes:
  * `feature/...` for the base feature/integration branch.
  * `codex/...` for Codex-authored stacked branches on top of that feature branch.

Example structure:

```text
main
└── bootstrap-base
    └── zerotier-install
        └── docker-install
            └── openclaw-compose
```

Each branch should be suitable for its own pull request.

---

### Pull request targets

* During stack review, do **not** open a PR from `feature/...` to `main` unless explicitly requested.
* Each `codex/...` stacked branch should target the `feature/...` branch (or the immediately lower stack branch when multiple codex layers exist).
* Do not target all stacked PRs directly at `main`.

Example:

```text
feature/openclaw-defaults               (no PR to main yet)
codex/readme-noninteractive-hardening   -> feature/openclaw-defaults
codex/agents-stack-conventions          -> feature/openclaw-defaults
```

---

### Commits

Keep commits minimal, coherent, and reviewable.

* One commit should represent one logical change.
* Do not mix README edits, script refactors, and behavioural changes unless they are directly part of the same step.
* Avoid large rewrite commits unless specifically requested.
* Prefer adding a follow-up commit over rewriting unrelated previous commits.
* Use clear commit subjects.

Good commit subjects:

* Add ZeroTier install script
* Make bootstrap script idempotent
* Add Docker installation step
* Document VPS rebuild flow

Avoid:

* Update stuff
* Fix things
* WIP
* Misc changes

---

### Rebasing stacked branches

When an earlier branch changes, rebase dependent branches onto the updated branch.

Example workflow:

* Checkout zerotier-install
* Rebase onto bootstrap-base
* Checkout docker-install
* Rebase onto zerotier-install

Do not squash the whole stack together unless explicitly requested.

---

### Force pushes

Force-push only with lease:

```bash
git push --force-with-lease
```

Never use plain force push.

---

### Before finishing

Before presenting work as complete:

* Show the current branch stack
* Summarise what changed in each branch
* Confirm which branch each PR should target
* Run syntax checks where applicable

Example checks:

```bash
bash -n scripts/*.sh
```
