# AGENTS.md

## Codex instruction

Always follow this workflow when making changes unless explicitly told otherwise.

---

## Git workflow

Use a feature base branch plus stacked branches for non-trivial work.

When creating changes:

* Always push to a new branch.
* Immediately push new workflow branches to the remote as soon as they are created, before committing anything, so other agent instances can fetch the branch and rebase from it if instructed.
* Open a pull request for the branch.
* Assign the user as an assignee.
* Do not approve or close pull requests created by an agent unless the user explicitly asks you to complete that PR.
* Use stacked PRs when changes depend on earlier branches.
* Push follow-up commits to the same PR branch when updating review feedback or continuing that change.
* Ensure `.github/CODEOWNERS` exists before opening a pull request. If it is missing, add it in the same logical change when appropriate.
* Ensure the repository owner is included in `.github/CODEOWNERS` for every path. Infer the owner from the GitHub remote owner when possible; ask the user if the owner cannot be determined.

### Branch structure

* Do not put unrelated work into one branch.
* For non-trivial features, create one feature base branch from `main`.
* Create stacked implementation branches from the feature base branch, or from the previous stacked branch when the work depends on it.
* Prefer small, dependent stacked branches over one large branch.
* Each stacked branch should represent one logical step.
* Merge stacked branches back into the feature base branch, not directly into `main`.
* Once the feature is complete, open the feature base branch PR into `main` as the single feature-level merge.

Example structure:

```text
main
└── vps-bootstrap-feature
    ├── zerotier-install
    │   └── docker-install
    │       └── openclaw-compose
    └── docs-update
```

Each branch should be suitable for its own pull request.

---

### Pull request targets

* The feature base branch targets `main`.
* The first stacked implementation branch targets the feature base branch.
* Each dependent stacked branch targets the branch immediately below it.
* Do not target stacked implementation PRs directly at `main`.

Example:

```text
vps-bootstrap-feature -> main
zerotier-install      -> vps-bootstrap-feature
docker-install        -> zerotier-install
openclaw-compose      -> docker-install
docs-update           -> vps-bootstrap-feature
```

---

### Merge preference

Prefer **Squash and merge** when completing pull requests in this workflow.

* Squash stacked implementation branches into the feature base branch.
* Squash the feature base branch into `main` when the full feature is ready.
* Name each squash commit after the idea of the branch.
* Avoid merge commits.
* Do not default to rebase-and-merge for stacked PR completion unless the user explicitly asks for it.

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
