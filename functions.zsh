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
