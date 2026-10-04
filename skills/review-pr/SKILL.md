---
name: review-pr
description: "Use when asked to review or audit one or several GitHub PRs, inspect their diffs and interactions, draft review findings, revise a review, or post an agreed review. Use address-pr-review for implementing existing feedback."
---

# Review Pull Requests

Help the user understand the change and approve the exact review that its author will receive. Review source and behavior; do not edit app code, commit, push, deploy, or resolve threads. Evidence and temporary draft files are allowed.

## 1. Confirm intent once

Read each PR's title, description, current head/base, linked requirements, and repository instructions. Before deep review, explain each PR's intended behavior in 1–2 plain-English sentences, its relationship to the others, and the proposed scope, then confirm with the user. Finish one PR's explanation before the next; use no table.

Existing agreement counts, including an ordinary reply such as “both.” Continue without asking again when scope is already clear and confirmed. A formatting revision does not reopen scope. Review each PR individually and related PRs together, respecting the intended stack base.

## 2. Gather evidence and run three independent passes

Consult relevant Linear issues, RFCs, PR descriptions/comments, and recorded product decisions, including decisions made by engineers. Distinguish requirements, observed behavior, recorded decisions, inference, and missing or conflicting information. State material scope and verification decisions briefly.

Delegate three independent passes to separate subagents when available. Give each the same PR/head/base, agreed scope, relevant source locations, and evidence, without another pass's findings:

1. **Implementation:** Trace changed code, callers, downstream consumers, existing primitives, conventions, and tests. Compare claimed behavior with supported behavior and limitations.
2. **Adversarial/regression:** Trace realistic errors, retries, concurrency, partial completion, security boundaries, deployment/rollback, and cross-PR interactions. Require a concrete trigger, path, and consequence.
3. **Product/system:** Check the underlying problem, product decisions, architecture, preserved capabilities, and whether the combined changes deliver the intended outcome.

Require evidence, proposed severity, verification, and gaps from each pass. If delegation is unavailable, perform three separate passes and disclose that they were not independent agents. Do not claim a combined result was tested when only individual PRs were tested.

For changes affecting rendered UI, interaction, navigation, state, accessibility, or user-visible API/model output, use **visual-review-pr** for browser evidence. Respect source-only scope and disclose material untested paths. Its browser audit supplements these passes; this skill owns the review packet and posting workflow.

## 3. Reconcile findings

Verify candidate findings against the reviewed revision, requirements, and real call paths. Reproduce material defects when practical, deduplicate, resolve disagreements, and drop unsupported claims. Keep pre-existing issues distinct from regressions and new-feature defects. Zero findings is valid.

Use exactly one label per finding:

- **[Blocker]:** Confirmed material defect or violation of required behavior that must be fixed before merge.
- **[Should fix]:** Confirmed issue worth correcting, without evidence that it must block merge.
- **[Follow-up]:** Optional, out-of-scope improvement; include only when requested or needed for an explicit rollout decision.
- **[Product decision]:** Unresolved intent or requirement needing a decision; uncertainty is not a confirmed defect.

Prioritize evidence-backed blockers and regressions. Omit style preferences, speculative cleanup, and unrelated debt. If a change breaks existing behavior or makes an existing capability irrelevant, phrase **What** as a direct intent question: “Is it intentional that …?” Explain the concrete consequence and correction or decision needed. Keep **[Blocker]** for a verified blocker even when phrased as a question.

## 4. Show a complete vertical packet per PR

Write the full packet **in chat**, finishing one PR before the next. Use this order:

1. **PR title/link and reviewed head.** Include the proposed GitHub review event as metadata: default `COMMENT`; use `REQUEST_CHANGES` or `APPROVE` when requested and supported by evidence.
2. **For you — not posted.** A 1–2 sentence plain-English explainer and relevant relationship/scope context. Keep this private briefing separate from the review body.
3. **Top-level review — exact text to post.** Write the actual summary/verdict, relevant broader questions or decisions, and material verification limits. Summarize checks truthfully. Do not duplicate the full inline findings here.
4. **Inline comments — exact text to post.** For every comment, show the verified file, tight line range, and diff side as destination metadata, then the complete comment body. Write “None” when there are no inline comments.

Every inline body has a short title with its label and explicit **What / Why / Fix** clauses, each in complete sentences. Aim for 40–80 words while preserving the trigger, impact, and smallest appropriate correction. Each comment must stand alone; links and screenshots support it rather than replace its explanation.

Example inline body, with its file/line supplied separately:

```markdown
**[Blocker] Retry creates duplicate invoices.**

**What:** Is it intentional that retrying a timed-out export creates a second invoice?

**Why:** The retry drops the original request key, so the provider treats the retry as a new invoice and may charge twice.

**Fix:** Reuse the original key and cover the timeout-and-retry path with a regression test.
```

This PR-specific format applies when concise-writing or visual-review helpers are also used. Keep commentary and destination metadata outside the exact posting text.

## 5. Revise and agree in chat

Whenever any review wording changes, reproduce the affected PR's **whole updated packet in chat**, including unchanged portions. A delta, internal Markdown file, or link does not replace it. Multi-PR approval applies only to the PRs and versions the user agreed to.

Obtain agreement to post the displayed text before submitting. “Post this” after the full packet is agreement; honor it without asking again. Approving a format, skill, or scope is not approval to post a review. An earlier generic request to review/post does not approve text the user has not seen.

## 6. Post exactly and verify

An optional internal Markdown tracker may store each PR's head/base, packet version, exact body/comments, anchors, approval, and posting status/IDs. Keep private briefings separate from posting payloads.

Before posting, recheck the head and relevant base/dependencies. If changed, revalidate affected findings and anchors. Show the whole updated affected packet and renew agreement when wording, destination, event, or substantive conclusions change. Approval can stand for identical content at valid anchors after an unrelated change; disclose the recheck. Do not post stale findings.

Submit each PR's approved top-level body and inline bodies **verbatim**, only to that PR. Do not post private explainers, packet labels, or file/line metadata as comment text. Use a structured API payload or body file to preserve Markdown and literal text. Do not silently add, omit, rewrite, or downgrade a comment to a different destination. If a line cannot be attached honestly, revise the packet with a suitable destination and obtain agreement.

Check the server's saved body, comments, destinations, event, and IDs against the approved packet. After a timeout or partial failure, inspect existing posted/pending reviews before retrying; post only confirmed missing content to avoid duplicates. If state is uncertain, retain the draft and report uncertainty instead of claiming success.

Return the confirmed review links. After all approved content for a PR is confirmed posted correctly, remove its temporary draft/tracking files. Retain failed, uncertain, or unposted PR work; keep a shared tracker until all its PRs are complete. Preserve durable evidence the user needs. A draft-only review ends with its packet in chat and stays unposted.
