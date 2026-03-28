# Reload: Update Source
reload() {                                                                                                                                                                                                                   
  source ~/.zshrc                                         
  for f ("$ZSH_CUSTOM"/*.zsh(N)); do source "$f"; done
}

# Process search
function psg() {
  ps aux | grep "$1"
}

# Process kill
killport() { 
  lsof -ti:"$1" | xargs kill -9 2>/dev/null && echo "Killed processes on port $1" || echo "No process on port $1"; 
}

# History search
function hg() {
  history | grep "$1"
}

# Blue text
blue() { tput setaf 4; echo $@; tput sgr0; }

# File search
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }


# Delete node_modules recursively
function delete_node_modules_recursive() {
  find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
}

# Replace em-dashes with semicolons in .md files
function desgpt() {
  find . -type f -name "*.md" | while read -r file; do
      if grep -q " — " "$file"; then
          sed -i '' 's/ — /; /g' "$file"
          echo "Atualizado: $file"
      fi
  done
}

# Search aliases and functions by keyword
# Usage: aliases docker    aliases git push
aliases() {
  local search="$*"
  local files=("$ZSH_CUSTOM"/*.zsh(N) "$ZSH_CUSTOM"/private/*.zsh(N))
  local existing=()
  for f in "${files[@]}"; do
    [[ -f "$f" ]] && existing+=("$f")
  done
  [[ ${#existing[@]} -eq 0 ]] && return

  awk -v search="${search:-.}" '
    BEGIN {
      search = tolower(search)
      n = split(search, keywords, " ")
    }
    /^alias / {
      check_and_store($0)
    }
    /^[a-zA-Z_][a-zA-Z0-9_]* *\(\)/ {
      in_fn = 1; body = ""
    }
    in_fn {
      body = body $0 "\n"
      if (/^\}/) {
        check_and_store(body)
        in_fn = 0
      }
    }
    function check_and_store(block) {
      lower = tolower(block)
      hits = 0
      for (i = 1; i <= n; i++) {
        if (lower ~ keywords[i]) hits++
      }
      if (hits > 0) {
        blocks[++count] = block
        scores[count] = hits
      }
    }
    END {
      for (i = 2; i <= count; i++) {
        kb = blocks[i]; ks = scores[i]; j = i - 1
        while (j > 0 && scores[j] > ks) {
          blocks[j+1] = blocks[j]; scores[j+1] = scores[j]; j--
        }
        blocks[j+1] = kb; scores[j+1] = ks
      }
      for (i = 1; i <= count; i++) {
        printf "%s\n", blocks[i]
      }
    }
  ' "${existing[@]}" | \
  if [[ -n "$search" ]]; then
    grep --color=always -i -E "$(echo "$search" | tr ' ' '|')|$"
  else
    command cat
  fi
}

# Universal extract
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz)  tar xvzf $1;;
      *.bz2)     bunzip2 $1;;
      *.rar)     unrar x $1;;
      *.gz)      gunzip $1;;
      *.tar)     tar xvf $1;;
      *.tbz2)    tar xvjf $1;;
      *.tgz)     tar xvzf $1;;
      *.zip)     unzip $1;;
      *.Z)       uncompress $1;;
      *.7z)      7z x $1;;
      *)         echo "'$1' cannot be extracted via extract";;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Time zsh startup
zsh-time() { time zsh -i -c exit; }

# Create file with parent directories
mktouch() { mkdir -p $(dirname $1) && touch $1; }

# Open man page as PDF in Preview
pdfman() { man $1 -t | open -f -a Preview; }

# Show sizes of subdirectories
folder-sizes() { find . -maxdepth 1 -type d -mindepth 1 -exec du -hs {} \; }

# Top 30 most used commands
tophistory() {
  history | awk '{a[$2]++} END{for(i in a){print a[i] " " i}}' | sort -rn | head -n 30
}

# Colorized man pages
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
      LESS_TERMCAP_md=$'\E[01;38;5;74m' \
      LESS_TERMCAP_me=$'\E[0m' \
      LESS_TERMCAP_se=$'\E[0m' \
      LESS_TERMCAP_so=$'\E[38;5;246m' \
      LESS_TERMCAP_ue=$'\E[0m' \
      LESS_TERMCAP_us=$'\E[04;38;5;146m' \
      man "$@"
}
