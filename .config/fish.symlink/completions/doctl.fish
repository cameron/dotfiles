#! /usr/bin/env fish

function cmds_from_help_str
    eval $argv | sed -n '/^Available Commands/,/^Flags/p;/^Flags/q' | \
    sed '1d;$d' | \
    sed '$d' | \
    grep -v "When creating a new database cluster" | \
    grep -v "Use 'pg' for PostgreSQL" | \
    grep -v "^\$"
    # ^^ some special cases for an aberrant string in the databases subcmd
end


# function cmdline_at_branch
#     # Helper for `complete -n`; makess it easy to specify subcommand completions for
#     # arbitrary subcommand branch depths without worrying about flags[1]
#     #
#     # Inspect the current commandline and compare it to $argv, which should be a series
#     # of command and optional subcommands (e.g., "doctl compute droplet") and determine
#     # whether the commandline contains the same series, regardless of interspersed flags[1]
#     #
#     # E.g., if commandline returns "doctl --api-token xxxx compute", this function will
#     # return 1 for the branch "doctl", 0 for the branch "doctl compute", and 1 for the
#     # branch "doctl compute droplet".
#     #
#     # 1) Flag handling is



#     set -l branch_idx 0
#     set -l tokens (string split " " "doctl --flag val compute")
#     set -l matched_branch false

# #    for token in (commandline -poc)
#     for token_idx in (seq (count $tokens))
#         set -l token $tokens[$token_idx]
#         echo $token
#         echo $argv[$branch_idx]

#         # 
#         if test $matched_branch
#             switch $token
#                 case "-*"
                    
#         end

#         if test "$token" = "$argv[$branch_idx]" 
#             echo "match"
#             set branch_idx (math $branch_idx + 1)
#         end

#         # if we've matched 
#         if test \((math "$branch_idx" + 1) -eq (count $argv)\)
#             set matched_branch true
#         end
#     end
#     echo (count $argv)
#     echo $branch_idx
#     if test $branch_idx -eq (math (count $argv) + 1)
#         echo "yay"
#         return 0
#     end
#     echo "nay"
#     return 1
# end

function complete_doctl_py
    complete_doctl.py
end

#complete -f -c doctl -n "complete_doctl_py" -a "asdf"
#complete -f -c doctl -n "cmd_is_branch doctl compute droplet" -a "c d"

function cmd_tree
    for line in (cmds_from_help_str "$argv -h")
        set -l cmd (echo $line | awk '{print $1}')
        set -l desc (echo $line | awk '{$1=""; print $0}')

        # complete -f -c doctl -n "cmd_is_branch $argv $cmd" -a $cmd
        echo $argv $cmd
        cmd_tree $argv $cmd
    end
end

#cmd_tree doctl



    

