# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_ut_global_optspecs
	string join \n h/help
end

function __fish_ut_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_ut_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_ut_using_subcommand
	set -l cmd (__fish_ut_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c ut -n "__fish_ut_needs_command" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_needs_command" -f -a "completions" -d 'Generate shell completions for ut'
complete -c ut -n "__fish_ut_needs_command" -f -a "base64" -d 'Base64 encode and decode utilities'
complete -c ut -n "__fish_ut_needs_command" -f -a "bcrypt" -d 'bcrypt hashing and verification utilities'
complete -c ut -n "__fish_ut_needs_command" -f -a "calc" -d 'Expression calculator with math functions'
complete -c ut -n "__fish_ut_needs_command" -f -a "case" -d 'Convert text between different case formats'
complete -c ut -n "__fish_ut_needs_command" -f -a "color" -d 'Color utilities'
complete -c ut -n "__fish_ut_needs_command" -f -a "crontab" -d 'Cron utilities for scheduling and parsing'
complete -c ut -n "__fish_ut_needs_command" -f -a "datetime" -d 'Parse and convert datetime to different timezones'
complete -c ut -n "__fish_ut_needs_command" -f -a "diff" -d 'Compare text contents'
complete -c ut -n "__fish_ut_needs_command" -f -a "hash" -d 'Generate hash digests using various algorithms'
complete -c ut -n "__fish_ut_needs_command" -f -a "http" -d 'HTTP status codes and their descriptions'
complete -c ut -n "__fish_ut_needs_command" -f -a "json" -d 'JSON utilities'
complete -c ut -n "__fish_ut_needs_command" -f -a "lorem" -d 'Generate lorem ipsum text'
complete -c ut -n "__fish_ut_needs_command" -f -a "pretty-print" -d 'Resolve escaped newlines and tab characters'
complete -c ut -n "__fish_ut_needs_command" -f -a "qr" -d 'Generate QR codes'
complete -c ut -n "__fish_ut_needs_command" -f -a "random" -d 'Generate random numbers within specified range'
complete -c ut -n "__fish_ut_needs_command" -f -a "regex" -d 'Interactive regex tester'
complete -c ut -n "__fish_ut_needs_command" -f -a "serve" -d 'Start a local HTTP file server'
complete -c ut -n "__fish_ut_needs_command" -f -a "token" -d 'Generate a cryptographically secure random token.'
complete -c ut -n "__fish_ut_needs_command" -f -a "ulid" -d 'Generate and manipulate ULIDs (Universally Unique Lexicographically Sortable Identifiers)'
complete -c ut -n "__fish_ut_needs_command" -f -a "url" -d 'URL encode and decode utilities'
complete -c ut -n "__fish_ut_needs_command" -f -a "uuid" -d 'Generate UUIDs'
complete -c ut -n "__fish_ut_needs_command" -f -a "unicode" -d 'Unicode symbol reference'
complete -c ut -n "__fish_ut_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c ut -n "__fish_ut_using_subcommand base64; and not __fish_seen_subcommand_from encode decode help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand base64; and not __fish_seen_subcommand_from encode decode help" -f -a "encode" -d 'Base64 encode contents'
complete -c ut -n "__fish_ut_using_subcommand base64; and not __fish_seen_subcommand_from encode decode help" -f -a "decode" -d 'Base64 decode contents'
complete -c ut -n "__fish_ut_using_subcommand base64; and not __fish_seen_subcommand_from encode decode help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from encode" -l urlsafe -d 'Encode with urlsafe character set'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from encode" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from decode" -l urlsafe -d 'Decode with urlsafe character set'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from decode" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from help" -f -a "encode" -d 'Base64 encode contents'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from help" -f -a "decode" -d 'Base64 decode contents'
complete -c ut -n "__fish_ut_using_subcommand base64; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and not __fish_seen_subcommand_from hash verify help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and not __fish_seen_subcommand_from hash verify help" -f -a "hash" -d 'Hash a password using bcrypt'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and not __fish_seen_subcommand_from hash verify help" -f -a "verify" -d 'Verify a password against a bcrypt hash'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and not __fish_seen_subcommand_from hash verify help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and __fish_seen_subcommand_from hash" -s c -l cost -d 'Cost factor (4-31, default: 12). Higher values are more secure but slower' -r
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and __fish_seen_subcommand_from hash" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and __fish_seen_subcommand_from help" -f -a "hash" -d 'Hash a password using bcrypt'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and __fish_seen_subcommand_from help" -f -a "verify" -d 'Verify a password against a bcrypt hash'
complete -c ut -n "__fish_ut_using_subcommand bcrypt; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand calc" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "lower" -d 'Convert text to lowercase'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "upper" -d 'Convert text to UPPERCASE'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "camel" -d 'Convert text to camelCase'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "title" -d 'Convert text to Title Case'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "constant" -d 'Convert text to CONSTANT_CASE'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "header" -d 'Convert text to Header-Case'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "sentence" -d 'Convert text to sentence case'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "snake" -d 'Convert text to snake_case'
complete -c ut -n "__fish_ut_using_subcommand case; and not __fish_seen_subcommand_from lower upper camel title constant header sentence snake help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from lower" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from upper" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from camel" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from title" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from constant" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from header" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from sentence" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from snake" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "lower" -d 'Convert text to lowercase'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "upper" -d 'Convert text to UPPERCASE'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "camel" -d 'Convert text to camelCase'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "title" -d 'Convert text to Title Case'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "constant" -d 'Convert text to CONSTANT_CASE'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "header" -d 'Convert text to Header-Case'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "sentence" -d 'Convert text to sentence case'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "snake" -d 'Convert text to snake_case'
complete -c ut -n "__fish_ut_using_subcommand case; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand color; and not __fish_seen_subcommand_from convert help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand color; and not __fish_seen_subcommand_from convert help" -f -a "convert" -d 'Convert colors between different formats'
complete -c ut -n "__fish_ut_using_subcommand color; and not __fish_seen_subcommand_from convert help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand color; and __fish_seen_subcommand_from convert" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand color; and __fish_seen_subcommand_from help" -f -a "convert" -d 'Convert colors between different formats'
complete -c ut -n "__fish_ut_using_subcommand color; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand crontab; and not __fish_seen_subcommand_from schedule help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand crontab; and not __fish_seen_subcommand_from schedule help" -f -a "schedule" -d 'Parse crontab expression and show upcoming firing times'
complete -c ut -n "__fish_ut_using_subcommand crontab; and not __fish_seen_subcommand_from schedule help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand crontab; and __fish_seen_subcommand_from schedule" -s n -l count -d 'Number of upcoming firing times to show (default: 5)' -r
complete -c ut -n "__fish_ut_using_subcommand crontab; and __fish_seen_subcommand_from schedule" -s a -l after -d 'Calculate firing times after this time (ISO 8601 format, defaults to now)' -r
complete -c ut -n "__fish_ut_using_subcommand crontab; and __fish_seen_subcommand_from schedule" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand crontab; and __fish_seen_subcommand_from help" -f -a "schedule" -d 'Parse crontab expression and show upcoming firing times'
complete -c ut -n "__fish_ut_using_subcommand crontab; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand datetime" -s s -l source-timezone -d 'Input timezone to use when parsing datetime without timezone info (overrides any timezone in the input)' -r
complete -c ut -n "__fish_ut_using_subcommand datetime" -s t -l target-timezone -d 'Target timezone to convert to (e.g., "America/New_York", "UTC", "Asia/Tokyo")' -r
complete -c ut -n "__fish_ut_using_subcommand datetime" -s f -l parse-format -r
complete -c ut -n "__fish_ut_using_subcommand datetime" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c ut -n "__fish_ut_using_subcommand diff" -s a -l a -d 'First version of the file, omit to use editor' -r -F
complete -c ut -n "__fish_ut_using_subcommand diff" -s b -l b -d 'Second version of the file, omit to use editor' -r -F
complete -c ut -n "__fish_ut_using_subcommand diff" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "md5" -d 'Generate MD5 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "sha1" -d 'Generate SHA-1 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "sha224" -d 'Generate SHA-224 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "sha256" -d 'Generate SHA-256 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "sha384" -d 'Generate SHA-384 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "sha512" -d 'Generate SHA-512 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and not __fish_seen_subcommand_from md5 sha1 sha224 sha256 sha384 sha512 help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from md5" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from sha1" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from sha224" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from sha256" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from sha384" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from sha512" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "md5" -d 'Generate MD5 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "sha1" -d 'Generate SHA-1 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "sha224" -d 'Generate SHA-224 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "sha256" -d 'Generate SHA-256 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "sha384" -d 'Generate SHA-384 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "sha512" -d 'Generate SHA-512 hash'
complete -c ut -n "__fish_ut_using_subcommand hash; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand http; and not __fish_seen_subcommand_from status help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand http; and not __fish_seen_subcommand_from status help" -f -a "status" -d 'Look up HTTP status codes'
complete -c ut -n "__fish_ut_using_subcommand http; and not __fish_seen_subcommand_from status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand http; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand http; and __fish_seen_subcommand_from help" -f -a "status" -d 'Look up HTTP status codes'
complete -c ut -n "__fish_ut_using_subcommand http; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand json; and not __fish_seen_subcommand_from builder help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand json; and not __fish_seen_subcommand_from builder help" -f -a "builder" -d 'Build JSON from key-value pairs with dot notation and array support'
complete -c ut -n "__fish_ut_using_subcommand json; and not __fish_seen_subcommand_from builder help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand json; and __fish_seen_subcommand_from builder" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand json; and __fish_seen_subcommand_from help" -f -a "builder" -d 'Build JSON from key-value pairs with dot notation and array support'
complete -c ut -n "__fish_ut_using_subcommand json; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand lorem" -s p -l paragraphs -d 'Number of paragraphs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand lorem" -l min-sentences -d 'Minimum number of sentences per paragraph' -r
complete -c ut -n "__fish_ut_using_subcommand lorem" -l max-sentences -d 'Maximum number of sentences per paragraph' -r
complete -c ut -n "__fish_ut_using_subcommand lorem" -l min-words -d 'Minimum number of words per sentence' -r
complete -c ut -n "__fish_ut_using_subcommand lorem" -l max-words -d 'Maximum number of words per sentence' -r
complete -c ut -n "__fish_ut_using_subcommand lorem" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand pretty-print" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand qr" -s o -l output -d 'Save QR code to file (PNG format)' -r -F
complete -c ut -n "__fish_ut_using_subcommand qr" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand random" -s c -l count -d 'Number of random numbers to generate' -r
complete -c ut -n "__fish_ut_using_subcommand random" -l min -d 'Minimum value (inclusive)' -r
complete -c ut -n "__fish_ut_using_subcommand random" -l max -d 'Maximum value (inclusive)' -r
complete -c ut -n "__fish_ut_using_subcommand random" -s s -l step -d 'Step value for precision (e.g., 0.01 for 2 decimal places)' -r
complete -c ut -n "__fish_ut_using_subcommand random" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand regex" -s t -l test -d 'File to load test string content from' -r -F
complete -c ut -n "__fish_ut_using_subcommand regex" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand serve" -s d -l directory -d 'Path to the directory to serve' -r -F
complete -c ut -n "__fish_ut_using_subcommand serve" -s p -l port -d 'Port number the server should listen to' -r
complete -c ut -n "__fish_ut_using_subcommand serve" -l host -d 'Host address the server should bind to' -r
complete -c ut -n "__fish_ut_using_subcommand serve" -l auth -d 'Authentication credentials (username:password)' -r
complete -c ut -n "__fish_ut_using_subcommand serve" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand token" -s l -l length -d 'Length of the token to generate' -r
complete -c ut -n "__fish_ut_using_subcommand token" -l no-uppercase -d 'Do not include uppercase letters'
complete -c ut -n "__fish_ut_using_subcommand token" -l no-lowercase -d 'Do not include lowercase letters'
complete -c ut -n "__fish_ut_using_subcommand token" -l no-numbers -d 'Do not include numbers'
complete -c ut -n "__fish_ut_using_subcommand token" -l no-symbols -d 'Do not include symbols'
complete -c ut -n "__fish_ut_using_subcommand token" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "generate" -d 'Generate new ULIDs (default)'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "g" -d 'Generate new ULIDs (default)'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "parse" -d 'Parse and inspect a ULID'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "validate" -d 'Validate a ULID string'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "to-uuid" -d 'Convert ULID to UUID'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "from-uuid" -d 'Convert UUID to ULID'
complete -c ut -n "__fish_ut_using_subcommand ulid; and not __fish_seen_subcommand_from generate g parse validate to-uuid from-uuid help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from generate" -s c -l count -d 'Number of ULIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from generate" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from g" -s c -l count -d 'Number of ULIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from g" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from parse" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from validate" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from to-uuid" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from from-uuid" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from help" -f -a "generate" -d 'Generate new ULIDs (default)'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from help" -f -a "parse" -d 'Parse and inspect a ULID'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from help" -f -a "validate" -d 'Validate a ULID string'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from help" -f -a "to-uuid" -d 'Convert ULID to UUID'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from help" -f -a "from-uuid" -d 'Convert UUID to ULID'
complete -c ut -n "__fish_ut_using_subcommand ulid; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand url; and not __fish_seen_subcommand_from encode decode help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand url; and not __fish_seen_subcommand_from encode decode help" -f -a "encode" -d 'URL encode text'
complete -c ut -n "__fish_ut_using_subcommand url; and not __fish_seen_subcommand_from encode decode help" -f -a "decode" -d 'URL decode text'
complete -c ut -n "__fish_ut_using_subcommand url; and not __fish_seen_subcommand_from encode decode help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand url; and __fish_seen_subcommand_from encode" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand url; and __fish_seen_subcommand_from decode" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand url; and __fish_seen_subcommand_from help" -f -a "encode" -d 'URL encode text'
complete -c ut -n "__fish_ut_using_subcommand url; and __fish_seen_subcommand_from help" -f -a "decode" -d 'URL decode text'
complete -c ut -n "__fish_ut_using_subcommand url; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -f -a "v1" -d 'Generate UUID v1 (timestamp-based)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -f -a "v3" -d 'Generate UUID v3 (namespace + MD5 hash)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -f -a "v4" -d 'Generate UUID v4 (random)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -f -a "v5" -d 'Generate UUID v5 (namespace + SHA-1 hash)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -f -a "v7" -d 'Generate UUID v7 (timestamp-based, sortable)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and not __fish_seen_subcommand_from v1 v3 v4 v5 v7 help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v1" -s c -l count -d 'Number of UUIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v1" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v3" -s n -l namespace -d 'Namespace to use' -r -f -a "dns\t'DNS namespace'
url\t'URL namespace'
oid\t'ISO OID namespace'
x500\t'X.500 DN namespace'"
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v3" -s N -l name -d 'Name to hash' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v3" -s c -l count -d 'Number of UUIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v3" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v4" -s c -l count -d 'Number of UUIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v4" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v5" -s n -l namespace -d 'Namespace to use' -r -f -a "dns\t'DNS namespace'
url\t'URL namespace'
oid\t'ISO OID namespace'
x500\t'X.500 DN namespace'"
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v5" -s N -l name -d 'Name to hash' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v5" -s c -l count -d 'Number of UUIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v5" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v7" -s c -l count -d 'Number of UUIDs to generate' -r
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from v7" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from help" -f -a "v1" -d 'Generate UUID v1 (timestamp-based)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from help" -f -a "v3" -d 'Generate UUID v3 (namespace + MD5 hash)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from help" -f -a "v4" -d 'Generate UUID v4 (random)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from help" -f -a "v5" -d 'Generate UUID v5 (namespace + SHA-1 hash)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from help" -f -a "v7" -d 'Generate UUID v7 (timestamp-based, sortable)'
complete -c ut -n "__fish_ut_using_subcommand uuid; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand unicode" -s h -l help -d 'Print help'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "completions" -d 'Generate shell completions for ut'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "base64" -d 'Base64 encode and decode utilities'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "bcrypt" -d 'bcrypt hashing and verification utilities'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "calc" -d 'Expression calculator with math functions'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "case" -d 'Convert text between different case formats'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "color" -d 'Color utilities'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "crontab" -d 'Cron utilities for scheduling and parsing'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "datetime" -d 'Parse and convert datetime to different timezones'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "diff" -d 'Compare text contents'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "hash" -d 'Generate hash digests using various algorithms'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "http" -d 'HTTP status codes and their descriptions'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "json" -d 'JSON utilities'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "lorem" -d 'Generate lorem ipsum text'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "pretty-print" -d 'Resolve escaped newlines and tab characters'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "qr" -d 'Generate QR codes'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "random" -d 'Generate random numbers within specified range'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "regex" -d 'Interactive regex tester'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "serve" -d 'Start a local HTTP file server'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "token" -d 'Generate a cryptographically secure random token.'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "ulid" -d 'Generate and manipulate ULIDs (Universally Unique Lexicographically Sortable Identifiers)'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "url" -d 'URL encode and decode utilities'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "uuid" -d 'Generate UUIDs'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "unicode" -d 'Unicode symbol reference'
complete -c ut -n "__fish_ut_using_subcommand help; and not __fish_seen_subcommand_from completions base64 bcrypt calc case color crontab datetime diff hash http json lorem pretty-print qr random regex serve token ulid url uuid unicode help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from base64" -f -a "encode" -d 'Base64 encode contents'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from base64" -f -a "decode" -d 'Base64 decode contents'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from bcrypt" -f -a "hash" -d 'Hash a password using bcrypt'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from bcrypt" -f -a "verify" -d 'Verify a password against a bcrypt hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "lower" -d 'Convert text to lowercase'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "upper" -d 'Convert text to UPPERCASE'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "camel" -d 'Convert text to camelCase'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "title" -d 'Convert text to Title Case'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "constant" -d 'Convert text to CONSTANT_CASE'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "header" -d 'Convert text to Header-Case'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "sentence" -d 'Convert text to sentence case'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from case" -f -a "snake" -d 'Convert text to snake_case'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from color" -f -a "convert" -d 'Convert colors between different formats'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from crontab" -f -a "schedule" -d 'Parse crontab expression and show upcoming firing times'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from hash" -f -a "md5" -d 'Generate MD5 hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from hash" -f -a "sha1" -d 'Generate SHA-1 hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from hash" -f -a "sha224" -d 'Generate SHA-224 hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from hash" -f -a "sha256" -d 'Generate SHA-256 hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from hash" -f -a "sha384" -d 'Generate SHA-384 hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from hash" -f -a "sha512" -d 'Generate SHA-512 hash'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from http" -f -a "status" -d 'Look up HTTP status codes'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from json" -f -a "builder" -d 'Build JSON from key-value pairs with dot notation and array support'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from ulid" -f -a "generate" -d 'Generate new ULIDs (default)'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from ulid" -f -a "parse" -d 'Parse and inspect a ULID'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from ulid" -f -a "validate" -d 'Validate a ULID string'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from ulid" -f -a "to-uuid" -d 'Convert ULID to UUID'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from ulid" -f -a "from-uuid" -d 'Convert UUID to ULID'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from url" -f -a "encode" -d 'URL encode text'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from url" -f -a "decode" -d 'URL decode text'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from uuid" -f -a "v1" -d 'Generate UUID v1 (timestamp-based)'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from uuid" -f -a "v3" -d 'Generate UUID v3 (namespace + MD5 hash)'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from uuid" -f -a "v4" -d 'Generate UUID v4 (random)'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from uuid" -f -a "v5" -d 'Generate UUID v5 (namespace + SHA-1 hash)'
complete -c ut -n "__fish_ut_using_subcommand help; and __fish_seen_subcommand_from uuid" -f -a "v7" -d 'Generate UUID v7 (timestamp-based, sortable)'
