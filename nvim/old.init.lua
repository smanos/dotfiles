vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'farmergreg/vim-lastplace',
  'nelstrom/vim-visual-star-search',
  {
    'itchyny/calendar.vim',
    config = function()
      require('user.credentials')
      vim.g.calendar_google_calendar = 1
      vim.g.calendar_google_task = 1
      vim.g.calendar_google_keep = 1
      vim.g.calendar_google_docs = 1
      vim.g.calendar_google_drive = 1
      vim.g.calendar_google_contact = 1
      vim.g.calendar_google_sync_seconds = 60
      vim.g.calendar_google_sync_minutes = 60
      vim.g.calendar_google_sync_hours = 24
      vim.g.calendar_google_sync_days = 7
      vim.g.calendar_google_sync_months = 12
      vim.g.calendar_google_sync_years = 10
      vim.g.calendar_google_sync_on_startup = 1
      vim.g.calendar_google_sync_on_exit = 1
      vim.g.calendar_google_sync_remind_minutes = 10
      vim.g.calendar_google_sync_remind_method = 'popup'
      vim.g.calendar_google_sync_remind_popup_time = 10
      vim.g.calendar_google_sync_remind_popup_position = 'center'
      vim.g.calendar_google_sync_remind_popup_max_width = 80
      vim.g.calendar_google_sync_remind_popup_max_height = 10
      vim.g.calendar_google_sync_remind_popup_border = 1
      vim.g.calendar_google_sync_remind_popup_border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
      vim.g.calendar_google_sync_remind_popup_border_highlight = 'Normal'
      vim.g.calendar_google_sync_remind_popup_border_floating = 1
      vim.g.calendar_google_sync_remind_popup_border_title = 'Calendar'
      vim.g.calendar_google_sync_remind_popup_border_title_highlight = 'Title'
      vim.g.calendar_google_sync_remind_popup_border_title_align = 'center'
      vim.g.calendar_google_sync_remind_popup_border_title_padding = 1
      vim.g.calendar_google_sync_remind_popup_border_title_text = 'Calendar'
      vim.g.calendar_google_sync_remind_popup_border_title_text_highlight = 'Title'
      vim.g.calendar_google_sync_remind_popup_border_title_text_align = 'center'
      vim.g.calendar_google_sync_remind_popup_border_title_text_padding = 1
      vim.g.calendar_google_sync_remind_popup_border_title_text_width = 0
      vim.g.calendar_google_sync_remind_popup_border_title_text_wrap = 0
    end
  },
  {
    'github/copilot.vim',
    config = function()
      vim.cmd([[
      imap <silent><script><expr> <M-CR> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
      ]])
    end,
  },
  -- Automatically add closing brackets, quotes, etc.
  { 'windwp/nvim-autopairs', config = true },

  -- Add smooth scrolling to avoid jarring jumps
  { 'karb94/neoscroll.nvim', config = true },

  -- Automatically fix indentation when pasting code.
  {
    'sickill/vim-pasta',
    config = function()
      vim.g.pasta_disabled_filetypes = { 'fugitive' }
    end,
  },

  -- LSP configuraton 
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
      { 'jose-elias-alvarez/null-ls.nvim', dependencies = 'nvim-lua/plenary.nvim' },
      'jayp0521/mason-null-ls.nvim',
    },
    config = function()
      -- Setup Mason to automatically install LSP servers
      require('mason').setup({
        ui = {
          height = 0.8,
        },
      })
      require('mason-lspconfig').setup({ automatic_installation = true })

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- PHP
      require('lspconfig').intelephense.setup({
        commands = {
          IntelephenseIndex = {
            function()
              vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
            end,
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.buf.inlay_hint(bufnr, true)
          -- end
        end,
        capabilities = capabilities
      })

      require('lspconfig').phpactor.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.completionProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.implementationProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.renameProvider = false
          client.server_capabilities.selectionRangeProvider = false
          client.server_capabilities.signatureHelpProvider = false
          client.server_capabilities.typeDefinitionProvider = false
          client.server_capabilities.workspaceSymbolProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.documentHighlightProvider = false
          client.server_capabilities.documentSymbolProvider = false
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        init_options = {
          ["language_server_phpstan.enabled"] = false,
          ["language_server_psalm.enabled"] = false,
        },
        handlers = {
          ['textDocument/publishDiagnostics'] = function() end
        }
      })

      -- Vue, JavaScript, TypeScript
      require('lspconfig').volar.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          -- if client.server_capabilities.inlayHintProvider then
          --   vim.lsp.buf.inlay_hint(bufnr, true)
          -- end
        end,
        capabilities = capabilities,
        -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
        -- This drastically improves the responsiveness of diagnostic updates on change
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      })

      -- Tailwind CSS
      require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

      -- JSON
      require('lspconfig').jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      })

      -- null-ls
      local null_ls = require('null-ls')
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        temp_dir = '/tmp',
        sources = {
          null_ls.builtins.diagnostics.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({ '.eslintrc.js' })
            end,
          }),
          -- null_ls.builtins.diagnostics.phpstan, -- TODO: Only if config file
          null_ls.builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
          null_ls.builtins.formatting.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' })
            end,
          }),
          null_ls.builtins.formatting.pint.with({
            condition = function(utils)
              return utils.root_has_file({ 'vendor/bin/pint' })
            end,
          }),
          null_ls.builtins.formatting.prettier.with({
            condition = function(utils)
              return utils.root_has_file({ '.prettierrc', '.prettierrc.json', '.prettierrc.yml', '.prettierrc.js', 'prettier.config.js' })
            end,
          }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
              end,
            })
          end
        end,
      })

      require('mason-null-ls').setup({ automatic_installation = true })

      -- Keymaps
      vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
      vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>')
      vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
      vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
      vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

      -- Commands
      vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = false,
        float = {
          source = true,
        }
      })

      -- Sign configuration
      vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-copilot',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      require('luasnip/loaders/from_snipmate').lazy_load()

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local source_map = {
        buffer = "Buffer",
        nvim_lsp = "LSP",
        nvim_lsp_signature_help = "Signature",
        luasnip = "LuaSnip",
        nvim_lua = "Lua",
        path = "Path",
        copilot = "Copilot",
      }

      local function ltrim(s)
        return s:match'^%s*(.*)'
      end

      cmp.setup({
        preselect = false,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor' },
        },
        window = {
          completion = {
            col_offset = -2 -- align the abbr and word on cursor (due to fields order below)
          }
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = 'symbol',
            -- See: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
            before = function(entry, vim_item)
              -- Replace the 'menu' field with the kind and source
              vim_item.menu = '  ' .. vim_item.kind .. ' (' .. (source_map[entry.source.name] or entry.source.name) .. ')'
              vim_item.menu_hl_group = 'SpecialComment'

              vim_item.abbr = ltrim(vim_item.abbr)

              if vim_item.kind == 'Color' and entry.completion_item.documentation then
                local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
                if r then
                  local color = string.format('%02x', r) .. string.format('%02x', g) ..string.format('%02x', b)
                  local group = 'Tw_' .. color
                  if vim.fn.hlID(group) < 1 then
                    vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
                  end
                  vim_item.kind_hl_group = group
                  return vim_item
                end
              end

              return vim_item
            end
          }),
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- print('tab...')
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          -- { name = 'copilot' },
          { name = 'buffer' },
          { name = 'path' },
        },
        experimental = {
          -- ghost_text = true,
        },
      })
    end,
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  { 'lewis6991/gitsigns.nvim', opts = {}, },

  { 'navarasu/onedark.nvim', priority = 1000, config = function() vim.cmd.colorscheme 'onedark' end, },

  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {}, },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
      { '<leader>f', function() require('telescope.builtin').find_files() end },
      { '<leader>F', function() require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' }) end },
      { '<leader>b', function() require('telescope.builtin').buffers() end },
      { '<leader>g', function() require('telescope').extensions.live_grep_args.live_grep_args() end },
      { '<leader>h', function() require('telescope.builtin').oldfiles() end },
      { '<leader>s', function() require('telescope.builtin').lsp_document_symbols() end },
    },
    config = function ()
      local actions = require('telescope.actions')

      require('telescope').setup({
        defaults = {
          path_display = { truncate = 1 },
          prompt_prefix = '   ',
          selection_caret = '  ',
          layout_config = {
            prompt_position = 'top',
          },
          preview = {
            timeout = 200,
          },
          sorting_strategy = 'ascending',
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ['<C-Down>'] = actions.cycle_history_next,
              ['<C-Up>'] = actions.cycle_history_prev,
            },
          },
          file_ignore_patterns = { '.git/' },
        },
        extensions = {
          live_grep_args = {
            mappings = {
              i = {
                ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
              },
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          buffers = {
            previewer = false,
            layout_config = {
              width = 80,
            },
          },
          oldfiles = {
            prompt_title = 'History',
          },
          lsp_references = {
            previewer = false,
          },
          lsp_definitions = {
            previewer = false,
          },
          lsp_document_symbols = {
            symbol_width = 55,
          },
        },
      })

      require('telescope').load_extension('fzf')
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    keys = {
      { '<leader>1', ':Neotree reveal toggle<CR>' },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        's1n7ax/nvim-window-picker',
        opts = {
          filter_rules = {
            autoselect_one = true,
            include_current_win = false,
            bo = {
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              buftype = { 'terminal', "quickfix" },
            },
          },
          highlights = {
            statusline = {
              focused = {
                bg = '#9d7cd8',
              },
              unfocused = {
                bg = '#9d7cd8',
              },
            },
          },
        },
      },
    },
    opts = {
      close_if_last_window = true,
      hide_root_node = true,
      sources = {
        "filesystem",
        -- "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        winbar = true,
        statusline = false,
        -- separator = { left = "", right= "" },
        show_separator_on_edge = true,
        highlight_tab = "SidebarTabInactive",
        highlight_tab_active = "SidebarTabActive",
        highlight_background = "StatusLine",
        highlight_separator = "SidebarTabInactiveSeparator",
        highlight_separator_active = "SidebarTabActiveSeparator",
      },
      default_component_configs = {
        indent = {
          padding = 0,
        },
        name = {
          use_git_status_colors = false,
          highlight_opened_files = true,
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "open_with_window_picker",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
          },
        },
        -- follow_current_file = {
        --   enabled = true,
        -- },
        group_empty_dirs = false
      },
    },
  },
  {
    'voldikss/vim-floaterm',
    keys = {
      { '<Leader>2', ':FloatermToggle<CR>' },
      { '<Leader>2', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
    },
    cmd = { 'FloatermToggle' },
    init = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    dependencies = {
      { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          custom_calculation = function (node, language_tree)
            if vim.bo.filetype == 'blade' and language_tree._lang ~= 'javascript' then
              return '{{-- %s --}}'
            end
          end,
        },
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'arduino',
        'bash',
        'comment',
        'css',
        'diff',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'html',
        'http',
        'ini',
        'javascript',
        'json',
        'jsonc',
        'lua',
        'make',
        'markdown',
        'passwd',
        'php',
        'phpdoc',
        'python',
        'regex',
        'ruby',
        'rust',
        'sql',
        'svelte',
        'typescript',
        'vim',
        'vue',
        'xml',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "yaml" }
      },
      ts_context_commentstring = {
        enable = true,
      },
      rainbow = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['if'] = '@function.inner',
            ['af'] = '@function.outer',
            ['ia'] = '@parameter.inner',
            ['aa'] = '@parameter.outer',
          },
        },
      },
    },

    -- config = function (_, opts)
    --   require('nvim-treesitter.configs').setup(opts)
    --
    --   local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    --   parser_config.blade = {
    --     install_info = {
    --       url = "https://github.com/EmranMR/tree-sitter-blade",
    --       files = {"src/parser.c"},
    --       branch = "main",
    --     },
    --     filetype = "blade"
    --   }
    --   vim.filetype.add({
    --     pattern = {
    --       ['.*%.blade%.php'] = 'blade',
    --     },
    --   })
    -- end,
  },

}, {})

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- My Configurations

