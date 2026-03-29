# Theme
ZSH_THEME="spaceship"

# Options
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_PROMPT_ASYNC=false
SPACESHIP_PROMPT_ADD_NEWLINE=true # blank line between prompts — much easier to read

# Docker
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOCKER_COLOR="cyan"

# Time
SPACESHIP_TIME_SHOW=true          # it's off by default!
SPACESHIP_TIME_COLOR="240"        # subtle gray so it doesn't distract
SPACESHIP_TIME_FORMAT="%T"        # 24h format (HH:MM:SS), or "%t" for 12h

# Directories
SPACESHIP_DIR_TRUNC=5             # only show last 5 directories (default is 3)
SPACESHIP_DIR_TRUNC_REPO=true     # truncate relative to git repo root
SPACESHIP_DIR_COLOR="69"
SPACESHIP_DIR_PREFIX=" 📂 "

# Git
SPACESHIP_GIT_PREFIX="em "        # or "⎇ " for a branch symbol
SPACESHIP_GIT_SYMBOL="⎇ "        # replaces the default  icon if your font doesn't support it
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_PREFIX=" ["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_GIT_BRANCH_COLOR="49"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_MODIFIED="!"
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_STASHED="$"
SPACESHIP_GIT_STATUS_AHEAD="↑"
SPACESHIP_GIT_STATUS_BEHIND="↓"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"
SPACESHIP_GIT_STATUS_COLOR="red"

# Node
SPACESHIP_PACKAGE_SHOW=true
SPACESHIP_PACKAGE_COLOR="blue"

# Execution time
SPACESHIP_EXEC_TIME_COLOR="yellow"
SPACESHIP_EXEC_TIME_ELAPSED=2      # show after 2s instead of default 5
SPACESHIP_EXEC_TIME_PREFIX="demorou "

# Char
SPACESHIP_CHAR_SYMBOL="⚡"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_CHAR_COLOR_FAILURE="red" # turns red on last command failure

spaceship_laura() {
	spaceship::section --color "129" "laura@"
}

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  laura 		# me
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  node          # Node.js section
  package       # Node Package
  golang        # Go section
  docker        # Docker section
  venv          # virtualenv section
  exec_time		# Execution time
  line_sep      # Line break
  char          # Prompt character
)