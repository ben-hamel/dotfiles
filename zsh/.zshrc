#Homebrew
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

#Env Var
export XDG_CONFIG_HOME="$HOME/.config"

#TERMINAL
# export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS" # Wezterm
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

#PROMPT 
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # OH MY POSH
  # eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
  eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tokyonight_storm.omp.json')"

  #STARSHIP
  # export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml" # sets path to config since in different location then default
  # eval "$(starship init zsh)" 
fi
###

#TOOLS
eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"


#COMPLETIONS
autoload -Uz compinit && compinit # AWS pt 1 https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit # AWS pt 2
complete -C /opt/homebrew/bin/aws_completer aws # AWS pt 3
complete -o nospace -C /opt/homebrew/bin/terraform terraform # https://developer.hashicorp.com/terraform/cli/commands#shell-tab-completion

#ZSH PLUGINS
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
