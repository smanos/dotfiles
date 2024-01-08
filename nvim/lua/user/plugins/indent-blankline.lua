-- return {
--   'lukas-reineke/indent-blankline.nvim',
--   main = 'ibl',
--   opts = {
--     scope = {
--       show_start = false,
--     },
--     exclude = {
--       filetypes = {
--         'dashboard',
--       },
--     },
--   }
-- }


return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
  config = function()
    local hl_name_list = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterBlue',
      'RainbowDelimiterCyan',
      'RainbowDelimiterViolet',
    }
    require('ibl').setup({
      scope = {
        enabled = true,
        show_start = false,
        highlight = hl_name_list
      }
    })
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
