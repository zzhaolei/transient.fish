set --global TRANSIENT normal
set --global TRANSIENT_RIGHT normal

function __default_transient_prompt_func
    set --local color 5FD700
    if test $transient_prompt_pipestatus[1] -ne 0
        set color red
    end
    printf (set_color $color)"❯ "(set_color normal)
end

function __reset_pipestatus
    return $transient_prompt_pipestatus[1]
end

# First Render
if type --query fish_mode_prompt
    if not type --query __transient_fish_mode_prompt
        functions --copy fish_mode_prompt __transient_fish_mode_prompt
        functions --erase fish_mode_prompt
    end

    function fish_mode_prompt
        if test "$TRANSIENT" = transient
            return 0
        end

        set --global transient_prompt_pipestatus $pipestatus
        set --global transient_prompt_status $status
        if test "$TRANSIENT" = normal
            and type --query __transient_fish_mode_prompt
            __reset_pipestatus
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
                __reset_pipestatus
                __transient_fish_prompt
            else
                printf 1
                __default_transient_prompt_func
            end
            return 0
        else
            printf \e\[0J # clear from cursor to end of screen
            if type --query transient_prompt_func
                transient_prompt_func
            else
                __default_transient_prompt_func
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
        if test "$TRANSIENT_RIGHT" = transient
            return 0
        end

        set --global transient_prompt_pipestatus $pipestatus
        set --global transient_prompt_status $status
        if test "$TRANSIENT_RIGHT" = normal
            and type --query __transient_fish_right_prompt
            __reset_pipestatus
            __transient_fish_right_prompt
        end
    end
end

function reset-transient --on-event fish_postexec
    set --global TRANSIENT normal
    set --global TRANSIENT_RIGHT normal
end

function transient_execute
    set --global TRANSIENT transient
    set --local buffer "$(commandline --current-buffer)"

    if test "$buffer" != "" # fix empty enter
        and commandline --paging-full-mode # Evaluates to true if the commandline is showing pager contents, such as tab completions and all lines are shown (no “<n> more rows” message).
        set --global TRANSIENT normal
    end
    commandline --function expand-abbr repaint execute
end

function transient_ctrl_c_execute
    set --global TRANSIENT transient
    if test "$(commandline --current-buffer)" = ""
        commandline --function repaint execute
        return 0
    end

    commandline --function repaint cancel-commandline kill-inner-line repaint-mode repaint
end

bind --mode default \r transient_execute
bind --mode insert \r transient_execute
bind --mode default \cc transient_ctrl_c_execute
bind --mode insert \cc transient_ctrl_c_execute
