# Transient Prompt By Fish Shell

## Install
```fish
fisher install zzhaolei/transient.fish
```

## Configuration

You can set the `transient_character_func` function, customize the `transient character`.

You can adjust the color of the prompt using `transient_pipestatus` or `transient_status`.

By default, this plugin will replace `$pipestatus` and `$status` in `fish_prompt` with `$transient_pipestatus` and `$transient_status`

Example:

- before
![Before](./images/before.png)

- after
![After](./images/after.png)

## Known Issues
 - When a time-consuming task is executed, press the `Enter` key, the transient prompt does not work properly

## References
 - [powerlevel10k#transient-prompt](https://github.com/romkatv/powerlevel10k#transient-prompt)
