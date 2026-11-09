# macOS dotfiles

The [Brewfile](Brewfile) installs my apps, command-line tools, and editor extensions. Chezmoi restores my shell, terminal, and editor settings.

## Set up a new Mac

1. **Install Homebrew.** Open Terminal on the new Mac and run the [official installer](https://brew.sh/).

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

   Follow the installer’s **Next steps** to put `brew` on your PATH. Run `brew --version` in the same terminal before continuing.

2. **Install the software.** Initialize chezmoi from GitHub, then run Homebrew Bundle against the Brewfile in that checkout.

   ```sh
   brew install chezmoi
   chezmoi init --depth=1 https://github.com/theobiabo/dotfiles.git
   brew bundle install --file="$(chezmoi source-path)/Brewfile"
   ```

3. **Restore the settings.** The saved Zsh configuration loads Oh My Zsh. Install it if needed, then preview the dotfiles.

   ```sh
   test -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" || git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
   chezmoi diff
   ```

   These settings use `/opt/homebrew` and some paths under `/Users/obiabo`. On an Intel Mac or a Mac with a different account name, adjust those paths in the chezmoi checkout before applying. Once the preview looks right, apply the settings and check the installed packages.

   ```sh
   chezmoi apply
   brew bundle check --no-upgrade --file="$(chezmoi source-path)/Brewfile"
   ```

Open a new Terminal window to load the shell settings. Sign in to your apps and transfer project files separately.
