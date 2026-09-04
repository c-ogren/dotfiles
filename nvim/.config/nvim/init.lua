--------------------------------------------------
-- Leader
--------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------
-- Options
--------------------------------------------------

vim.opt.updatetime = 250

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8

vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

vim.opt.guicursor = {
	"n-v-c:block-Cursor",
	"i-ci-ve:ver25-Cursor",
	"r-cr:hor20-Cursor",
	"o:hor50-Cursor",
}

vim.opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
}

-- Neovim 0.11+
vim.o.winborder = "rounded"
--------------------------------------------------
-- Deutan-friendly highlights
--------------------------------------------------

local function apply_highlights()
	local float_bg = "#1f2428"
	local border = "#6e7681"

	-- Main editor
	vim.api.nvim_set_hl(0, "Normal", {
		bg = "NONE",
	})

	-- Line numbers
	vim.api.nvim_set_hl(0, "LineNr", {
		fg = "#6e7681",
	})

	vim.api.nvim_set_hl(0, "CursorLineNr", {
		fg = "#ffffff",
		bg = "#30363d",
		bold = true,
	})

	-- Current line
	vim.api.nvim_set_hl(0, "CursorLine", {
		bg = "#21262d",
	})

	-- Cursor
	vim.api.nvim_set_hl(0, "Cursor", {
		fg = "#0d1117",
		bg = "#ffffff",
	})

	-- Floating windows
	vim.api.nvim_set_hl(0, "NormalFloat", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "FloatBorder", {
		bg = float_bg,
		fg = border,
	})

	vim.api.nvim_set_hl(0, "FloatTitle", {
		bg = float_bg,
	})

	-- Completion menu
	vim.api.nvim_set_hl(0, "Pmenu", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "PmenuSel", {
		bg = "#30363d",
		fg = "#ffffff",
		bold = true,
	})

	vim.api.nvim_set_hl(0, "PmenuSbar", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "PmenuThumb", {
		bg = border,
	})

	-- Diagnostics
	vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {
		bg = float_bg,
		fg = "#ffa198",
	})

	vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", {
		bg = float_bg,
		fg = "#e3b341",
	})

	vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", {
		bg = float_bg,
		fg = "#79c0ff",
	})

	vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", {
		bg = float_bg,
		fg = "#56b4e9",
	})

	-- GitSigns
	--
	-- Add    = blue
	-- Change = yellow
	-- Delete = salmon
	--
	-- Avoids relying on green/red distinction.
	vim.api.nvim_set_hl(0, "GitSignsAdd", {
		fg = "#58a6ff",
	})

	vim.api.nvim_set_hl(0, "GitSignsUntracked", {
		fg = "#58a6ff",
	})

	vim.api.nvim_set_hl(0, "GitSignsChange", {
		fg = "#e3b341",
	})

	vim.api.nvim_set_hl(0, "GitSignsChangedelete", {
		fg = "#e3b341",
	})

	vim.api.nvim_set_hl(0, "GitSignsDelete", {
		fg = "#ffa198",
	})

	vim.api.nvim_set_hl(0, "GitSignsTopdelete", {
		fg = "#ffa198",
	})

	-- Telescope
	vim.api.nvim_set_hl(0, "TelescopeNormal", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "TelescopeBorder", {
		bg = float_bg,
		fg = border,
	})

	vim.api.nvim_set_hl(0, "TelescopePromptNormal", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "TelescopePreviewNormal", {
		bg = float_bg,
	})

	vim.api.nvim_set_hl(0, "TelescopeSelection", {
		bg = "#30363d",
		fg = "#ffffff",
		bold = true,
	})

	-- Embedded terminal
	vim.api.nvim_set_hl(0, "TerminalNormal", {
		bg = float_bg,
	})
end

-- Reapply custom colors whenever a colorscheme loads.
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_highlights,
})

--------------------------------------------------
-- General keymaps
--------------------------------------------------

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Grep word under cursor" })

vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })

vim.keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })

vim.keymap.set("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Keymaps" })

vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

vim.keymap.set("n", "<leader>fc", "<cmd>Telescope resume<CR>", { desc = "Resume last picker" })

