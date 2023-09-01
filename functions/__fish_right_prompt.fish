function __fish_right_prompt
    if test -n "$(functions -v fish_right_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        return 0
    end
    if type --query fish_right_prompt
        functions --erase __transient_old_fish_right_prompt 2>/dev/null && functions --copy fish_right_prompt __transient_old_fish_right_prompt
    end

    function fish_right_prompt
        # It's a flag, it's important
        # @__TRANSIENT__@
        if test "$TRANSIENT_RIGHT" = normal
            if type --query __transient_old_fish_right_prompt
                __transient_old_fish_right_prompt
            end
        else
            if type --query transient_rprompt_func
                transient_rprompt_func
            end
        end
        set --global TRANSIENT_RIGHT normal
    end
end
