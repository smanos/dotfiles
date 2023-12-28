return {
  'vimwiki/vimwiki',
  init = function()

    vim.g.vimwiki_list = {
      {
        path = '~/Documents/vimwiki',
        -- syntax = 'markdown',
        -- ext = '.md',
      },
    }
    vim.g.vimwiki_folding = "list"
    vim.g.vimwiki_hl_headers = 1  -- use alternating colours for different heading levels
  end
}
