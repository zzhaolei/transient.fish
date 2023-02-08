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

~/transient.fish main ───────────────────────────── 08:36:56 下午
❯
```

## Install
```fish
fisher install zzhaolei/transient.fish
```

## Configuration

### transient character
You can set the `transient_character_func` function, customize the `transient character`.

You can adjust the color of the prompt using `transient_pipestatus` or `transient_status`

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
function transient_character_func
    if test $transient_character_pipestatus[1] -eq 0
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
 - [x] `abbr` has a chance to have no syntax color when expanded