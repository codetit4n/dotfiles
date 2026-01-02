function __fish_nrfutil_complete
    # Full command line up to cursor (this becomes COMP_LINE)
    set -l line (commandline -cp)

    # Tokens of the current process up to but EXCLUDING the token being completed
    # This matches bash's idea of COMP_WORDS[..] before COMP_CWORD
    set -l tokens (commandline -opc)

    # COMP_CWORD is just "how many words are before the current one"
    # (bash uses 0-based indexing; fish count gives us that directly)
    set -l cword_idx (count $tokens)

    # Ask nrfutil's completion engine for suggestions
    set -l raw \
        (NRFUTIL_IGNORE_MISSING_SUBCOMMAND=true \
         nrfutil completion query bash $cword_idx -- $line 2>/dev/null)

    # If the query failed, bail out so fish falls back to file completion or nothing
    test $status -ne 0; and return

    # Protocol: first two entries are meta (mode, quote), rest are actual suggestions
    if test (count $raw) -lt 3
        return
    end

    set -e raw[1..2]   # drop mode + quote
    printf '%s\n' $raw
end

# Attach to the nrfutil command
complete -c nrfutil -f -a '(__fish_nrfutil_complete)'
