# /lesson — Generate a lesson plan in the standard format
#
# Usage:  /lesson <topic> [age:<N>] [duration:<min>]
# Example: /lesson 광합성 age:12 duration:50

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

Save the result to `~/lessons/<YYYY>/<slug>.md` (slugify topic, ASCII).
Create parent directories if missing. Report the saved path back in Korean.
