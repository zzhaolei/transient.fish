function __fish_mode_prompt
    if test -n "$(functions -v fish_mode_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        return 0
    end

    if type --query fish_mode_prompt
        functions --erase __transient_old_fish_mode_prompt 2>/dev/null && functions --copy fish_mode_prompt __transient_old_fish_mode_prompt
    end

    function fish_mode_prompt
        # It's a flag, it's important
        # @__TRANSIENT__@
        if test "$TRANSIENT" = normal
            if type --query __transient_old_fish_mode_prompt
                __transient_old_fish_mode_prompt
            end
        else
            if type --query transient_mprompt_func
                transient_mprompt_func
            end
        end
    end
end
