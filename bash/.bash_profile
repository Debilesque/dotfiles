# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi


setxkbmap latam -option 'caps:ctrl_modifier'
xcape -e '#66=Escape'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if [ -e /home/jellu/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jellu/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
