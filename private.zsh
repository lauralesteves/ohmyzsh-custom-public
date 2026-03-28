# Source all zsh files from the private directory
for config_file ("$ZSH_CUSTOM"/private/*.zsh(N)); do
  source "$config_file"
done
unset config_file
