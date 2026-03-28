# Lazy environment loader — defers slow tool init to ~2s after prompt via zinit
# Requires: zinit (https://github.com/zdharma-continuum/zinit)

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
else
  return 0
fi

## == Core Functions ===========================================================

evalenv() {
  local ENVNAME="$1"
  local ENVEXPORT="$2"
  local ENVEVAL="$3"

  local ENVPATH="\${${ENVEXPORT}}"
  echo "export ${ENVEXPORT}=\"\${${ENVEXPORT}:=${HOME}/.${ENVNAME}}\""
  if (( ! ${+commands[${ENVNAME}]} )) && [[ -f ${ENVPATH}/bin/${ENVNAME} ]]; then
    echo "export PATH=\"${ENVPATH}/bin:\${PATH}\""
  fi

  if (( ${+commands[${ENVNAME}]} )); then
    echo "
    export PATH=\"${ENVPATH}/bin:${ENVPATH}/shims:\${PATH}\"
    $(eval ${ENVEVAL})
    "
  fi
}

evalfn() {
  local FNNAME="$1"
  local FNEVAL="$2"

  if (( ${+commands[${FNNAME}]} )); then
    echo "$(eval ${FNEVAL})"
  fi
}

ifF() {
  ((eval "$1") && echo "$2") || echo "$3"
}

## == Lazy Command Registry ====================================================

LAZYENV_COMMANDS=""
lazyenv-add() {
  LAZYENV_COMMANDS="${LAZYENV_COMMANDS=};evalenv $1 $2 \"$3\""
}
lazyfn-add() {
  LAZYENV_COMMANDS="${LAZYENV_COMMANDS=};evalfn $1 \"$2\""
}

lazyenv-apply() {
  zinit ice wait"2" id-as"_local/lazyenv" lucid \
          eval"${LAZYENV_COMMANDS}" run-atpull
  zinit light zdharma-continuum/null
  typeset -U path
}

## == Tool Configuration =======================================================

# nvm
lazyenv-add nvm NVM_DIR "
ifF '[[ \$OSTYPE == \"darwin\"* ]]' \
'[[ -s \\\$(brew --prefix nvm)/nvm.sh ]] && source \\\$(brew --prefix nvm)/nvm.sh --no-use' \
'[[ -s \"\${NVM_DIR}/nvm.sh\" ]] && . \"\${NVM_DIR}/nvm.sh\" --no-use
 [[ -s \"\${NVM_DIR}/bash_completion\" ]] && \. \"\${NVM_DIR}/bash_completion\"'
"

# pyenv + virtualenv
lazyenv-add pyenv PYENV_ROOT "command pyenv init - && command pyenv virtualenv-init -"

# Completions and hooks
lazyfn-add direnv  "direnv hook zsh"
lazyfn-add kubectl "kubectl completion zsh"
lazyfn-add brew    "echo 'FPATH=\\\$(brew --prefix)/share/zsh/site-functions:\$FPATH'"

lazyenv-apply

## == Script-based lazy loads (zinit direct) ====================================

# GVM (Go Version Manager)
zinit ice wait"2" lucid id-as"gvm" \
  eval'[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm" && export PATH="$(go env GOPATH)/bin:$PATH"'
zinit light zdharma-continuum/null

# SDKMAN
zinit ice wait"2" lucid id-as"sdkman" \
  eval'export SDKMAN_DIR="$HOME/.sdkman"; [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"'
zinit light zdharma-continuum/null

# Google Cloud SDK
zinit ice wait"2" lucid id-as"gcloud" \
  eval'[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"; [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"'
zinit light zdharma-continuum/null
