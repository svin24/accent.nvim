local M = {}

M.setup = function(config)
  local accent = config.accent_colors[config.accent_color]
  local colors = config.accent_colors

  -- Color definitions (same as your original code)
  local fg, fg_b1, fg_d1, fg_d2, fg_inv, fg_invd, fg_c
  local bg, bg_b1, bg_b2, bg_none, bg_inv, bg_red, bg_c

  if vim.o.background == 'light' then
    -- Light variant colors
    fg = { fg = '#444444', ctermfg = 238 }
    fg_b1 = { fg = '#333333', ctermfg = 235 }
    fg_d1 = { fg = '#666666', ctermfg = 242 }
    fg_d2 = { fg = '#888888', ctermfg = 244 }
    fg_inv = { fg = '#ffffff', ctermfg = 231 }
    fg_invd = { fg = '#f0f0f0', ctermfg = 255 }
    fg_c = { fg = accent.fg, ctermfg = accent.ctermfg }

    bg = { bg = '#f8f8f8', ctermbg = 255 }
    bg_b1 = { bg = '#e8e8e8', ctermbg = 254 }
    bg_b2 = { bg = '#d8d8d8', ctermbg = 253 }
    bg_none = { bg = 'NONE' }
    bg_inv = { bg = '#333333', ctermbg = 236 }
    bg_red = { bg = colors.red.bg, ctermbg = colors.red.ctermbg }
    bg_c = { bg = accent.bg, ctermbg = accent.ctermbg }

    if config.darken then
      fg.fg = '#333333'
      fg.ctermfg = 235
      fg_b1.fg = '#222222'
      fg_b1.ctermfg = 233
      fg_d1.fg = '#555555'
      fg_d1.ctermfg = 240
      fg_d2.fg = '#777777'
      fg_d2.ctermfg = 244

      bg.bg = '#e8e8e8'
      bg.ctermbg = 254
    end
  else
    -- Dark variant colors
    fg = { fg = '#bcbfc4', ctermfg = 250 }
    fg_b1 = { fg = '#efefff', ctermfg = 255 }
    fg_d1 = { fg = '#999999', ctermfg = 246 }
    fg_d2 = { fg = '#777777', ctermfg = 244 }
    fg_inv = { fg = '#282c34', ctermfg = 236 }
    fg_invd = { fg = '#181c24', ctermfg = 234 }
    fg_c = { fg = accent.fg, ctermfg = accent.ctermfg }

    bg = { bg = '#282c34', ctermbg = 236 }
    bg_b1 = { bg = '#383c44', ctermbg = 237 }
    bg_b2 = { bg = '#484c54', ctermbg = 238 }
    bg_none = { bg = 'NONE' }
    bg_inv = { bg = '#cccfd4', ctermbg = 188 }
    bg_red = { bg = colors.red.bg, ctermbg = colors.red.ctermbg }
    bg_c = { bg = accent.bg, ctermbg = accent.ctermbg }

    if config.darken then
      fg.fg = '#acafb4'
      fg.ctermfg = 248
      fg_b1.fg = '#dfdfef'
      fg_b1.ctermfg = 253
      fg_d1.fg = '#888888'
      fg_d1.ctermfg = 244
      fg_d2.fg = '#666666'
      fg_d2.ctermfg = 242
      bg.bg = '#181c24'
      bg.ctermbg = 234
    end
  end

  -- Highlight groups (same structure as your original apply_highlights)
  local highlights = {
    Normal = vim.tbl_extend('force', fg, config.no_bg and bg_none or bg),
    StatusLine = config.invert_status and vim.tbl_extend('force', fg_invd, bg_c) or vim.tbl_extend('force', fg_b1, bg_c),
    StatusLineNC = vim.tbl_extend('force', fg_d1, bg_b2),
    VertSplit = vim.tbl_extend('force', fg_c, bg_b1),
    LineNr = vim.tbl_extend('force', fg_d2, bg_none),
    CursorLineNr = vim.tbl_extend('force', fg_b1, bg_none),
    CursorLine = bg_b1,
    MatchParen = vim.tbl_extend('force', fg_b1, bg_b1, { bold = true }),
    NonText = vim.tbl_extend('force', fg_d2, bg_none),
    WildMenu = vim.tbl_extend('force', fg_inv, bg_inv),
    Search = vim.tbl_extend('force', fg_inv, bg_c),
    Folded = vim.tbl_extend('force', fg_b1, bg_b1),
    Visual = bg_b2,
    Pmenu = vim.tbl_extend('force', fg_d1, bg_b1),
    PmenuSel = vim.tbl_extend('force', fg_c, bg_b2),
    TabLine = vim.tbl_extend('force', fg_d1, bg_b1),
    TabLineFill = vim.tbl_extend('force', fg_d1, bg_b2),

    -- Linked groups
    NormalFloat = { link = 'Normal' },
    StatusLineTerm = { link = 'StatusLine' },
    StatusLineTermNC = { link = 'StatusLineNC' },
    Question = fg_c,
    MoreMsg = { link = 'Question' },
    FoldColumn = { link = 'Folded' },
    SpellBad = { undercurl = true, sp = colors.red.fg },
    SpellRare = { undercurl = true, sp = colors.magenta.fg },
    SpellCap = { undercurl = true, sp = colors.blue.fg },
    SpellLocal = { undercurl = true, sp = colors.cyan.fg },
    Comment = vim.tbl_extend('force', fg_d2, bg_none),
    String = vim.tbl_extend('force', fg_c, bg_none),
    Type = vim.tbl_extend('force', fg_b1, bg_none),
    PreProc = vim.tbl_extend('force', fg_d1, bg_none),
    Underlined = { underline = true },
    Special = vim.tbl_extend('force', fg_c, bg_none),
    Error = vim.tbl_extend('force', fg_b1, bg_red),

    -- Diff highlights
    DiffAdd = { fg = colors.green.fg },
    DiffDelete = { fg = colors.red.fg },
    DiffChange = bg_b1,
    DiffText = vim.tbl_extend('force', fg_b1, bg_red),
    diffAdded = { link = 'DiffAdd' },
    diffRemoved = { link = 'DiffDelete' },
  }

  -- Link groups
  local links = {
    Operator = 'Normal',
    Identifier = 'Normal',
    Todo = 'Normal',
    Macro = 'PreProc',
    Statement = 'Type',
    Constant = 'Type',
    SpecialKey = 'Comment',
    Title = 'Type',
    Directory = 'Type',
    Function = 'Type',
    Number = 'String',
    Character = 'String',
    ErrorMsg = 'Error',
    xmlAttrib = 'Normal',
    sqlKeyword = 'Type',
  }

  for group, target in pairs(links) do
    highlights[group] = { link = target }
  end

  return highlights
end

return M
