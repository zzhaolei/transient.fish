# Check if these functions have been transient
#     __fish_mode_prompt:   First  Render
#     __fish_prompt:        Second Render
#     __fish_right_prompt:  Third  Render
function __transient_event_emit --on-event fish_prompt --on-variable VIRTUAL_ENV
    __fish_mode_prompt
    __fish_prompt
    __fish_right_prompt
end

function __transient_uninstall --on-event transient_uninstall
    if type --query __transient_old_fish_mode_prompt
        functions --erase fish_mode_prompt
        functions --copy __transient_old_fish_mode_prompt fish_mode_prompt
    end

    if type --query __transient_old_fish_prompt
        functions --erase fish_prompt
        functions --copy __transient_old_fish_prompt fish_prompt

        # replace $transient_[pipe]status to $[pipe]status
        functions -v fish_prompt | string replace '$transient_pipestatus' '$pipestatus' | string replace '$transient_status' '$status' | source
    end

    if type --query __transient_old_fish_right_prompt
        functions --erase fish_right_prompt
        functions --copy __transient_old_fish_right_prompt fish_right_prompt
    end

    functions --erase (functions --all | string match --entire -r '^_?_?transient')

    bind --user | string replace --filter --regex -- "bind (.+)( '?__transient.*)" 'bind -e $1' | source
    set --names | string replace --ignore-case --filter --regex -- '(^transient.*)' 'set -e $1' | source
    set --names | string replace --ignore-case --filter --regex -- '(^__fish_.*_md5$)' 'set -e $1' | source
end

function __transient_execute
    commandline --function expand-abbr suppress-autosuggestion
    if commandline --is-valid || test -z "$(commandline)"
        if commandline --paging-mode && test -n "$(commandline)"
            commandline -f accept-autosuggestion
            return 0
        end

        set --global TRANSIENT transient
        commandline --function repaint execute
        return 0
    end

    commandline -f execute
end

function __transient_ctrl_c_execute
    set --global TRANSIENT transient
    if test "$(commandline --current-buffer)" = ""
        commandline --function cancel-commandline
        return 0
    end

    commandline --function repaint cancel-commandline kill-inner-line repaint-mode repaint
end

function __transient_ctrl_d_execute
    if test "$(commandline --current-buffer)" != ""
        return 0
    end
    set --global TRANSIENT transient
    commandline --function repaint exit
end

# Key: enter
bind --user --mode default \r __transient_execute
bind --user --mode insert \r __transient_execute

# Key: new line
bind --user --mode default \cj __transient_execute
bind --user --mode insert \cj __transient_execute

# Key: Ctrl-D
bind --user --mode default \cd __transient_ctrl_d_execute
bind --user --mode insert \cd __transient_ctrl_d_execute

# Key: Ctrl-C
bind --user --mode default \cc __transient_ctrl_c_execute
bind --user --mode insert \cc __transient_ctrl_c_execute
