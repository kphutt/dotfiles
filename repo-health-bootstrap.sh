# repo-health L0 bootstrap — INERT until sourced from your shell profile (reserved activation step).
#
# Purpose: on a fresh machine, self-configure ai-toolkit with ZERO memorized steps — but ONLY safely.
# It runs `setup.py --apply` exactly once, and only when BOTH:
#   (1) the machine is unconfigured (~/.claude/.ai-toolkit-managed.json absent), and
#   (2) ai-toolkit HEAD is a verified/pinned tag (NOT a floating branch).
# This is the supply-chain guard (INV-14 / SANDWORM_MODE): a self-executing auto-run must never run
# from a mutable branch. It is NOT an unconditional every-shell `setup.py` call.
#
# ACTIVATION (reserved — do on a watched session, after the SANDWORM sweep is clean on this machine):
#   zsh/bash:   echo 'source ~/dev/dotfiles/repo-health-bootstrap.sh' >> ~/.zshrc   # (or ~/.bashrc)
#   PowerShell: add the equivalent block (below) to $PROFILE.
# Until you do that, this file does nothing.

__repo_health_bootstrap() {
  AT="$HOME/dev/ai-toolkit"
  [ -d "$AT/.git" ] || return 0
  [ -f "$HOME/.claude/.ai-toolkit-managed.json" ] && return 0      # already configured -> no-op
  # supply-chain gate: only auto-run from an exact, ideally-signed tag; refuse on a branch/untagged HEAD.
  tag="$(git -C "$AT" describe --exact-match --tags 2>/dev/null)" || return 0
  case "$tag" in repo-health-v*|v[0-9]*) ;; *) return 0 ;; esac
  # stronger posture (enable once tags are signed): refuse if the tag isn't verifiable.
  # git -C "$AT" verify-tag "$tag" >/dev/null 2>&1 || return 0
  if command -v python3 >/dev/null 2>&1; then PY=python3; else PY=python; fi
  echo "repo-health: first-run config from ai-toolkit@$tag ..."
  ( cd "$AT" && "$PY" setup.py --apply )
}
__repo_health_bootstrap

# ── PowerShell equivalent (for $PROFILE on the Windows PC) ──────────────────────────────
# $at = "$HOME/dev/ai-toolkit"
# if ((Test-Path "$at/.git") -and -not (Test-Path "$HOME/.claude/.ai-toolkit-managed.json")) {
#   $tag = (git -C $at describe --exact-match --tags 2>$null)
#   if ($LASTEXITCODE -eq 0 -and ($tag -match '^(repo-health-v|v[0-9])')) {
#     $py = if (Get-Command python3 -ErrorAction SilentlyContinue) {"python3"} else {"python"}
#     Write-Host "repo-health: first-run config from ai-toolkit@$tag ..."
#     Push-Location $at; & $py setup.py --apply; Pop-Location
#   }
# }
