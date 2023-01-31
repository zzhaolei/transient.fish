if not type --query __fish_prompt
    functions --copy fish_prompt __fish_prompt
    functions --erase fish_prompt
end

function __default_transient_prompt
    printf (set_color 5FD700)"❯ "(set_color normal)
end

function fish_prompt
    _transient_pipestatus=$pipestatus _transient_status=$status if test "$TRANSIENT" = 0
        function __raise_pipestatus
            return $_transient_pipestatus
        end
        if type --query __fish_prompt
            # reset command status to last status
            __raise_pipestatus
            __fish_prompt
        else
            __default_transient_prompt
        end
    else
        printf \e\[0J # clear from cursor to end of screen
        if type --query transient_prompt_func
            transient_prompt_func
        else
            __default_transient_prompt
        end

        if test "$TRANSIENT" = 2
            set --global TRANSIENT 0
            commandline --function repaint
        end
    end
end

# transience related functions
function reset-transient --on-event fish_postexec
    set --global TRANSIENT 0
end

function transient_execute
    if commandline --is-valid
        set --global TRANSIENT 1
        commandline --function repaint
    else if test "$(commandline -b)" = "" # fix empty enter
        set --global TRANSIENT 2
        commandline --function repaint
    else
        set --global TRANSIENT 0
    end
    commandline --function execute
end

function ctrl_c_transient_execute
    set --global TRANSIENT 2
    if test "$(commandline -b)" = ""
        commandline --function repaint execute
        return 0
    end

    commandline --function repaint cancel-commandline kill-inner-line repaint-mode
end

# When enable vi keybinding use `bind -M insert`
bind -M insert \r transient_execute
bind -M insert \cc ctrl_c_transient_execute

# Disable vi keybinding use `bind`
# bind \r transient_execute 
