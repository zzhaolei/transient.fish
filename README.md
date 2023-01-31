# Transient Prompt By Fish Shell

## install
```fish
fisher install zzhaolei/transient-prompt.fish
```

## configuration
you can set the `transient_prompt_func` function, customize the `transient prompt`.

example:

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
    printf "❯❯❯ "
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