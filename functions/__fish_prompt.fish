function __fish_prompt --description "make fish prompt transient"
    if not type --query fish_prompt
        return 0
    end

    if not type --query __transient_fish_prompt
        functions --copy fish_prompt __transient_fish_prompt
        functions --erase fish_prompt

        # replace $[pipe]status to $transient_[pipe]status
        functions -v __transient_fish_prompt | string replace '$pipestatus' '$transient_pipestatus' | string replace '$status' '$transient_status' | source
    end

    function fish_prompt
        set --global transient_pipestatus $pipestatus
        set --global transient_status $status

        if test "$TRANSIENT" = normal
            if type --query __transient_fish_prompt
                __transient_fish_prompt
            else
                __transient_character_func
            end
            return 0
        end

        printf \e\[0J # clear from cursor to end of screen
        if type --query transient_character_func
            transient_character_func
        else
            __transient_character_func
        end

        set --global TRANSIENT normal
        set --global TRANSIENT_RIGHT transient
        commandline --function repaint
    end

    set --global __fish_prompt_md5 (functions -v fish_prompt | md5)
end