#!/bin/bash
set -euo pipefail

touch ~/.zshrc.local

echo "Please enter git name: "
read git_name
echo "export GIT_AUTHOR_NAME=\"$git_name\" && export GIT_COMMITTER_NAME=\$GIT_AUTHOR_NAME" >> ~/.zshrc.local

echo "Please enter git email: "
read git_email
echo "export GIT_AUTHOR_EMAIL=\"$git_email\" && export GIT_COMMITTER_EMAIL=\$GIT_AUTHOR_EMAIL" >> ~/.zshrc.local

if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -C "$git_email"
  ssh-add ~/.ssh/id_ed25519
fi
