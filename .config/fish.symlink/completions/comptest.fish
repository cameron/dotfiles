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


function cmd_is_branch

function cmd_tree
    for line in (cmds_from_help_str "$argv -h")
        set -l cmd (echo $line | awk '{print $1}')
        set -l desc (echo $line | awk '{$1=""; print $0}')

        # complete -f -c doctl -n "not __fish_seen_subcommand_from $doctl_cmds" -a $cmd
        echo $argv $cmd
        cmd_tree $argv $cmd
    end
end

cmd_tree doctl



#function __fish_doctl_complete_compute
    

#complete -f -c aws-okta -n "__fish_seen_subcommand_from exec; and not __fish_seen_subcommand_from (__fish_okta_complete_profiles)" -a "(__fish_okta_complete_profiles)"
