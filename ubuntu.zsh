# Ubuntu (and any Linux): only loaded when the shell is running on Linux,
# so macOS keeps its native commands untouched.
if [[ "$OSTYPE" == linux* ]]; then

  # Clipboard: pbcopy / pbpaste behaving exactly like on macOS
  # (pbcopy reads stdin into the clipboard, pbpaste prints the clipboard to stdout).
  # Functions, not aliases: git.zsh (gbcn) is sourced before this file and an alias
  # would not reach a function that was already defined.
  # Wayland uses wl-clipboard; X11 uses xclip, falling back to xsel.
  #   sudo apt install wl-clipboard   # Wayland
  #   sudo apt install xclip          # X11
  if [[ -n "$WAYLAND_DISPLAY" ]] && (( $+commands[wl-copy] )); then
    pbcopy()  { wl-copy "$@"; }
    pbpaste() { wl-paste --no-newline "$@"; }
  elif (( $+commands[xclip] )); then
    pbcopy()  { xclip -selection clipboard "$@"; }
    pbpaste() { xclip -selection clipboard -o "$@"; }
  elif (( $+commands[xsel] )); then
    pbcopy()  { xsel --clipboard --input "$@"; }
    pbpaste() { xsel --clipboard --output "$@"; }
  else
    # Headless (SSH, no display): OSC 52 asks the local terminal to copy, so
    # pbcopy on the server lands in the Mac clipboard. There is no pbpaste here.
    pbcopy()  { printf '\e]52;c;%s\a' "$(base64 | tr -d '\n')"; }
  fi

fi
