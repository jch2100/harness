---
description: Generate a lesson plan in the standard format
argument-hint: <topic> [age:<N>] [duration:<min>]
---
Generate a lesson plan for: $ARGUMENTS

Use this lesson-plan format:
1. Learning objectives (3 items, action verbs)
2. Hook / warm-up (~5 min)
3. Main content (~35 min, 3 sub-sections)
4. Activity (~8 min)
5. Wrap-up & assessment (~2 min)

Default duration: 50 minutes unless `duration:<min>` is given.
Default audience: middle-school unless `age:<N>` is given.
Lesson body language: Korean.

Cite any factual claim inline. End with a "References" section.

Save the result to `~/lessons/<YYYY>/<slug>.md` (slugify the topic, ASCII).
Create parent directories if missing. Report the saved path back to the user in Korean.
