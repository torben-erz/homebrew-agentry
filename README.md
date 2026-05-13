# torben-erz/agentry — Homebrew-Tap

Homebrew-Tap für [Agentry](https://github.com/torben-erz/agentry-dist) —
ein plattform-agnostisches Agenten-Framework, das Tickets autonom in
Pull Requests verwandelt.

## Installation

```bash
brew tap torben-erz/agentry
brew install agentry
```

Die Formula installiert ein vorgebautes Binary aus
[`torben-erz/agentry-dist`](https://github.com/torben-erz/agentry-dist).
macOS-Binaries sind signiert (Developer-ID) und notarisiert.

Erster Start:

```bash
agentry init
$EDITOR ~/.agentry/config.json     # 'watch' auf dein Repo setzen
agentry daemon
```

## Updates

```bash
brew upgrade agentry
```

Der Daemon erkennt zur Laufzeit, dass das Binary unter einem
Homebrew-Prefix liegt, und nennt `brew upgrade agentry` explizit im
WARN-Log, sobald eine neuere Version verfügbar ist.

## Was dieser Tap macht

- Hält genau **eine** Formula (`Formula/agentry.rb`), die das
  `agentry`-Binary aus `agentry-dist` herunterlädt und nach
  `$(brew --prefix)/bin/agentry` installiert.
- Plattform-Switch über Homebrew-`on_macos`/`on_linux`-Blocks:
  - macOS Apple Silicon → `agentry-vX.Y.Z-macos-arm64.tar.gz`
  - Linux x86_64 → `agentry-vX.Y.Z-linux-x86_64.tar.gz`
- Wird vom Release-Workflow im (privaten) Source-Repo automatisch
  aktualisiert. Bei jedem neuen `v*`-Tag landet hier ein Commit mit
  neuer Version + neuen SHA256-Werten.

## Voraussetzungen

Die Formula installiert nur das `agentry`-Binary selbst. Provider-
und Agent-CLIs müssen separat installiert werden:

```bash
brew install gh                    # GitHub-Provider (Default)
brew install glab                  # GitLab-Provider (optional)
brew install bubblewrap            # Linux-Sandbox-Voraussetzung
# Agent-CLIs (claude, codex) kommen über npm / Vendor-Pfade rein.
```

## Lizenz

Die Formula in diesem Repository steht unter der MIT-Lizenz (siehe
`LICENSE`). Das Binary, das sie installiert, folgt seiner eigenen
Lizenz — siehe das Distribution-Repo
[`torben-erz/agentry-dist`](https://github.com/torben-erz/agentry-dist).

## Status

Closed Beta seit 2026-05. Die Tap-URL wird derzeit nur an
Beta-Tester weitergegeben.
