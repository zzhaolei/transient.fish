function __fish_mode_prompt
    if not type --query fish_mode_prompt
        return 0
    end

    if not type --query __transient_fish_mode_prompt
        functions --copy fish_mode_prompt __transient_fish_mode_prompt
        functions --erase fish_mode_prompt
    end

    function fish_mode_prompt
        # It's a flag, it's important
        # @__TRANSIENT__@
        if test "$TRANSIENT" = normal
            and type --query __transient_fish_mode_prompt
            __transient_fish_mode_prompt
        end
    end
end