--------------------------------------------------
-- File explorer
--------------------------------------------------

vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

--------------------------------------------------
-- LSP
--------------------------------------------------

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP Implementation" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

--------------------------------------------------
-- Jump history
--------------------------------------------------

vim.keymap.set("n", "<C-h>", "<C-o>", { desc = "Jump Back" })

vim.keymap.set("n", "<C-l>", "<C-i>", { desc = "Jump Forward" })

--------------------------------------------------
-- Save / buffers
--------------------------------------------------

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

vim.keymap.set("n", "<S-h>", "<cmd>bprev<CR>", { desc = "Previous buffer" })

--------------------------------------------------
-- Window navigation
--------------------------------------------------

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left window" })

vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to bottom window" })

vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to top window" })

vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right window" })

--------------------------------------------------
-- Search / scrolling QoL
--------------------------------------------------

vim.keymap.set("n", "<leader><space>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })

vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

--------------------------------------------------
-- Visual mode QoL
--------------------------------------------------

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without replacing register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

--------------------------------------------------
-- Embedded terminal
--------------------------------------------------

vim.keymap.set("n", "<leader>tt", function()
	vim.cmd("botright 10split | terminal")
	vim.cmd("startinsert")
end, {
	desc = "Open terminal at bottom",
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.wo.winhighlight = "Normal:TerminalNormal"
	end,
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--------------------------------------------------
-- Diagnostics
--------------------------------------------------

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,

	float = {
		border = "rounded",
		source = true,
	},
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({
		count = -1,
		float = true,
	})
end, {
	desc = "Previous diagnostic",
})

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({
		count = 1,
		float = true,
	})
end, {
	desc = "Next diagnostic",
})

vim.keymap.set("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Diagnostics location list" })

--------------------------------------------------
-- Rust-specific config
--------------------------------------------------

vim.g.rustaceanvim = {
	tools = {
		-- rustaceanvim can automatically use clippy
		-- when it is installed.
		enable_clippy = true,
	},
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",

	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4

		vim.keymap.set("n", "<leader>rr", function()
			vim.cmd.RustLsp("runnables")
		end, {
			buffer = true,
			desc = "Rust runnables",
		})

		vim.keymap.set("n", "<leader>rd", function()
			vim.cmd.RustLsp("debuggables")
		end, {
			buffer = true,
			desc = "Rust debuggables",
		})

		vim.keymap.set("n", "<leader>rm", function()
			vim.cmd.RustLsp("expandMacro")
		end, {
			buffer = true,
			desc = "Expand Rust macro",
		})

		vim.keymap.set("n", "K", function()
			vim.cmd.RustLsp({ "hover", "actions" })
		end, {
			buffer = true,
			desc = "Rust hover actions",
		})
	end,
})

--------------------------------------------------
-- Lazy.nvim bootstrap
--------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

--------------------------------------------------
-- Plugins
--------------------------------------------------

