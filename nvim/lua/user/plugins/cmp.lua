return {
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
}

--return {
--	"hrsh7th/nvim-cmp",
--	event = "InsertEnter",
--	dependencies = {
--		-- Snippet Engine & its associated nvim-cmp source
--		{
--			"L3MON4D3/LuaSnip",
--			build = (function()
--				-- Build Step is needed for regex support in snippets.
--				-- This step is not supported in many windows environments.
--				-- Remove the below condition to re-enable on windows.
--				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--					return
--				end
--				return "make install_jsregexp"
--			end)(),
--			dependencies = {
--				-- `friendly-snippets` contains a variety of premade snippets.
--				--    See the README about individual language/framework/plugin snippets:
--				--    https://github.com/rafamadriz/friendly-snippets
--				-- {
--				--   'rafamadriz/friendly-snippets',
--				--   config = function()
--				--     require('luasnip.loaders.from_vscode').lazy_load()
--				--   end,
--				-- },
--			},
--		},
--		"saadparwaiz1/cmp_luasnip",

--		-- Adds other completion capabilities.
--		--  nvim-cmp does not ship with all sources by default. They are split
--		--  into multiple repos for maintenance purposes.
--		"hrsh7th/cmp-nvim-lsp",
--		"hrsh7th/cmp-path",
--		"hrsh7th/cmp-nvim-lsp-signature-help",
--	},
--	config = function()
--		-- See `:help cmp`
--		local cmp = require("cmp")
--		local luasnip = require("luasnip")
--		luasnip.config.setup({})

--		cmp.setup({
--			snippet = {
--				expand = function(args)
--					luasnip.lsp_expand(args.body)
--				end,
--			},

--			-- For an understanding of why these mappings were
--			-- chosen, you will need to read `:help ins-completion`
--			--
--			-- No, but seriously. Please read `:help ins-completion`, it is really good!
--			mapping = cmp.mapping.preset.insert({
--				-- Select the [n]ext item
--				["<C-n>"] = cmp.mapping.select_next_item(),
--				-- Select the [p]revious item
--				["<C-p>"] = cmp.mapping.select_prev_item(),

--				-- Scroll the documentation window [b]ack / [f]orward
--				["<C-b>"] = cmp.mapping.scroll_docs(-4),
--				["<C-f>"] = cmp.mapping.scroll_docs(4),

--				-- Accept ([y]es) the completion.
--				--  This will auto-import if your LSP supports it.
--				--  This will expand snippets if the LSP sent a snippet.
--				["<C-y>"] = cmp.mapping.confirm({ select = true }),

--				-- If you prefer more traditional completion keymaps,
--				-- you can uncomment the following lines
--				--['<CR>'] = cmp.mapping.confirm { select = true },
--				--['<Tab>'] = cmp.mapping.select_next_item(),
--				--['<S-Tab>'] = cmp.mapping.select_prev_item(),

--				-- Manually trigger a completion from nvim-cmp.
--				--  Generally you don't need this, because nvim-cmp will display
--				--  completions whenever it has completion options available.
--				["<C-Space>"] = cmp.mapping.complete({}),

--				-- Think of <c-l> as moving to the right of your snippet expansion.
--				--  So if you have a snippet that's like:
--				--  function $name($args)
--				--    $body
--				--  end
--				--
--				-- <c-l> will move you to the right of each of the expansion locations.
--				-- <c-h> is similar, except moving you backwards.
--				["<C-l>"] = cmp.mapping(function()
--					if luasnip.expand_or_locally_jumpable() then
--						luasnip.expand_or_jump()
--					end
--				end, { "i", "s" }),
--				["<C-h>"] = cmp.mapping(function()
--					if luasnip.locally_jumpable(-1) then
--						luasnip.jump(-1)
--					end
--				end, { "i", "s" }),

--				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--			}),
--			sources = {
--				{
--					name = "lazydev",
--					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
--					group_index = 0,
--				},
--				{ name = "nvim_lsp" },
--				{ name = "luasnip" },
--				{ name = "path" },
--				{ name = "nvim_lsp_signature_help" },
--			},
--		})
--	end,
--}
