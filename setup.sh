#!/bin/bash
set -euo pipefail

if [[ "$(uname -s)" != Darwin ]]; then
  echo "Run this setup on macOS." >&2
  exit 1
fi

if ! brew_bin=$(command -v brew); then
  case "$(uname -m)" in
    arm64) brew_bin=/opt/homebrew/bin/brew ;;
    *) brew_bin=/usr/local/bin/brew ;;
  esac
fi

if [[ ! -x "$brew_bin" ]]; then
  installer=$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
  /bin/bash -c "$installer"
fi

brew_env=$("$brew_bin" shellenv bash)
eval "$brew_env"
if ! xcode-select --print-path >/dev/null 2>&1; then
  xcode-select --install
  read -r -p "Finish installing the Command Line Tools, then press Return. " < /dev/tty
  xcode-select --print-path >/dev/null
fi
if ! command -v chezmoi >/dev/null; then
  brew install chezmoi
fi

repo_url=https://github.com/theobiabo/dotfiles.git
source_dir=$(chezmoi source-path)
if [[ -e "$source_dir/.git" ]]; then
  origin=$(git -C "$source_dir" remote get-url origin)
  case "${origin%.git}" in
    https://github.com/theobiabo/dotfiles|git@github.com:theobiabo/dotfiles|ssh://git@github.com/theobiabo/dotfiles) ;;
    *) echo "A different chezmoi repository already uses $source_dir." >&2; exit 1 ;;
  esac
  if [[ "$(git -C "$source_dir" branch --show-current)" != main ]]; then
    echo "Switch $source_dir to main before running setup." >&2
    exit 1
  fi
  git -C "$source_dir" pull --ff-only origin main
else
  chezmoi init --depth=1 "$repo_url"
fi

brew bundle install --no-upgrade --file="$source_dir/Brewfile"
if [[ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi
chezmoi apply
brew bundle check --no-upgrade --file="$source_dir/Brewfile"
echo "Setup complete. Open a new Terminal window to load your shell settings."
