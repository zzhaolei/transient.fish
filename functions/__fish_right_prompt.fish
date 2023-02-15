function __fish_right_prompt
    if not type --query fish_right_prompt
        return 0
    end

    if not type --query __transient_fish_right_prompt
        functions --copy fish_right_prompt __transient_fish_right_prompt
        functions --erase fish_right_prompt
    end

    function fish_right_prompt
        # It's a flag, it's important
        # @__TRANSIENT__@
        if test "$TRANSIENT_RIGHT" = normal
            and type --query __transient_fish_right_prompt
            __transient_fish_right_prompt
        else
            if type --query transient_rprompt_func
                transient_rprompt_func
            end
        end
        set --global TRANSIENT_RIGHT normal
    end
end