require("lazy").setup({

	------------------------------------------------
	-- GitHub colorblind theme
	------------------------------------------------

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,

		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})

			vim.cmd.colorscheme("github_dark_colorblind")
		end,
	},

	------------------------------------------------
	-- LSP
	------------------------------------------------

	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Apply cmp capabilities to all LSP servers,
			-- including rust-analyzer.
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("ts_ls", {
				cmd = {
					"pnpm",
					"exec",
					"typescript-language-server",
					"--stdio",
				},

				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},

				root_markers = {
					"tsconfig.json",
					"package.json",
					".git",
				},
			})

			vim.lsp.enable("ts_ls")
		end,
	},

	------------------------------------------------
	-- Completion
	------------------------------------------------

	{
		"hrsh7th/nvim-cmp",

		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},

		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),

					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),

				window = {
					completion = {
						border = "rounded",

						winhighlight = "Normal:Pmenu,"
							.. "FloatBorder:FloatBorder,"
							.. "CursorLine:PmenuSel,"
							.. "Search:None",
					},

					documentation = {
						border = "rounded",

						winhighlight = "Normal:Pmenu,"
							.. "FloatBorder:FloatBorder,"
							.. "CursorLine:PmenuSel,"
							.. "Search:None",
					},
				},
			})
		end,
	},

	------------------------------------------------
	-- Treesitter
	------------------------------------------------

	{
		"nvim-treesitter/nvim-treesitter",

		-- Current Treesitter should not be
		-- lazy-loaded.
		lazy = false,

		build = ":TSUpdate",

		config = function()
			local parsers = {
				"typescript",
				"tsx",
				"javascript",
				"rust",
				"lua",
				"json",
				"css",
				"scss",
				"html",
				"diff",
			}

			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"typescript",
					"typescriptreact",
					"javascript",
					"javascriptreact",
					"rust",
					"lua",
					"json",
					"css",
					"scss",
					"html",
				},

				callback = function()
					local ok = pcall(vim.treesitter.start)

					if ok then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	------------------------------------------------
	-- Indent guides
	------------------------------------------------

	{
		"lukas-reineke/indent-blankline.nvim",

		main = "ibl",

		event = {
			"BufReadPre",
			"BufReadPost",
			"BufNewFile",
		},

		opts = {
			indent = {
				char = "│",
			},

			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				injected_languages = true,
			},
		},
	},

	------------------------------------------------
	-- GitSigns
	------------------------------------------------

	{
		"lewis6991/gitsigns.nvim",

		config = function()
			require("gitsigns").setup({

				-- Shape + color.
				-- Better than color alone.
				signs = {
					add = {
						text = "+",
					},

					change = {
						text = "~",
					},

					delete = {
						text = "_",
					},

					topdelete = {
						text = "‾",
					},

					changedelete = {
						text = "~",
					},

					untracked = {
						text = "?",
					},
				},

				on_attach = function(bufnr)
					local gs = require("gitsigns")

					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, {
							buffer = bufnr,
							desc = desc,
						})
					end

					map("n", "]c", function()
						gs.nav_hunk("next")
					end, "Next Git hunk")

					map("n", "[c", function()
						gs.nav_hunk("prev")
					end, "Previous Git hunk")

					map("n", "<leader>hs", gs.stage_hunk, "Stage Git hunk")

					map("n", "<leader>hr", gs.reset_hunk, "Reset Git hunk")

					map("n", "<leader>hp", gs.preview_hunk, "Preview Git hunk")

					map("n", "<leader>hb", function()
						gs.blame_line({
							full = true,
						})
					end, "Blame line")

					map("n", "<leader>hd", gs.diffthis, "Git diff buffer")
				end,
			})
		end,
	},

	------------------------------------------------
	-- Linting
	------------------------------------------------

	{
		"mfussenegger/nvim-lint",

		config = function()
			local lint = require("lint")

			-- Manual TypeScript project check.
			lint.linters.tsc_no_emit = {
				cmd = "pnpm",
				stdin = false,

				args = {
					"exec",
					"tsc",
					"--noEmit",
					"--pretty",
					"false",
				},

				ignore_exitcode = true,

				parser = require("lint.parser").from_pattern("([^%(]+)%((%d+),(%d+)%)%: error TS%d+%: (.+)", {
					"file",
					"lnum",
					"col",
					"message",
				}, {
					source = "tsc",
					severity = vim.diagnostic.severity.ERROR,
				}),
			}

			-- ESLint runs automatically.
			--
			-- tsc does NOT run on every save because
			-- project-wide tsc can be expensive.
			--
			-- Rust diagnostics/clippy are handled by
			-- rustaceanvim/rust-analyzer.
			lint.linters_by_ft = {
				typescript = {
					"eslint",
				},

				typescriptreact = {
					"eslint",
				},

				javascript = {
					"eslint",
				},

				javascriptreact = {
					"eslint",
				},
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>tc", function()
				lint.try_lint("tsc_no_emit")
			end, {
				desc = "TypeScript project check",
			})
		end,
	},

	------------------------------------------------
	-- Formatting
	------------------------------------------------

	{
		"stevearc/conform.nvim",

		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					typescript = {
						"prettier",
					},

					typescriptreact = {
						"prettier",
					},

					javascript = {
						"prettier",
					},

					javascriptreact = {
						"prettier",
					},

					rust = {
						"rustfmt",
					},

					lua = {
						"stylua",
					},
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})

			vim.keymap.set("n", "<leader>fm", function()
				conform.format({
					async = true,
					lsp_format = "fallback",
				})
			end, {
				desc = "Format buffer",
			})
		end,
	},

	------------------------------------------------
	-- Nvim Tree
	------------------------------------------------

	{
		"nvim-tree/nvim-tree.lua",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {},
	},

	------------------------------------------------
	-- Telescope
	------------------------------------------------

	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("telescope").setup({
				defaults = {

					borderchars = {
						"─",
						"│",
						"─",
						"│",
						"╭",
						"╮",
						"╯",
						"╰",
					},

					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/*",
					},
				},

				pickers = {
					find_files = {
						theme = "dropdown",
						hidden = true,

						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob=!.git/*",
						},
					},

					live_grep = {
						theme = "dropdown",

						additional_args = function()
							return {
								"--hidden",
								"--glob=!.git/*",
							}
						end,
					},
				},
			})
		end,
	},

	------------------------------------------------
	-- Copilot
	------------------------------------------------

	{
		"zbirenbaum/copilot.lua",

		cmd = "Copilot",
		event = "InsertEnter",

		config = function()
			require("copilot").setup({
				-- nvim-cmp handles Copilot suggestions.
				suggestion = {
					enabled = true,
					auto_trigger = true,

					keymap = {
						accept = "<C-j>",
						accept_word = "<C-w>",
						accept_line = "<C-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},

				panel = {
					enabled = false,
				},
			})
		end,
	},

	------------------------------------------------
	-- Copilot Chat
	------------------------------------------------

	{
		"CopilotC-Nvim/CopilotChat.nvim",

		dependencies = {
			{
				"zbirenbaum/copilot.lua",
			},

			{
				"nvim-lua/plenary.nvim",
				branch = "master",
			},
		},

		build = "make tiktoken",

		opts = {
			window = {
				layout = "vertical",
				width = 0.4,
			},
		},
	},

	------------------------------------------------
	-- Autopairs
	------------------------------------------------

	{
		"windwp/nvim-autopairs",

		event = "InsertEnter",

		opts = {},
	},

	------------------------------------------------
	-- Rust
	------------------------------------------------

	{
		"mrcjkb/rustaceanvim",

		version = "^9",

		-- rustaceanvim handles its own lazy
		-- initialization.
		lazy = false,
	},

	{
		"saecki/crates.nvim",

		event = {
			"BufRead Cargo.toml",
		},

		config = true,
	},

	------------------------------------------------
	-- Which-key
	------------------------------------------------

	{
		"folke/which-key.nvim",

		event = "VeryLazy",

		opts = {
			preset = "modern",
		},
	},

	------------------------------------------------
	-- Flash
	------------------------------------------------

	{
		"folke/flash.nvim",

		event = "VeryLazy",

		opts = {},

		keys = {
			{
				"s",
				mode = {
					"n",
					"x",
					"o",
				},

				function()
					require("flash").jump()
				end,

				desc = "Flash",
			},

			{
				"S",
				mode = {
					"n",
					"o",
					"x",
				},

				function()
					require("flash").treesitter()
				end,

				desc = "Flash Treesitter",
			},

			{
				"r",
				mode = "o",

				function()
					require("flash").remote()
				end,

				desc = "Remote Flash",
			},

			{
				"R",
				mode = {
					"o",
					"x",
				},

				function()
					require("flash").treesitter_search()
				end,

				desc = "Treesitter Search",
			},

			{
				"<C-s>",
				mode = "c",

				function()
					require("flash").toggle()
				end,

				desc = "Toggle Flash Search",
			},
		},
	},

	------------------------------------------------
	-- Surround
	------------------------------------------------

	{
		"kylechui/nvim-surround",

		version = "*",
		event = "VeryLazy",

		opts = {},
	},

	------------------------------------------------
	-- Trouble
	------------------------------------------------

	{
		"folke/trouble.nvim",

		cmd = "Trouble",

		opts = {},

		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<CR>",
				desc = "Diagnostics",
			},

			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Buffer diagnostics",
			},

			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<CR>",
				desc = "Symbols",
			},

			{
				"<leader>xr",
				"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
				desc = "LSP refs/defs",
			},

			{
				"<leader>xl",
				"<cmd>Trouble loclist toggle<CR>",
				desc = "Location list",
			},

			{
				"<leader>xq",
				"<cmd>Trouble qflist toggle<CR>",
				desc = "Quickfix list",
			},
		},
	},

	------------------------------------------------
	--- Cloak
	------------------------------------------------

	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				patterns = {
					{
						file_pattern = ".env*",
						cloak_pattern = "=.+",
					},
				},
			})
		end,
	},
	------------------------------------------------
	-- Oil
	------------------------------------------------

	{
		"stevearc/oil.nvim",

		opts = {
			view_options = {
				show_hidden = true,
			},
		},

		keys = {
			{
				"-",
				"<cmd>Oil<CR>",
				desc = "Open parent directory",
			},
		},
	},

	------------------------------------------------
	-- Todo comments
	------------------------------------------------

	{
		"folke/todo-comments.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

		opts = {},
	},

	------------------------------------------------
	-- Better buffer removal
	------------------------------------------------

	{
		"nvim-mini/mini.bufremove",

		config = function()
			require("mini.bufremove").setup()

			vim.keymap.set("n", "<leader>bd", function()
				require("mini.bufremove").delete(0, false)
			end, {
				desc = "Close buffer",
			})
		end,
	},

	------------------------------------------------
	-- Snacks
	------------------------------------------------

	{
		"folke/snacks.nvim",

		priority = 1000,
		lazy = false,

		opts = {
			bigfile = {
				enabled = true,
			},

			notifier = {
				enabled = true,
			},

			quickfile = {
				enabled = true,
			},

			words = {
				enabled = true,
			},

			scroll = {
				enabled = true,
			},

			picker = {
				enabled = true,
				ui_select = true,
			},
		},

		keys = {
			{
				"]r",

				function()
					Snacks.words.jump(1)
				end,

				desc = "Next reference",
			},

			{
				"[r",

				function()
					Snacks.words.jump(-1)
				end,

				desc = "Previous reference",
			},

			{
				"<leader>uh",

				function()
					Snacks.notifier.show_history()
				end,

				desc = "Notification history",
			},
		},
	},

	------------------------------------------------
	-- Sessions
	------------------------------------------------

	{
		"folke/persistence.nvim",

		event = "BufReadPre",

		opts = {},

		keys = {
			{
				"<leader>qs",

				function()
					require("persistence").load()
				end,

				desc = "Restore session",
			},
		},
	},

	------------------------------------------------
	-- Lualine
	------------------------------------------------

	{
		"nvim-lualine/lualine.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
			},
		},
	},

	------------------------------------------------
	-- LSP progress
	------------------------------------------------

	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	------------------------------------------------
	-- DAP
	------------------------------------------------

	{
		"mfussenegger/nvim-dap",

		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			require("nvim-dap-virtual-text").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })

			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })

			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })

			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })

			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
}, {
	rocks = {
		enabled = false,
	},
})

--------------------------------------------------
-- Copilot keymaps
--------------------------------------------------

local copilot_active = true

vim.keymap.set("n", "<leader>ct", function()
	if copilot_active then
		vim.cmd("Copilot disable")
		vim.notify("Copilot: OFF")
		copilot_active = false
	else
		vim.cmd("Copilot enable")
		vim.notify("Copilot: ON")
		copilot_active = true
	end
end, {
	desc = "Toggle Copilot",
})

vim.keymap.set({ "n", "v" }, "<leader>cc", function()
	require("CopilotChat").toggle()
end, {
	desc = "Toggle Copilot Chat",
})

vim.keymap.set("n", "<leader>cq", function()
	vim.ui.input({
		prompt = "Quick Chat: ",
	}, function(input)
		if input and input ~= "" then
			require("CopilotChat").ask(input)
		end
	end)
end, {
	desc = "Quick Copilot Chat",
})

--------------------------------------------------
-- Apply highlights once at startup
--------------------------------------------------

apply_highlights()
