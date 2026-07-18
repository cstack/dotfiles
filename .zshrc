THIS_FILE=/Users/cstack/.zshrc
echo "Loading ${THIS_FILE}"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

# Python development
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

# Go development
export PATH=$HOME/go/bin:$PATH

# My own personal aliases
alias be="bundle exec"
alias config="subl ~/.zshrc"
alias gap="git add --patch"
alias gcam="git commit --amend"
alias gco="git checkout"
alias gd="git diff"
alias gitnit="git commit --amend --no-edit"
alias gp="git pull"
alias gs="git status"
alias reload="source ${THIS_FILE}"
alias venv="(test -d venv || python -m venv venv) && source venv/bin/activate"

function who_is_listening_on_port {
  lsof -nP -iTCP -sTCP:LISTEN | grep $1
}

function update-agents {
  if brew list --cask codex >/dev/null 2>&1; then
    brew upgrade --cask codex
  else
    brew install --cask codex
  fi

  if brew list --cask claude-code >/dev/null 2>&1; then
    brew upgrade --cask claude-code
  else
    brew install --cask claude-code
  fi
}

current_git_branch() {
  # current git branch if present, otherwise " "
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function venv_prompt() {
  if [[ -z "${VIRTUAL_ENV}" ]]; then
  else
    echo " (venv) "
  fi
}

###
# custom prompt
###
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# %1~ - last part of working directory, using "~" for home directory
# %% - "%" literal
# %B - start boldface
# %b - stop boldface
setopt prompt_subst
function precmd {
  PS1="%(?..%B[exit code %?]%b )%1~ %B$(current_git_branch)%b$(venv_prompt)%% "
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/Users/cstack/.local/bin:$PATH"

export PATH="/opt/homebrew/opt/perl/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cstack/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cstack/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cstack/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cstack/google-cloud-sdk/completion.zsh.inc'; fi

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
