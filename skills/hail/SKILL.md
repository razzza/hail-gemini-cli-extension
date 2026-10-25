---
name: hail
description: Interview an engineering team with HAIL and place them on a hero archetype for AI adoption and system health. Use when the user wants a HAIL assessment, team archetype, the 8-question form, DORA-style health, or a hero card.
metadata:
  version: "1.0.4"
---

# HAIL

Use the hosted MCP tools at https://heroleague.ai/mcp. Do not score locally. Do not invent an archetype, axes, or share link. If the tools are unreachable, send the user to https://heroleague.ai.

This host does not render the assessment wizard. `show_assessment` returns the core 8. Ask those questions in text. That is the normal path here.

## What this chat does

Call `show_assessment`, then ask the core 8 one question at a time from that tool result. Read each `text`, then its `help`, then the option labels, exactly as written. Do not reword them. Each question has three scored answers, then I don't know. After the eighth answer, call `run_assessment`. Include share_url as a link in that same reply, with the archetype, axes, and actions. The server stores the team name as `Team DDMMYYYY- {intent}`.

## What this chat does not do

The detailed What to Fix playbook is not available in this chat. If `get_playbook` says the playbook is locked, say so and stop. Do not print a playbook. Do not include any URL. Do not take payment, quote a price, or send the user to a checkout page. A payment request gets one sentence and no URL.

## Tools

| Tool | When |
| --- | --- |
| `show_assessment` | Open this first. Returns the core 8 for a text interview. Pass `team_name`. Does not score. |
| `list_questions` | Other profiles. `profile` is `simple`, `professional`, or `advanced`. |
| `run_assessment` | `team_name` plus `answers` as 0-based option indices. Email is optional and only binds a run. |
| `get_result` | Reopen a `run_id` or share slug. |
| `get_playbook` | Only with a save token the user already holds. Otherwise it stays locked. |

## Team name

Do not ask the user for a team name. Build one before the first tool call and pass it as `team_name`.

Shape: `Team DDMMYYYY- {intent}`

- `DDMMYYYY` is today's date. 3 October 2026 is `03102026`.
- `{intent}` is a short phrase for what this conversation is assessing. If they named a team, product, or company, use that phrase as the intent.
- Example: `Team 03102026- fluency assessment`
- Keep the whole name within 60 characters.
- Do not ask the user to confirm or edit it.

## Workflow

1. On a request to assess, diagnose, or open the form, call `show_assessment` immediately with the chosen `team_name`. Do not ask a question first.
2. Ask the core 8 in text from the questions `show_assessment` returned. Do not offer A, B, or C as a rewrite of the labels. Do not ask for a team name. I don't know is index 3 and is left out of the score. The strongest answer is index 2. Do not call `list_questions` for this interview. Collect the indices, then call `run_assessment` with the same `team_name`. If the user already supplied every answer, including the strongest option on every core question, call `run_assessment` directly and skip `show_assessment`. If a user message begins with `Score this HAIL assessment now`, call `run_assessment` immediately with the JSON in that message. Do not ask a question.
3. Present `display_name`, `tagline`, `axes`, `actions`, and `share_url` as a markdown link in that same reply. Use the stored `team_name`. Do not mention price, payment, checkout, or any upgrade URL.
4. Placement needs at least one adoption answer and one health answer. If the tool returns an error, ask for the missing answers. Do not guess a hero.
5. To reopen a result, call `get_result`.

## Answers

`answers` is `{question_key: option_index}`. Indices are 0-based into that profile's options (`simple` scored answers are 0-2). Index 3 is I don't know and is left out of the score. Copy keys from `show_assessment`.
