function __transient_uninstall --on-event transient_uninstall
    bind --user | string replace --filter --regex -- "bind (.+)( '?__transient.*)" 'bind -e $1' | source

    if type --query __transient_fish_mode_prompt
        functions --erase fish_mode_prompt
        functions --copy __transient_fish_mode_prompt fish_mode_prompt
    end

    if type --query __transient_fish_prompt
        functions --erase fish_prompt
        functions --copy __transient_fish_prompt fish_prompt
    end

    if type --query __transient_fish_right_prompt
        functions --erase fish_right_prompt
        functions --copy __transient_fish_right_prompt fish_right_prompt
    end

    functions --erase (functions --all | string match --entire -r '^_?_?transient')
end
