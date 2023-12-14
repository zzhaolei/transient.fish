function __transient_prompt_func
    set --local color green
    if test $transient_pipestatus[-1] -ne 0
        set color red
    end
    echo -en (set_color $color)"❯ "(set_color normal)
end

function __fish_prompt --description "make fish prompt transient"
    if not type -q fish_prompt
        or test -n "$(functions -v fish_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        return 0
    end

    # fix enable virtualenv
    if type --query _old_fish_prompt
        functions --erase _old_fish_prompt && functions --copy __transient_old_fish_prompt _old_fish_prompt
    end
    functions --erase __transient_old_fish_prompt 2>/dev/null && functions --copy fish_prompt __transient_old_fish_prompt

    # replace $[pipe]status to $transient_[pipe]status
    functions -v __transient_old_fish_prompt | string replace -r '\$status([\s+])' '\$transient_status$1' | string replace -r '\$pipestatus([\s+])' '\$transient_pipestatus$1' | source

    function fish_prompt
        # It's a flag, it's important
        # @__TRANSIENT__@
        set --global transient_pipestatus $pipestatus
        set --global transient_status $status

        if test "$TRANSIENT" = normal
            __transient_old_fish_prompt
            return 0
        end

        echo -en \e\[0J # clear from cursor to end of screen
        if type --query transient_prompt_func
            transient_prompt_func
        else
            __transient_prompt_func
        end

        set --global TRANSIENT normal
        set --global TRANSIENT_RIGHT transient
        commandline --function repaint
    end
end
