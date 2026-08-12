# Repository Maintenance

## Ownership And Upstream

`Thetromboneman1/NeoFreeBird` is a maintained fork of
`orionblur/NeoFreeBird`. Branch `v6` contains downstream branding and workflow
changes. Do not force-push or automatically merge upstream changes into it.

## Safe Update Flow

1. Fetch `upstream/v6` and create a dedicated review branch.
2. Merge without rewriting either history.
3. Resolve conflicts with the downstream branding and packaging contract in
   mind.
4. Run shell syntax checks and inspect the GitHub Actions workflows with
   `actionlint`.
5. Use a bounded manual workflow run for the intended package format.
6. Merge only after the generated package and release behavior are verified.

## Workflow Security

Third-party actions are pinned to immutable commit SHAs. Update a pin only
after reviewing the referenced release and validating the workflow. Secrets
belong in GitHub Actions or the Boneman 1Password vault and must never be added
to this repository.

## Recovery

Close an unmerged synchronization pull request and delete its review branch to
abandon an update. Revert the downstream maintenance commit if a published
workflow change must be rolled back. Do not rewrite the `v6` branch history.
