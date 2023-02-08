set --global TRANSIENT normal
set --global TRANSIENT_RIGHT normal

function __transient_prompt_func
    set --local color 5FD700
    if test $transient_prompt_pipestatus[1] -ne 0
        set color red
    end
    printf (set_color $color)"❯ "(set_color normal)
end

function __transient_reset_pipestatus
    return $transient_prompt_pipestatus[1]
end

# First Render
if type --query fish_mode_prompt
    if not type --query __transient_fish_mode_prompt
        functions --copy fish_mode_prompt __transient_fish_mode_prompt
        functions --erase fish_mode_prompt
    end

    function fish_mode_prompt
        if test "$TRANSIENT" = normal
            and type --query __transient_fish_mode_prompt
            __transient_reset_pipestatus
            __transient_fish_mode_prompt
        end
    end
end

# Second Render
if type --query fish_prompt
    if not type --query __transient_fish_prompt
        functions --copy fish_prompt __transient_fish_prompt
        functions --erase fish_prompt
    end

    function fish_prompt
        set --global transient_prompt_pipestatus $pipestatus
        set --global transient_prompt_status $status

        if test "$TRANSIENT" = normal
            if type --query __transient_fish_prompt
                __transient_reset_pipestatus
                __transient_fish_prompt
            else
                __transient_prompt_func
            end
            return 0
        else
            printf \e\[0J # clear from cursor to end of screen
            if type --query transient_prompt_func
                transient_prompt_func
            else
                __transient_prompt_func
            end
        end

        set --global TRANSIENT normal
        set --global TRANSIENT_RIGHT transient
    end
end

# Third Render
if type --query fish_right_prompt
    if not type --query __transient_fish_right_prompt
        functions --copy fish_right_prompt __transient_fish_right_prompt
        functions --erase fish_right_prompt
    end

    function fish_right_prompt
        if test "$TRANSIENT_RIGHT" = normal
            and type --query __transient_fish_right_prompt
            __transient_reset_pipestatus
            __transient_fish_right_prompt
        end
        set --global TRANSIENT_RIGHT normal
    end
end

function __transient_execute
    commandline --is-valid
    set --local _valid $status

    # The empty commandline is an error, not incomplete
    if test $_valid -eq 2
        or commandline --paging-full-mode
        commandline -f execute
        return 0
    end
    set --global TRANSIENT transient
    commandline --function expand-abbr repaint execute
end

function __transient_ctrl_c_execute
    set --global TRANSIENT transient
    if test "$(commandline --current-buffer)" = ""
        commandline --function repaint execute
        return 0
    end

    commandline --function repaint cancel-commandline kill-inner-line repaint-mode repaint
end

bind --user --mode default \r __transient_execute
bind --user --mode insert \r __transient_execute
bind --user --mode default \cc __transient_ctrl_c_execute
bind --user --mode insert \cc __transient_ctrl_c_execute
