function __transient
    __fish_mode_prompt # First Render
    __fish_prompt # Second Render
    __fish_right_prompt # Third Render

    function __transient_execute
        commandline --is-valid
        set --local _valid $status

        # The empty commandline is an error, not incomplete
        if test $_valid -eq 2
            or commandline --paging-full-mode
            commandline -f execute
            return 0
        end
        set --global TRANSIENT transient
        commandline --function expand-abbr suppress-autosuggestion repaint execute
    end

    function __transient_ctrl_c_execute
        set --global TRANSIENT transient
        if test "$(commandline --current-buffer)" = ""
            commandline --function repaint execute
            return 0
        end

        commandline --function repaint cancel-commandline kill-inner-line repaint-mode repaint
    end

    bind --user --mode default \r __transient_execute
    bind --user --mode insert \r __transient_execute
    bind --user --mode default \cc __transient_ctrl_c_execute
    bind --user --mode insert \cc __transient_ctrl_c_execute
end
