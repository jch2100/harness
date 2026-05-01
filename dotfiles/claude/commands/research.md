---
description: Run a focused research pass and produce cited notes
argument-hint: <topic>
---
Research the topic: $ARGUMENTS

Use WebSearch and WebFetch to gather sources. Prefer primary sources;
flag clearly when only secondary sources are available.

Produce notes in Korean with this structure:
- Summary (2-3 sentences)
- Key findings (3-5 items, each with an inline citation)
- Open questions (what's unclear or contested)
- References (full list at the bottom)

Save to `~/research/<slug>.md` (slugify topic, ASCII).
Create parent directories if missing. Report the saved path in Korean.
