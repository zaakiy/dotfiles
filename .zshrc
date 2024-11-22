
export TERM=xterm-256color



# If Mac OS
if [[ "$(uname)" == "Darwin" ]]; then 
  # Check if Homebrew is installed; if not, install it
  if ! command -v brew &>/dev/null; then
	# Check if the system is macOS
	echo "Homebrew not found. Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install gcc
    
	# Install each app with the function
	# brew install fzf       # For ** fuzzy find file/directory searches
	brew install bat       # Like cat but with better formatting
	brew install zoxide    # Faster directory changing (like cd)
	brew install ripgrep   # Search and replace for LazyVim using leader s r
	brew install thefuck   # Command suggestions
	brew install xclip     # Clipboard support for Neovim
	brew install tmux      # tmux for text-based windowing
	brew install neovim
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git
	brew install jesseduffield/lazygit/lazygit #lazygit
  	brew install typescript typescript-language-server

  fi

  # set brew environment on Mac
  eval "$(/opt/homebrew/bin/brew shellenv)"
  

else
  if ! command -v nala &>/dev/null; then
    # Other items are probably also not installed
    sudo apt update
    sudo apt install nala -y
    sudo nala install -y gcc bat zoxide ripgrep xclip tmux neovim nodejs npm node-typescript 
    
  fi
fi



# ubind ^s
bindkey -r '^S'

# Initialize Zsh Completions and Powerlevel10k instant prompt
autoload -Uz compinit
compinit -u  # Use -u to suppress insecure directories warning

# Enable Powerlevel10k instant prompt. Keep this at the top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit setup
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    echo "Installing Zinit Plugin Manager..."
    mkdir -p "$HOME/.local/share/zinit" && chmod g-rwX "$HOME/.local/share/zinit"
    git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Zinit annexes and plugins
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zsh-users/zsh-completions \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-syntax-highlighting \
    ohmyzsh/ohmyzsh

# install fzf if not already installed
# this need to go AFTER ohmyzsh
# source: https://github.com/junegunn/fzf/issues/1902#issuecomment-602423582
if [ ! -d "$HOME/.fzf" ]; then
  rm -rfv ~/.fzf # leaving this here in case we want to re-install
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --key-bindings --completion --update-rc
  git -C ~/.fzf pull && ~/.fzf/install --key-bindings --completion --no-update-rc
fi

# Load Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Load Powerlevel10k configuration if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

############# MAC ONLY!
# iTerm2 shell integration
[[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"
#############




eval $(thefuck --alias)
eval "$(zoxide init zsh)"
alias cd="z"

if [[ "$(uname)" == "Darwin" ]]; then 
  alias B="brew update && brew upgrade && brew list --cask | tr '\t' '\n' && source ~/.zshrc && zinit self-update && zinit update --all && git -C ~/.fzf pull && ~/.fzf/install --key-bindings --completion --update-rc"
else 
  alias N="sudo nala update && sudo nala upgrade -y && ~/.fzf/install --key-bindings --completion --update-rc"
fi
alias C='clear && printf "\033[3J"'

# Additional key bindings
# Note: fzf environment is not being
bindkey '^@' fzf-history-widget
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh




export EDITOR=nvim



