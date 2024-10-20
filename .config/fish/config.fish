function fish_greeting
	fortune -se | lolcat
end

eval "$(/opt/homebrew/bin/brew shellenv)"

starship init fish | source

alias nv "nvim"
alias fishy "tmux new -s \"fish-config\" 'nvim ~/.config/fish/config.fish'"
alias tmuxy "tmux new -s \"tmux-config\" 'nvim ~/.tmux.conf'"
alias starshipy "tmux new -s \"starship-config\" 'nvim ~/.config/starship.toml'"
alias terminaly "tmux new -s \"alacritty-config\" 'nvim ~/.alacritty.toml'"

alias nvimy "cd ~/.config/nvim"

alias dotfiles "cd ~/dotfiles"
alias dev "cd ~/dev"
alias lync "cd ~/lync"

# tmux session
alias tm "tmux new -s \"\$(basename \"\$(pwd)\" | sed 's#.*/##')\""
# tmux session with nvim
alias tnv "tmux new -s (basename (pwd) | sed 's#.*/##') 'nvim .; fish'"

alias gitlync "git config user.name \"Lokesh Kumar\" && git config user.email \"lokesh@lync.world\""

abbr ls 'exa'
abbr l 'exa'
abbr ll 'exa -l'
abbr la 'exa -la'

abbr e 'exit'

abbr cd 'z'

abbr ta "tmux attach"
abbr tl "tmux ls"


#zoxide init fish | source

