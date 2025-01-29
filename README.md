# Accent.nvim, based on accent.vim
https://github.com/Alligator/accent.vim

(also includes light mode)

## Installation

```lua

return {
  dir = vim.fn.expand '$HOME' .. '/Source/accent.nvim/',
  config = function()
    require('accent').setup {
      -- color to use
      accent_color = 'orange',

      -- makes the background and some text colours darker.
      accent_darken = false,

      -- inverts the colour of the status line text.
      invert_status = false,

      -- sets the accent colour using a hash of the current directory(i think it's broken)
      auto_cwd_colour = false,

      -- stops the background colour being set, which will use the terminal default
      no_bg = true,
    }
    vim.cmd.colorscheme 'accent'
  end,
}
```

## Future Goals

- [ ] compatibility with more plugins
