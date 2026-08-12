# ~/.config/fish/completions/opencode.fish
# Fish completions for opencode (yargs-based)

function __opencode_yargs_completions
    # Fish returns the current commandline as tokens (no escaping headaches)
    set -l tokens (commandline -opc)

    # yargs completion helper expects argv including "opencode"
    # commandline -opc already includes it, so pass through as-is.
    opencode --get-yargs-completions $tokens 2>/dev/null
end

# Use the generated candidates for argument completion.
# -f disables file completion fallback *unless* opencode returns nothing; Fish will still do its own behavior.
complete -c opencode -f -a "(__opencode_yargs_completions)"