vim.opt.cmdheight = 0
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.spell = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.breakindent = true -- maintain indent when wrapping indented lines
vim.opt.linebreak = true -- wrap at word boundaries
vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.fillchars:append({ eob = ' ' }) -- remove the ~ from end of buffer
vim.opt.mouse = 'a' -- enable mouse for all modes
vim.opt.mousemoveevent = true -- Allow hovering in bufferline
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = 'unnamedplus' -- Use Linux system clipboard
vim.opt.confirm = true -- ask for confirmation instead of erroring
vim.opt.undofile = true -- persistent undo
vim.opt.backup = true -- automatically save a backup file
vim.opt.backupdir:remove('.') -- keep backups out of the current directory
vim.opt.shortmess:append({ I = true }) -- disable the splash screen
vim.opt.wildmode = 'longest:full,full' -- complete the longest common match, and allow tabbing the results to fully complete them
vim.opt.completeopt = 'menuone,longest,preview'
vim.opt.signcolumn = 'yes:2'
vim.opt.showmode = false
vim.opt.updatetime = 4001 -- Set updatime to 1ms longer than the default to prevent polyglot from changing it
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.titlestring = '%f // nvim'

vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- Allow gf to open non-existent files.
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
-- vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
-- vim.keymap.set('i', ',,', '<Esc>A,<Esc>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- Get rid of that weird status line -- 
vim.opt.laststatus = 0

-- More convenient window movements
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })

