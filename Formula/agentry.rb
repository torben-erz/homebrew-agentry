# Homebrew-Formula-Template für Agentry.
#
# Diese Datei wird vom Release-Workflow (`.github/workflows/release.yml`,
# Job `update-tap`) gerendert und ins Tap-Repo
# `torben-erz/homebrew-agentry` als `Formula/agentry.rb` committed.
# Die Platzhalter im `version`/`url`/`sha256`-Block unten werden vor dem
# Push durch echte Werte ersetzt — Render-Mechanik siehe Workflow-Datei.
# Achtung: alle Platzhalter-Tokens dürfen nur EINMAL im File vorkommen
# (im funktionalen Block), nicht zusätzlich in dieser Doku-Kopfzeile —
# sonst zerstört die sed-Substitution die Kommentar-Semantik.
#
# Installation aus dem Tap:
#   brew tap torben-erz/agentry
#   brew install agentry
#
# Die Formula installiert ein vorgebautes Binary aus
# `torben-erz/agentry-dist`. Source wird nicht aus Homebrew gebaut, weil
# der Source-Code im privaten Haupt-Repo lebt; das macOS-Binary ist
# signiert (Developer-ID) und notarisiert.

class Agentry < Formula
  desc "Plattform-agnostisches Agenten-Framework — Tickets autonom in Pull Requests verwandeln"
  homepage "https://github.com/torben-erz/agentry-dist"
  version "0.1.0-beta.7"
  license "Proprietary" # Wird sich mit der Vertriebsmodell-Entscheidung klären.

  on_macos do
    on_arm do
      url "https://github.com/torben-erz/agentry-dist/releases/download/v0.1.0-beta.7/agentry-v0.1.0-beta.7-macos-arm64.tar.gz"
      sha256 "0d952d03e7649d2a999d00af552d621353bdd0b362868a7a9a8fba14b9a23349"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/torben-erz/agentry-dist/releases/download/v0.1.0-beta.7/agentry-v0.1.0-beta.7-linux-x86_64.tar.gz"
      sha256 "9c2cca061c9bd7b4543bf05035859ac99fdf097c8aa9f71a0fa9d72f2411fd98"
    end
  end

  depends_on "git"
  # Optionale Laufzeit-Abhängigkeiten — werden nicht erzwungen, weil der
  # Operator entscheidet, welchen Agent / Provider er nutzt:
  #   brew install gh        # für provider="github"
  #   brew install glab      # für provider="gitlab"
  #   brew install bubblewrap  # auf Linux: Sandbox-Voraussetzung
  # Agent-CLIs (claude, codex) kommen über npm/Vendor-Pfade rein.

  def install
    bin.install "agentry"
  end

  test do
    # Smoke-Test: Version-Subcommand muss ohne Fehler durchlaufen und
    # einen Versionsstring drucken.
    output = shell_output("#{bin}/agentry version")
    assert_match(/^agentry \d+\.\d+\.\d+/, output)
  end

  def caveats
    <<~EOS
      Agentry braucht zur Laufzeit eine Provider-CLI:
        brew install gh       # GitHub  (provider="github", Default)
        brew install glab     # GitLab  (provider="gitlab")
      und eine Agent-CLI (z. B. claude oder codex — siehe Doku).

      Auf Linux ist 'bubblewrap' Pflicht für die Default-Sandbox:
        sudo apt-get install bubblewrap   # Debian/Ubuntu
        sudo dnf install bubblewrap        # Fedora

      Erstes Setup:
        agentry init
        $EDITOR ~/.agentry/config.json     # 'watch' auf dein Repo setzen
        agentry config validate
        agentry daemon

      Update-Pfad:
        brew upgrade agentry               # bringt das nächste Beta-Release

      Doku + Beta-Walkthrough:
        https://github.com/torben-erz/agentry-dist
    EOS
  end
end
