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

## When working with code
- If tests exist and your change could affect them, run them before
  declaring done; report results.
- If the project defines a lint/format command (package.json scripts,
  pyproject.toml, Makefile, etc.), run it before committing.
- Default to no comments. Add only when the *why* is non-obvious.
- Prefer `rg` over `grep`, `fd` over `find` when available.

## Templates (full versions live in slash commands)
- Lesson plan → see `commands/lesson.md` (Claude) or `prompts/lesson.md` (Codex).
  Invoke via `/lesson <topic> [age:<N>] [duration:<min>]`.
- Research notes → see `commands/research.md` or `prompts/research.md`.
  Invoke via `/research <topic>`.

## Defaults
- Save lesson drafts under `~/lessons/<YYYY>/<slug>.md`
- Save research notes under `~/research/<slug>.md`
- Lesson body and research notes: Korean. Cite all factual claims; end with
  a "References" section.
- Create parent directories if missing.
