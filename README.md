# Transient Prompt

When we have a gorgeous terminal prompt, the terminal will be flooded with these prompts, which will obviously affect our attention to more critical data, such as the execution results of git commands.

The goal of this plugin is to reduce the distraction of these prompts.

This will also make it easier to scroll back and copy-paste a series of commands from the terminal.

![Transient Prompt](./media/transient.gif)

## Install
```fish
fisher install zzhaolei/transient.fish
```

## Configuration
 - To customize left prompt, define a new function called `transient_prompt_func`. In this transient_prompt_func function, you can do what you want with `transient_pipestatus` or `transient_status`. For example:
![transient_prompt_func](./media/transient_prompt_func.png)

 - To customize right prompt, define a new function called `transient_rprompt_func`. For Example:
 ![transient_prompt_func](./media/transient_rprompt_func.png)

## Known Issues
 - When a time-consuming task is executed(such as sleep), press the `Enter` key, the transient prompt does not work properly

## Inspiration
 - [powerlevel10k#transient-prompt](https://github.com/romkatv/powerlevel10k#transient-prompt)
