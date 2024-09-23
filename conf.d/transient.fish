# Check if these functions have been transient
#     __fish_mode_prompt:   First Render
#     __fish_prompt:        Second Render
#     __fish_right_prompt:  Third Render
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
    # --is-valid:
    #     Returns true when the commandline is syntactically valid and complete.
    #     If it is, it would be executed when the execute bind function is called. If the commandline is incomplete, return 2, if erroneus, return 1.
    #
    #     - 0: valid and complete
    #     - 1: handle type "\[enter]"
    #     - 2: The empty commandline is an error, not incomplete
    if commandline --is-valid || test -z "$(commandline)" && not commandline --paging-mode
        set --global TRANSIENT transient
        commandline --function expand-abbr suppress-autosuggestion repaint execute
        return 0
    end
    commandline -f execute
end

function __transient_ctrl_c_execute
    set --global TRANSIENT transient
    if test "$(commandline --current-buffer)" = ""
        return 0
    end

    commandline --function repaint cancel-commandline kill-inner-line repaint-mode repaint
end

# Key: enter
bind --user --mode default \r __transient_execute
bind --user --mode insert \r __transient_execute

# Key: new line
bind --user --mode default \cj __transient_execute
bind --user --mode insert \cj __transient_execute

# Key: Ctrl-C
bind --user --mode default \cc __transient_ctrl_c_execute
bind --user --mode insert \cc __transient_ctrl_c_execute
