# HAIL for Gemini CLI

Gemini CLI extension for the Heroes of AI League assessment. It reuses the ChatGPT plugin: the same hosted MCP server (`https://heroleague.ai/mcp`) and the same interview rules (team name, core 8, no local scoring, no payment). Gemini CLI does not render the ChatGPT wizard, so the model asks the core 8 in text from `show_assessment`.

The extension name is `hail`. The version lives in `gemini-extension.json` and matches the ChatGPT plugin.

## Install

```bash
gemini extensions install https://github.com/razzza/hail-gemini-cli-extension
```

Restart Gemini CLI. Ask it to assess a team, or run `/assess`.

A specific release tag:

```bash
gemini extensions install https://github.com/razzza/hail-gemini-cli-extension --ref=1.0.4
```

## Develop

From this directory in the product repo:

```bash
gemini extensions link .
```

## Release

The [extension gallery](https://geminicli.com/extensions/browse/) indexes this public repository because `gemini-extension.json` is at the root and the repository topic is `gemini-cli-extension`. The crawler runs daily after the repository is tagged.

`main` is the stable channel. A push to `main` is what prompts an update for people who installed the repository. `HEAD` is the latest version.

This extension has no platform-specific binaries. `./package.sh` writes `dist/hail.tar.gz` with `gemini-extension.json` at the archive root. The GitHub Release tag matches the `version` in `gemini-extension.json` (currently `1.0.4`) and is marked Latest. The CLI detects updates from that tag and shows the manifest version in the UI. `--pre-release` installs a release that is not marked Latest.

Republish from the product repo with `./scripts/publish-hail-gemini.sh`.
