# Monarch releases

- `skills/monarch-release` is the canonical deployment skill; registered in `skills/manifest.toml` and installed through `ovmd skills sync -g`.
- Resolve current remote revisions and deployed bundle manifests each time. Wait for dev, stage, inspect notes/QA, then promote the exact approved bundle to production.
- Keep approval checkpoints and monitoring separate from automatic retries, configuration changes, Slack delivery, or rollback. Report partial deployments and reporting failures independently.
- Release QA and test-plan skills complement deployment; generated notes and HTTP availability do not establish regression coverage.
