# Transient Prompt
> Reduce the noise of irrelevant information.

## Installation
Install with [Fisher](https://github.com/jorgebucaran/fisher):
```fish
fisher install zzhaolei/transient.fish
```

## Features

When we have fancy two-line prompts, the window will be flooded with these prompts, which of course distracts us from concentration and floods the terminal with irrelevant data.

This plugin goal is to reduce the noise of irrelevant information. This will also make it easier to scroll back and copy-paste a series of commands from the terminal.

**Tip**: If you enable transient prompt, take advantage of two-line prompt. You'll get the benefit of extra space for typing commands without the usual drawback of reduced scrollback density. Sparse prompt (with an empty line before prompt) also works great in combination with transient prompt.

![Transient Prompt](./media/transient.gif)



## Configuration

Support `transient_status` and `transient_pipstatus` variables, which are aliases of `status` and `pipstatus`.

### transient_prompt_func
Define the `transient_prompt_func` function. In this function, you can do what you want.

Example:
![transient_prompt_func](./media/transient_prompt_func.png)

### transient_rprompt_func
Define the `transient_rprompt_func` function. In this function, you can do what you want.

Example:
 ![transient_prompt_func](./media/transient_rprompt_func.png)

## Known Issues
 - When executing time-consuming commands, if you repeatedly press the enter key, the transient prompt cannot prompt properly.

## Inspiration
 - [powerlevel10k#transient-prompt](https://github.com/romkatv/powerlevel10k#transient-prompt)
