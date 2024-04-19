function __transient
    function __transient_execute
        # --is-valid:
        #     Returns true when the commandline is syntactically valid and complete.
        #     If it is, it would be executed when the execute bind function is called. If the commandline is incomplete, return 2, if erroneus, return 1.
        #
        #     - 0: valid and complete
        #     - 1: handle type "\[enter]"
        #     - 2: The empty commandline is an error, not incomplete
        commandline --is-valid
        set -l valid $status
        if test $valid -eq 1
            and test "$(commandline --current-buffer)" = "\\"
            or test $valid -eq 2
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

    # Key: enter
    bind --user --mode default \r __transient_execute
    bind --user --mode insert \r __transient_execute

    # Key: new line
    bind --user --mode default \cj __transient_execute
    bind --user --mode insert \cj __transient_execute

    # Key: Ctrl-C
    bind --user --mode default \cc __transient_ctrl_c_execute
    bind --user --mode insert \cc __transient_ctrl_c_execute
end
