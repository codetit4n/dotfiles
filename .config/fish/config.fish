function fish_greeting
    fortune -se | lolcat
    #echo "Welcome back, Lokesh"
end

if test -f /home/lokesh/.autojump/share/autojump/autojump.fish; . /home/lokesh/.autojump/share/autojump/autojump.fish; end

alias nv "nvim"
alias fishy "tmux new -s \"fish-config\" 'nvim ~/.config/fish/config.fish'"
alias tmuxy "tmux new -s \"tmux-config\" 'nvim ~/.tmux.conf'"
alias starshipy "tmux new -s \"starship-config\" 'nvim ~/.config/starship.toml'"
alias terminaly "tmux new -s \"alacritty-config\" 'nvim ~/.alacritty.toml'"
alias i3y "tmux new -s \"i3-config\" 'nvim ~/.config/i3/config'"
alias nvimy "cd ~/.config/nvim"

alias dotfiles "cd ~/dotfiles"
alias dev "cd ~/dev"
alias learn "cd ~/learning"
alias lync "cd ~/lync"
alias oss "cd ~/oss"


alias aptos "~/bin/aptos"

alias todo "tmux new -s todo 'nvim ~/dev/todo.txt'"

# tmux sessionizer
bind \cf "~/.config/scripts/tmux-sessionizer"

# tmux session
alias tm "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\""
# tmux session with nvim
alias tnv "tmux new -s (basename (pwd) | sed 's#.*/##') 'nvim .; fish'"


alias gitlync "git config user.name \"Lokesh Kumar\" && git config user.email \"lokesh@lync.world\""

set -gx EDITOR /usr/bin/nvim
set -gx GIT_EDITOR /usr/bin/nvim
set -gx PATH $PATH $HOME/.cargo/bin

set -gx PATH $PATH /home/lokesh/.local/bin

abbr ls 'exa'
abbr l 'exa'
abbr ll 'exa -l'
abbr la 'exa -la'

abbr e 'exit'

abbr cd 'z'

abbr cat 'bat'
abbr bat 'cat'

# tmux
abbr ta "tmux attach"
abbr tl "tmux ls"

abbr ssh-start 'sudo systemctl start sshd.service'
abbr ssh-stop 'sudo systemctl stop sshd.service'

abbr docker-start 'sudo systemctl start docker.service'
abbr docker-stop 'sudo systemctl stop docker.service'

zoxide init fish | source

starship init fish | source

# pnpm
set -gx PNPM_HOME "/home/tit4n/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# solana
set -gx PATH "/home/tit4n/.local/share/solana/install/active_release/bin" $PATH


export PATH="$PATH:/home/tit4n/.foundry/bin"

export PATH="$PATH:/home/tit4n/.foundry/bin"
export PATH="$HOME/.fuelup/bin:$PATH"

set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/platform-tools
