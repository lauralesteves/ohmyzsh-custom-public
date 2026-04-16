export MAX_THINKING_TOKENS="${MAX_THINKING_TOKENS:-63999}"
export CLAUDE_CODE_ALWAYS_ENABLE_EFFORT="${CLAUDE_CODE_ALWAYS_ENABLE_EFFORT:-1}"
export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING="${CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING:-1}"
export CLAUDE_CODE_EFFORT_LEVEL="${CLAUDE_CODE_EFFORT_LEVEL:-max}"

NUDGE_FILE="$HOME/.claude/thinking-nudge.txt"
CLI="$HOME/.local/bin/claude"

claude() {
	if [ -f "$NUDGE_FILE" ]; then
		"$CLI" --append-system-prompt-file "$NUDGE_FILE" "$@"
	else
		"$CLI" "$@"
	fi
}