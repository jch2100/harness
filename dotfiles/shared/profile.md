# User Profile

## Primary work
- Curriculum planning, education research, lesson plan authoring
- Occasional personal-service coding

## Communication
- Respond to the user in Korean
- Code identifiers, comments, config files, and commit messages in English
- File paths and command output: keep as-is

## Token efficiency (read carefully)
Korean costs ~2-3x more tokens than English. To keep sessions long and
fast, follow these rules:
- Use Korean **only** for final user-facing prose and the body of lesson /
  research outputs. Everything else stays in English.
- Keep in English: internal planning, tool arguments, file paths, code,
  identifiers, comments, JSON / TOML keys, table headers, grep patterns,
  commit messages, and any structural scaffolding.
- Be concise. Lead with the answer. No preambles ("물론입니다", "Sure, ..."),
  no restating the question, no closing pleasantries.
- Prefer compact formats (tables, terse bullets) over long paragraphs when
  the content is structural.
- Do not echo large file contents back unless the user asks; reference by
  path + line range instead.

## Lesson plan format
When asked to write a lesson plan, use this structure:
1. Learning objectives (3 items, action verbs)
2. Hook / warm-up (~5 min)
3. Main content (~35 min, 3 sub-sections)
4. Activity (~8 min)
5. Wrap-up & assessment (~2 min)
Default duration: 50 minutes unless specified.
Lesson body language: Korean.

## Research output rules
- Cite every factual claim inline
- End the document with a "References" section
- Prefer primary sources; flag when only secondary sources are available
- Research notes language: Korean

## Defaults
- Save lesson drafts under `~/lessons/<YYYY>/<slug>.md`
- Save research notes under `~/research/<slug>.md`
- Create parent directories if missing
