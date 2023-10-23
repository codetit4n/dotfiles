function fish_greeting
    set_color FAD5A5
    cowsay -f tux "Hey, $USER!"
end

alias nv "nvim"
alias fishy "nvim ~/.config/fish/config.fish"
alias tmuxy "nvim ~/.tmux.conf"
alias starshipy "nvim ~/.config/starship.toml"
alias terminaly "nvim ~/.alacritty.yml"
alias i3y "nvim ~/.config/i3/config"
alias nvimy "nvim ~/.config/nvim"
alias dotfiles "cd ~/dotfiles"
alias dev "cd ~/dev"
alias lync "cd ~/lync"

alias aptos "~/bin/aptos"
alias docker="sudo docker"

# tmux session
alias tm "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\""
# tmux session with nvim
alias tnv "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\" 'nvim .'"

set -gx EDITOR /usr/bin/nvim
set -gx GIT_EDITOR /usr/bin/nvim

starship init fish | source
