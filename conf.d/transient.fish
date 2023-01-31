if not type -q __fish_prompt
    functions --copy fish_prompt __fish_prompt
    functions --erase fish_prompt
end

function fish_prompt
    set -l default_prompt "\e[1;32m❯\e[0m "
    if test $TRANSIENT -eq 1
        or test $TRANSIENT -eq 2
        printf \e\[0J # clear from cursor to end of screen
        if type -q transient_prompt_func
            transient_prompt_func
        else
            printf $default_prompt
        end

        if test $TRANSIENT -eq 2
            set -g TRANSIENT 0
            commandline -f repaint
        end
    else
        set -g ENTER_TRANSIENT 0
        if type -q __fish_prompt
            __fish_prompt
        else
            printf $default_prompt
        end
    end
end

# transience related functions
function reset-transient --on-event fish_postexec
    set -g TRANSIENT 0
end

function transient_execute
    if commandline --is-valid
        set -g TRANSIENT 1
        commandline -f repaint
    else if test (commandline -b) = "" # fix enter
        set -g TRANSIENT 2
        commandline -f repaint
    else
        set -g TRANSIENT 0
    end
    commandline -f execute
end

# when enable vi keybinding use this
bind -M insert \r transient_execute
