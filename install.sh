#!/bin/zsh

mode=${1:-local}
app=$2

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install all available updates
#sudo softwareupdate -ia --verbose

APPS=(
  homebrew
  homebrew-x86
  shell
  vscode
  iterm2
  ssh
  python
  golang
  defaults
)

# Sources all the preference files
function source_apps {
  local array_name=$1

  declare -a files=(${(P)${array_name}[@]})
  for file in "${files[@]}"; do
    if [ -n "$app" ]; then
      if [ "${file}" != "$app" ]; then
        continue
      fi
    fi
    file="${2}${file}.sh"
    [ -r "$file" ] && [ -f "$file" ] && source "$file" $mode
  done;
}

source_apps APPS "apps/"