local M = {}

M.config = {
  accent_colors = {
    red = { fg = '#e06c75', bg = '#b04c55', ctermfg = 167, ctermbg = 131 },
    orange = { fg = '#ee9360', bg = '#b66930', ctermfg = 173, ctermbg = 166 },
    green = { fg = '#98c379', bg = '#689349', ctermfg = 149, ctermbg = 107 },
    yellow = { fg = '#e5c07b', bg = '#a5803b', ctermfg = 179, ctermbg = 136 },
    blue = { fg = '#61afe7', bg = '#3876af', ctermfg = 74, ctermbg = 67 },
    magenta = { fg = '#c688cd', bg = '#965498', ctermfg = 176, ctermbg = 133 },
    cyan = { fg = '#56b6c2', bg = '#3696a2', ctermfg = 73, ctermbg = 30 },
  },
  auto_cwd_color = false,
  darken = false,
  invert_status = false,
  no_bg = false,
}

M.setup = function(config)
  M.config = vim.tbl_deep_extend('force', M.config, config or {})

  -- Handle custom accent color
  if M.config.custom_accent then
    M.config.accent_colors.custom = M.config.custom_accent
    M.config.accent_color = 'custom'
    M.config.custom_accent = nil
  end

  -- random accent color when no color is selected
  if not M.config.accent_color then
    local color_names = vim.tbl_keys(M.config.accent_colors)
    local index = math.random(1, #color_names)
    M.config.accent_color = color_names[index]
  end

  if M.config.auto_cwd_color then
    local cwd = vim.fn.getcwd()
    local hash = require('accent').fnv1a(cwd)
    local color_names = vim.tbl_keys(M.config.accent_colors)
    local index = (hash % #color_names) + 1
    M.config.accent_color = color_names[index]
  end
end

M.load = function()
  if vim.g.colors_name then
    vim.cmd.hi 'clear'
  end

  if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd.syntax 'reset'
  end

  vim.g.colors_name = 'accent'
  vim.o.termguicolors = true

  local groups = require('accent.groups').setup(M.config)
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

-- Utility functions
-- Lua5.1 has no bitwise XOR operations
M.bxor = function(a, b)
  local result = 0
  local bitval = 1
  while a > 0 or b > 0 do
    local abit = a % 2
    local bbit = b % 2
    if abit ~= bbit then
      result = result + bitval
    end
    a = math.floor(a / 2)
    b = math.floor(b / 2)
    bitval = bitval * 2
  end
  return result
end

M.fnv1a = function(str)
  local hash = 2166136261
  for i = 1, #str do
    local c = str:byte(i)
    hash = M.bxor(hash, c)
    hash = hash * 16777619 % 2 ^ 32
  end
  return hash
end

return M
