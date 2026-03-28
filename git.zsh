# Git aliases
alias gti="git"
alias gst.="git status ."
alias gcqa="gco qa"
alias gbD='git branch --delete --force'
alias glprs="git log | grep \"Merge pull request #\""
alias glaca="git log --format=\"%h %s (Author: %an) %(trailers:key=Co-authored-by)\""
alias gtl="git for-each-ref --sort=-creatordate --format '%(refname:short)' refs/tags | head -n 1"
alias gbcd='branch=$(git branch --show-current) && gcd && gl && gbd "$branch"'
alias gbcm='branch=$(git branch --show-current) && gcm && gl && gbd "$branch"'

sshow() { git stash show stash^{/$*} -p; }
sapply() { git stash apply stash^{/$*}; }

# Update all git submodules to latest remote
gsubup() { git submodule update --remote --merge; }

# Delete local branches under a given prefix (e.g., backup/)
function gbDA() {
  emulate -L zsh
  setopt extended_glob

  local prefix="$1"

  if [[ -z "$prefix" ]]; then
    print -r -- "Usage: gbDA <prefix>"
    print -r -- "Examples:"
    print -r -- "  gbDA backup/                     # delete all local branches starting with backup/"
    print -r -- "  gbDA backup/claude-scrub-feature # delete only backup/claude-scrub-feature*"
    return 0
  fi

  [[ "$prefix" != */ ]] && prefix="${prefix}/"

  local branches
  branches=("${(@f)$(git branch --list --format='%(refname:short)' "${prefix}*")}")

  if (( ${#branches} == 0 )); then
    print -r -- "No branches match: ${prefix}*"
    return 0
  fi

  local current
  current="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local filtered=()
  local b
  for b in $branches; do
    [[ "$b" != "$current" ]] && filtered+="$b"
  done

  if (( ${#filtered} == 0 )); then
    print -r -- "Only current branch matched; nothing to delete."
    return 0
  fi

  print -r -- "Deleting ${#filtered} branch(es):"
  printf '  %s\n' $filtered

  for b in $filtered; do
    git branch -D -- "$b" || return $?
  done
}

# Generate a patch file from current branch vs base
# Usage:
#   gpatch                # diffs current branch vs origin/DEFAULT (remote HEAD)
#   gpatch main           # diffs current branch vs origin/main
function gpatch() {
  local base_branch current_branch safe_branch patch_file

  if [[ -n "$1" ]]; then
    if [[ "$1" == */* ]]; then
      base_branch="$1"
    else
      base_branch="origin/$1"
    fi
  else
    base_branch="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/@@')"
  fi

  if [[ -z "$base_branch" ]]; then
    echo "Error: Could not determine base branch (try: gpatch main)" >&2
    return 1
  fi

  if ! git rev-parse --verify --quiet "$base_branch" >/dev/null; then
    echo "Error: Base branch '$base_branch' not found." >&2
    return 1
  fi

  current_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  if [[ "$current_branch" == "HEAD" || -z "$current_branch" ]]; then
    current_branch="$(git rev-parse --short HEAD)"
  fi

  safe_branch="${current_branch//\//_}"
  patch_file="${safe_branch}.patch"

  echo "Diffing against $base_branch..."
  if git diff --no-color "$base_branch"...HEAD > "$patch_file"; then
    echo "Patch written to $patch_file"
  else
    echo "Error creating patch." >&2
    return 1
  fi
}

# List files changed in a patch
gpatchfiles() {
  emulate -L zsh
  setopt pipefail

  local _sed_out
  if [[ -n "$1" ]]; then
    _sed_out=$(LC_ALL=C sed -n -E 's|^diff --git a/(.+) b/(.+)$|\1\t\2|p' < "$1")
  else
    _sed_out=$(LC_ALL=C sed -n -E 's|^diff --git a/(.+) b/(.+)$|\1\t\2|p')
  fi

  if [[ -z "$_sed_out" ]]; then
    return 0
  fi

  print -r -- "$_sed_out" \
  | awk -F '\t' '
      {
        a=$1; b=$2;
        if (b != "/dev/null") print b; else print a;
      }
    ' \
  | sed -E 's|^"(.+)"$|\1|' \
  | sort -u
}

