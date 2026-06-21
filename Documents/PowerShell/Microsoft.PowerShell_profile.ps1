# PowerShell 7 profile — managed by chezmoi.
# The Windows counterpart to ~/.zshrc. Turns on starship, zoxide, fzf, predictions.
# Every block is guarded so this profile is SAFE to load before the tools are installed.

# --- starship: the prompt. Same config as the Mac (~/.config/starship.toml). ---
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# --- zoxide: smart cd. After visiting dirs, `z <name>` jumps to the best match. ---
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# --- PSReadLine: predictive IntelliSense — greyed-out suggestions from history. ---
# (PSReadLine ships with PowerShell 7, so no install needed.)
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView   # InlineView = subtler alternative

# --- fzf: fuzzy finder. PSFzf gives Ctrl-R (history) + Ctrl-T (files), like zsh. ---
if (Get-Module -ListAvailable -Name PSFzf) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# --- editor ---
$env:EDITOR = 'code --wait'
