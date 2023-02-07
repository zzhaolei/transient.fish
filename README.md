# Transient Prompt By Fish Shell

## Example
```shell
❯ ls -G
conf.d  README.md
❯ ls^C
❯
❯
❯
❯
❯
❯

~/transient-prompt.fish main ───────────────────────────── 08:36:56 下午
❯
```

## Install
```fish
fisher install zzhaolei/transient-prompt.fish
```

## Configuration

### transient prompt
You can set the `transient_prompt_func` function, customize the `transient prompt`.

You can adjust the color of the prompt using `transient_prompt_pipestatus` or `transient_prompt_status`

Example:

`before`:
```shell
❯ echo 1
1
❯ echo 2
2
❯ # is empty enter
❯
❯

❯ # current line
```

`after`:
```
function transient_prompt_func
    if test $transient_prompt_pipestatus[1] -eq 0
        printf (set_color green)"❯❯❯ "
    else
        printf (set_color red)"❯❯❯ "
    end
end

❯❯❯ echo 1
1
❯❯❯ echo 2
2
❯❯❯ # is empty enter
❯❯❯
❯❯❯

❯ # current line
```

## Known issue
 - `abbr` has a chance to have no syntax color when expanded