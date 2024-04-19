Transient Prompt
===
![GitHub Repo stars](https://img.shields.io/github/stars/zzhaolei/transient.fish)

- [Transient Prompt](#transient-prompt)
- [Installation](#installation)
- [Features](#features)
- [Configuration](#configuration)
  - [transient\_prompt\_func](#transient_prompt_func)
  - [transient\_rprompt\_func](#transient_rprompt_func)
- [Inspiration](#inspiration)

# Installation
Installation with [fisher](https://github.com/jorgebucaran/fisher):
```fish
fisher install zzhaolei/transient.fish
```

# Features
A picture is worth a thousand words.


https://github.com/zzhaolei/transient.fish/assets/17561793/bb70cae6-34cb-4585-aebd-f2b08d3ef939

<!-- ![Transient Prompt](./media/transient.mp4) -->

**Tip**: If you enable transient prompt, take advantage of two-line prompt. You'll get the benefit of extra space for typing commands without the usual drawback of reduced scrollback density. Sparse prompt (with an empty line before prompt) also works great in combination with transient prompt.

# Configuration

Support `transient_status` and `transient_pipstatus` variables, which are aliases of `status` and `pipstatus`.

## transient_prompt_func
Define the `transient_prompt_func` function. In this function, you can do what you want.

Example:
![transient_prompt_func](./media/transient_prompt_func.png)

## transient_rprompt_func
Define the `transient_rprompt_func` function. In this function, you can do what you want.

Example:
 ![transient_prompt_func](./media/transient_rprompt_func.png)

# Inspiration
 - [powerlevel10k#transient-prompt](https://github.com/romkatv/powerlevel10k#transient-prompt)
