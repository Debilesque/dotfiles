PWD="$(pwd)"
ACCOUNT="https://github.com/jellu-cat"
REPODIR="~/repos"

echo $PWD
echo $ACCOUNT

## clone lemonpie, scripts, emacs, nvim, dotfiles
git clone ${ACCOUNT}/dotfiles ${REPODIR}
git clone ${ACCOUNT}/scripts ${REPODIR}
git clone ${ACCOUNT}/nvim ${REPODIR}
git clone ${ACCOUNT}/emacs ${REPODIR}

## ---

# sudo ln -s $PWD/bash/etc/bashrc /etc/bash-path.sh

# sudo ln -s ~/repos/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
# sudo ln -s ~/repos/dotfiles/nixos/desktop.nix /etc/nixos/desktop.nix

# mkdir ~/{desktop,downloads,templates,public,documents,music,pictures,videos}

# xdg-user-dirs-update
