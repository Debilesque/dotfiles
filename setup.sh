CONFIG="$HOME/.config"
PWD="$(pwd)"

mkdir -v $CONFIG

for i in bspwm git i3 kitty mpv redshift rofi \
    sxhkd gtk-3.0 lf xplr polybar qutebrowser \
    ranger sioyek nyxt openbox wezterm; do
    if [ -d "$i" ]; then
        ln -s $PWD/$i $CONFIG
    fi
done

## since sioyek was installed via flatpak, its configuration
## file need to be here
## ln -s $PWD/sioyek $HOME/.var/app/com.github.ahrm.sioyek/config/sioyek/

ln -s $PWD/feh/.fehbg $HOME
ln -s $PWD/bash/.bash* $HOME
ln -s $PWD/zsh/.zsh* $HOME
ln -s $PWD/bash/.profile $HOME
ln -s $PWD/Xmodmap/.* $HOME
ln -s $PWD/xinit/.* $HOME
ln -s $PWD/dirs/* $CONFIG

mkdir -p $HOME/.local/share/applications
ln -s $PWD/apps/* $HOME/.local/share/applications

ln -s $PWD/stalonetray/.stalonetrayrc $HOME
ln -s $PWD/starship/starship.toml $CONFIG

sudo mkdir -p /etc/X11/xorg.conf.d/
sudo ln -s $PWD/libinput/* /etc/X11/xorg.conf.d/

sudo cp /etc/bashrc /etc/.old-bashrc
sudo rm /etc/bashrc

sudo ln -s $PWD/bash/etc/bashrc /etc/bashrc

sudo ln -s ~/repos/dotfiles/nixos/configuration.nix /etc/nixos

mkdir ~/{desktop,downloads,templates,public,documents,music,pictures,videos}

xdg-user-dirs-update
