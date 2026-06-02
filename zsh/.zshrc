#Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

#Env Var
export XDG_CONFIG_HOME="$HOME/.config"
#export EDITOR=nano
#export STARSHIP_CONFIG=~/.config/starship/starship.toml # sets path to config since in different location then default
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

#CUSTOM PROMPTS
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # OH MY POSH
  # eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
  eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tokyonight_storm.omp.json')"
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tonybaloney.omp.json')"
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/unicorn.omp.json')"
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/bubbles.omp.json')"
  # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/bubblesextra.omp.json')"

  #STARSHIP
  # eval "$(starship init zsh)"
fi
###


#TERMINAL APPS
# Wezterm
# export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

#ZSH PLUGINS
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#TOOLS
export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"


#COMPLETIONS
autoload -Uz compinit && compinit # AWS pt 1 https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit # AWS pt 2
complete -C /opt/homebrew/bin/aws_completer aws # AWS pt 3
complete -o nospace -C /opt/homebrew/bin/terraform terraform # https://developer.hashicorp.com/terraform/cli/commands#shell-tab-completion


