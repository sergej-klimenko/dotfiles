#!/bin/zsh
set -e

###############################################################################
# Python
###############################################################################

mode=$1

if [ "$mode" = "remote" ]; then
  return 0
fi

echo "Python ($mode)"

# pyenv *should* be installed at this point
hash pyenv 2>/dev/null || echo "Please install pyenv before continuing"

# Install latest (stable) Python
python_latest=$(pyenv install -l 2>/dev/null | awk '$1 ~ /^[0-9.]*$/ {latest=$1} END {print latest}')
pyenv install --skip-existing $python_latest
pyenv rehash
pyenv global $python_latest

eval "$(pyenv init -)"

# pip *should* be installed at this point
hash pip 2>/dev/null || echo "Please install pip before continuing"

pip_packages=(
  bump2version
)

# Loop through each package individally because
# any errors will stop all installations
for package in "${pip_packages[@]}"; do
  pip install --upgrade "$package" --user
done

#git clone https://github.com/s1341/pyenv-alias.git $(pyenv root)/plugins/pyenv-alias