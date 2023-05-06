function __fish_mode_prompt
    if not type --query fish_mode_prompt
        or test -n "$(functions -v fish_mode_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        return 0
    end

    functions --erase __transient_old_fish_mode_prompt 2>/dev/null && functions --copy fish_mode_prompt __transient_old_fish_mode_prompt

    function fish_mode_prompt
        # It's a flag, it's important
        # @__TRANSIENT__@
        if test "$TRANSIENT" = normal
            __transient_old_fish_mode_prompt
        end
    end
end
