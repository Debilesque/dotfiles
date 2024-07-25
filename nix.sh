PWD="$(pwd)"
ACCOUNT="https://github.com/jellu-cat"
REPODIR="~/repos"

echo $PWD
echo $ACCOUNT

mkdir $REPODIR

## clone lemonpie, scripts, emacs, nvim, dotfiles
git clone ${ACCOUNT}/dotfiles ${REPODIR}
git clone ${ACCOUNT}/scripts ${REPODIR}
git clone ${ACCOUNT}/nvim ${REPODIR}
git clone ${ACCOUNT}/emacs ${REPODIR}

## ---

sudo ln -s ~/repos/dotfiles/nixos/* /etc/nixos/
sudo nixos-rebuild switch

sudo ln -s ~/repos/dotfiles/home-manager/* ~/.config/home-manager/
home-manager switch

mkdir ~/{desktop,downloads,templates,public,documents,music,pictures,videos,shared}

# xdg-user-dirs-update

mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C "github gorvasof@gmail.com" -N "" -f "id_rsa_github"
