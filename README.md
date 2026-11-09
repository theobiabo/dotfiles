# macOS dotfiles

## Set up a new Mac

Paste this line into Terminal on the new Mac:

```sh
mac_setup=$(curl -fsSL https://raw.githubusercontent.com/theobiabo/dotfiles/main/setup.sh) && /bin/bash -c "$mac_setup"
```

The [setup script](setup.sh) installs Homebrew and chezmoi, installs the apps, tools, and extensions in the [Brewfile](Brewfile), and sets up Oh My Zsh. It then applies the dotfiles to your account and checks the installed packages.

Run it as your normal user. macOS may ask for your administrator password or prompt you to install the Command Line Tools. When you see `Setup complete`, open a new Terminal window to load your shell settings.

If an install is interrupted, run the same command again. Sign in to your apps and transfer your project files separately.
