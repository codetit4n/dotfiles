function fish_greeting
    fortune -se | lolcat
end

if test -f /home/lokesh/.autojump/share/autojump/autojump.fish; . /home/lokesh/.autojump/share/autojump/autojump.fish; end

alias nv "nvim"
alias fishy "nvim ~/.config/fish/config.fish"
alias fishyt "tmux new -s \"fish-config\" 'nvim ~/.config/fish/config.fish'"
alias tmuxy "nvim ~/.tmux.conf"
alias tmuxyt "tmux new -s \"tmux-config\" 'nvim ~/.tmux.conf'"
alias starshipy "nvim ~/.config/starship.toml"
alias starshipyt "tmux new -s \"starship-config\" 'nvim ~/.config/starship.toml'"
alias terminaly "nvim ~/.alacritty.yml"
alias terminalyt "tmux new -s \"alacritty-config\" 'nvim ~/.alacritty.yml'"
alias i3y "nvim ~/.config/i3/config"
alias i3yt "tmux new -s \"i3-config\" 'nvim ~/.config/i3/config'"
alias nvimy "cd ~/.config/nvim"
alias scripty "nvim ~/.config/scripts"
alias scriptyt "tmux new -s \"scripts-config\" 'nvim ~/.config/scripts'"
alias dotfiles "cd ~/dotfiles"
alias dev "cd ~/dev"
alias learn "cd ~/learning"
alias lync "cd ~/lync"
alias oss "cd ~/oss"


alias aptos "~/bin/aptos"
alias docker="sudo docker"

alias todo "tmux new -s todo 'nvim ~/dev/todo.txt'"

# tmux session
alias tm "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\""
# tmux session with nvim
alias tnv "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\" 'nvim .'"

set -gx EDITOR /usr/bin/nvim
set -gx GIT_EDITOR /usr/bin/nvim
set -gx PATH $PATH $HOME/.cargo/bin

# tmp
bass export PATH="/home/lokesh/.local/bin:$PATH"

abbr ls 'exa'
abbr l 'exa'
abbr ll 'exa -l'
abbr la 'exa -la'

abbr cat 'bat'

abbr e 'exit'

abbr cd 'z'

abbr ssh-start 'sudo systemctl start sshd.service'
abbr ssh-stop 'sudo systemctl stop sshd.service'

zoxide init fish | source

starship init fish | source
