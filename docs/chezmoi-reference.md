# Chezmoi Quick Reference (macOS)

## 1 · Install

```bash
brew install chezmoi
```

______________________________________________________________________

## 2 · Use an existing cloned repo as the source

```bash
# wipe any half‑done initialisation (safe – only chezmoi’s state)
rm -rf ~/.config/chezmoi ~/.local/share/chezmoi

# point chezmoi at your repo
mkdir -p ~/.config/chezmoi
echo 'sourceDir = "$HOME/repos/dotfiles"' > ~/.config/chezmoi/chezmoi.toml
```

*If your repo stores files under `home/`, keep the file `.chezmoiroot` in the repo with a single line:*

```
home
```

______________________________________________________________________

## 3 · Daily workflow

| Action | Command |
| ---------------------------------------------------- | --------------------------------------------------- |
| **Preview every pending change** | `chezmoi diff` |
| **Verbose dry‑run of apply** | `chezmoi apply -nv` |
| **Replace source state with current local file/dir** | `chezmoi add -f <path>` |
| **Interactive three‑way merge** | `chezmoi merge <path>` |
| **Overwrite local file with tracked version** | `chezmoi apply -nv <path>` → `chezmoi apply <path>` |
| **Ignore a path forever** | add it to `.chezmoiignore` |

______________________________________________________________________

## 4 · Finalise & sync

```bash
# last sanity check
chezmoi diff

# write changes to $HOME
chezmoi apply

# commit & push
chezmoi cd      # opens a shell in the repo
git add .
git commit -m "Sync dotfiles"
git push
```

______________________________________________________________________

## 5 · Handy one‑liners

```bash
chezmoi source-path   # print current source directory
chezmoi doctor        # diagnostic check
chezmoi cd            # cd into the source repo
```

*Stay in dry‑run (`-n`) mode until the diff looks perfect – then apply once.*
