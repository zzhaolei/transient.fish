# rename fish_prompt to __transient_fish_prompt
if not type --query __transient_fish_prompt
    and type --query fish_prompt
    functions --copy fish_prompt __transient_fish_prompt
    functions --erase fish_prompt
end

# rename fish_right_prompt to __transient_fish_right_prompt
if not type --query __transient_fish_right_prompt
    and type --query fish_right_prompt
    functions --copy fish_right_prompt __transient_fish_right_prompt
    functions --erase fish_right_prompt
end

function ___default_transient_prompt
    printf (set_color 5FD700)"❯ "(set_color normal)
end

function ___reset_pipestatus
    # Use the variables defined in the calling function. (_transient_pipestatus)
    return $_transient_pipestatus
end

set --global TRANSIENT normal
set --global TRANSIENT_RIGHT normal

function fish_prompt
    _transient_pipestatus=$pipestatus _transient_status=$status if test "$TRANSIENT" = normal
        if type --query __transient_fish_prompt
            ___reset_pipestatus
            __transient_fish_prompt
        else
            ___default_transient_prompt
        end
    else
        printf \e\[0J # clear from cursor to end of screen
        if type --query transient_prompt_func
            transient_prompt_func
        else
            ___default_transient_prompt
        end

        if test "$TRANSIENT" = transient-repaint
            set --global TRANSIENT normal
            set --global TRANSIENT_RIGHT transient-repaint
            commandline --function repaint
        end
    end
end

function fish_right_prompt
    if test "$TRANSIENT_RIGHT" = transient-repaint
        set --global TRANSIENT_RIGHT normal
        commandline --function repaint
        return 0
    end

    _transient_pipestatus=$pipestatus _transient_status=$status if test "$TRANSIENT_RIGHT" = normal
        if type --query __transient_fish_right_prompt
            ___reset_pipestatus
            __transient_fish_right_prompt
        end
    end
end

# transience related functions
function reset-transient --on-event fish_postexec
    set --global TRANSIENT normal
    set --global TRANSIENT_RIGHT normal
end

function transient_execute
    if commandline --is-valid
        set --global TRANSIENT transient
        set --global TRANSIENT_RIGHT transient
        commandline --function repaint
    else if test "$(commandline -b)" = "" # fix empty enter
        set --global TRANSIENT transient-repaint
        set --global TRANSIENT_RIGHT transient
        commandline --function repaint
    else
        set --global TRANSIENT normal
    end
    commandline --function execute
end

function ctrl_c_transient_execute
    set --global TRANSIENT transient-repaint
    if test "$(commandline -b)" = ""
        commandline --function repaint execute
        return 0
    end

    commandline --function repaint cancel-commandline kill-inner-line repaint-mode
end

bind -M insert \r transient_execute
bind -M insert \cc ctrl_c_transient_execute
