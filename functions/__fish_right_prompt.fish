function __fish_right_prompt
    if not type --query fish_right_prompt
        return 0
    end

    if not type --query __transient_fish_right_prompt
        functions --copy fish_right_prompt __transient_fish_right_prompt
        functions --erase fish_right_prompt
    end

    function fish_right_prompt
        if test "$TRANSIENT_RIGHT" = normal
            and type --query __transient_fish_right_prompt
            __transient_fish_right_prompt
        end
        set --global TRANSIENT_RIGHT normal
    end

    set --global __fish_right_prompt_md5 (functions -v fish_right_prompt | md5)
end
