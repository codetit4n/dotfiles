function fish_greeting
    fortune -se | lolcat
    #echo "Welcome back, Lokesh"
end

if test -f /home/tit4n/.autojump/share/autojump/autojump.fish; . /home/tit4n/.autojump/share/autojump/autojump.fish; end

alias nv "nvim"
alias fishy "tmux new -s \"fish-config\" 'nvim ~/.config/fish/config.fish'"
alias tmuxy "tmux new -s \"tmux-config\" 'nvim ~/.tmux.conf'"
alias starshipy "tmux new -s \"starship-config\" 'nvim ~/.config/starship.toml'"
alias terminaly "tmux new -s \"alacritty-config\" 'nvim ~/.alacritty.toml'"
alias i3y "tmux new -s \"i3-config\" 'nvim ~/.config/i3/config'"
alias nvimy "cd ~/.config/nvim"

alias dotfiles "cd ~/dotfiles"
alias dev "cd ~/dev"
alias nav "cd ~/navikarana"
alias learn "cd ~/learning"
alias oss "cd ~/oss"


alias todo "tmux new -s todo 'nvim ~/dev/txts/todo.txt'"
alias rnd "tmux new -s R&D 'nvim ~/dev/txts/rnd.txt'"
alias track "tmux new -s track-progress 'nvim ~/dev/txts/track.txt'"
alias note "tmux new -s note 'nvim ~/dev/txts/note.txt'"
alias now "tmux new -s now 'nvim ~/dev/txts/now1.txt'"
alias dmp "tmux new -s data-dump 'nvim ~/dev/txts/dump.txt'"
alias later "tmux new -s later 'nvim ~/dev/txts/later.txt'"
alias rice "tmux new -s rice 'nvim ~/dev/txts/ricing.txt'"
alias idea "xdg-open https://ideas.navikarana.io"
alias smallidea "xdg-open https://smallideas.navikarana.io"


function aichat
    set name "copilot_"(date "+%Y%m%d_%H%M%S")
    tmux new-session -s "$name" \
        "nvim ~/dev/txts/copilot_notes/$name.txt '+CopilotChat' '+set relativenumber number'"
end

alias bmake "bear -- make"

# tmux sessionizer
bind \cf "~/.config/scripts/tmux-sessionizer"

# tmux session
alias tm "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\""
# tmux session with nvim
alias tnv "tmux new -s (basename (pwd) | sed 's#.*/##') 'nvim .; fish'"

alias website 'tmux new-session -d -s personal-website "cd ~/personal-website; nvim .; fish" \; new-window -n hugo "cd ~/personal-website; hugo server -D; fish" \; select-window -t 1 \; attach-session -t personal-website'
alias logs 'tmux new-session -d -s personal-logs "cd ~/dev/personal-web/personal-logs; nvim .; fish" \; new-window -n hugo "cd ~/dev/personal-web/personal-logs; hugo server; fish" \; select-window -t 1 \; attach-session -t personal-logs'

alias web lynx


alias gitn "git config user.name \"Lokesh Kumar <codetit4n>\" && git config user.email \"lokesh@navikarana.io\""

alias set-brightness ~/.config/scripts/brightness.sh

alias idf ". /home/tit4n/esp/esp-idf/export.fish"
alias zephyr "source ~/.config/scripts/zephyr-env.fish"

set -gx EDITOR /usr/bin/nvim
set -gx GIT_EDITOR /usr/bin/nvim
set -gx PATH $PATH $HOME/.cargo/bin
set -gx PATH $PATH $HOME/go/bin
set -gx PATH $PATH $HOME/.local/bin
set -gx PICO_SDK_PATH $HOME/pico/pico-sdk
set -gx PICO_TOOLCHAIN_PATH /usr
set -eg PATH



abbr ls 'exa'
abbr l 'exa'
abbr ll 'exa -l'
abbr la 'exa -la'

abbr e 'exit'

abbr cd 'z'

abbr dsp1-off 'xrandr --output DP-0 --off'
abbr dsp2-off 'xrandr --output HDMI-1 --off'
abbr dsp-reset 'bass source ~/.xprofile'

# tmux
abbr ta "tmux attach"
abbr tl "tmux ls"

abbr sshd-start 'sudo systemctl start sshd.service'
abbr sshd-stop 'sudo systemctl stop sshd.service'
abbr torrent 'aria2c'

abbr docker-start 'sudo systemctl start docker.service'
abbr docker-stop 'sudo systemctl stop docker.service'

abbr csh 'builtin history clear-session'

abbr bmakedbg 'bmake 2>&1 | grep --color=always -E "error|warning|undefined reference|dangerous relocation|collect2"'

zoxide init fish | source

starship init fish | source

source $HOME/.elan/env


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
set -U fish_user_paths $ANDROID_HOME/cmdline-tools/latest/bin $fish_user_paths


nvm use default --silent > /dev/null

alias mailrestart='pkill thunderbird; nohup thunderbird >/dev/null 2>&1 & disown'
alias olrestart='systemctl --user restart openlogi-agent.service'

function clipboardrestart
    pkill copyq
    env QT_SCALE_FACTOR=2.5 setsid -f copyq
end

function vault-open
    set -l luks_device /dev/disk/by-uuid/71bee9cb-a785-435f-b92a-79407f841b28
    set -l mapper vault
    set -l mountpoint /mnt/vault

    if not test -e /dev/mapper/$mapper
        sudo cryptsetup open $luks_device $mapper
        or return 1
    end

    if not mountpoint -q $mountpoint
        sudo mount /dev/mapper/$mapper $mountpoint
        or return 1
    end

    echo "Vault opened at $mountpoint"
end

function vault-close
    set -l mapper vault
    set -l mountpoint /mnt/vault

    if mountpoint -q $mountpoint
        sudo umount $mountpoint
        or return 1
    end

    if test -e /dev/mapper/$mapper
        sudo cryptsetup close $mapper
        or return 1
    end

    echo "Vault closed and locked"
end


# opencode
fish_add_path /home/tit4n/.opencode/bin
