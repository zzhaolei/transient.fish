set --global TRANSIENT normal
set --global TRANSIENT_RIGHT normal

function __transient_prompt_func
    set --local color green
    if test $transient_pipestatus[-1] -ne 0
        set color red
    end
    printf (set_color $color)"❯ "(set_color normal)
end

function __transient_check --on-event fish_prompt
    # Check if these functions have been transient
    if test -z "$(functions -v fish_mode_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        functions --erase __transient_fish_mode_prompt
        __fish_mode_prompt
    end

    if test -z "$(functions -v fish_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        functions --erase __transient_fish_prompt
        __fish_prompt
    end

    if test -z "$(functions -v fish_right_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
        functions --erase __transient_fish_right_prompt
        __fish_right_prompt
    end
end

__transient # install

function __transient_uninstall --on-event transient_uninstall
    if type --query __transient_fish_mode_prompt
        functions --erase fish_mode_prompt
        functions --copy __transient_fish_mode_prompt fish_mode_prompt
    end

    if type --query __transient_fish_prompt
        functions --erase fish_prompt
        functions --copy __transient_fish_prompt fish_prompt

        # replace $transient_[pipe]status to $[pipe]status
        functions -v fish_prompt | string replace '$transient_pipestatus' '$pipestatus' | string replace '$transient_status' '$status' | source
    end

    if type --query __transient_fish_right_prompt
        functions --erase fish_right_prompt
        functions --copy __transient_fish_right_prompt fish_right_prompt
    end

    functions --erase (functions --all | string match --entire -r '^_?_?transient')

    bind --user | string replace --filter --regex -- "bind (.+)( '?__transient.*)" 'bind -e $1' | source
    set --names | string replace --ignore-case --filter --regex -- '(^transient.*)' 'set -e $1' | source
    set --names | string replace --ignore-case --filter --regex -- '(^__fish_.*_md5$)' 'set -e $1' | source
end
