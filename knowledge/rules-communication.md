# Rules Communication

- Current standard: responses and plans should be readable in 30-60 seconds.
- Use familiar, everyday words; replace obscure words such as "provenance" with "source" or "where it came from," and explain necessary technical terms on first use.
- Lead with the outcome, decision, or next action before technical detail.
- Present details as evidence beneath the claim they support.
- Keep explanations concise while preserving blockers, risks, edge cases, and verification.
- Keep output focused on the active task, prioritize concrete solutions and blockers, and place dense implementation details after the explanation they support.
- Actionable findings must stand alone without surrounding context, use a short title and one **Why/Fix** sentence each, normally 40–70 words, and end with the smallest concrete fix; preserve essential scope, ownership, and freshness checks.
- GitHub review comments do not include automated-review badges.
- PR descriptions and reviews must stand alone for readers without ticket or conversation context. Reviews prioritize concrete blockers and regressions, with brief actionable findings and no optional cleanup unless requested.
- Review and audit skills announce material decisions and brief reasons when made, including UI routing, baseline, suite reuse, delegation, classification, and verdict.
- `review-pr` and `ultra-clear-reviewable-review` use a short title/Why/Fix per finding without separate What or Context sections; the ultra-clear skill uses an outcome-only verdict, with necessary terms explained in place. It omits a separate glossary and routine verification/posting footer while retaining evidence checks and material qualifications. Findings are judged only against the change's stated intent; out-of-scope gaps are follow-ups rather than problems.
