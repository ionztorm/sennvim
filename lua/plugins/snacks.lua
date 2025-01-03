return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		input = {
			enabled = true,
			position = "float",
			border = "rounded",
			title_pos = "center",
			relative = "editor",
			icon = " ",
			icon_hl = "SnacksInputIcon",
			icon_pos = "left",
			prompt_pos = "title",
			win = { style = "input" },
			expand = true,
		},
		dim = {
			enabled = true,
			---@type snacks.scope.Config
			scope = {
				min_size = 5,
				max_size = 20,
				siblings = true,
			},
			-- animate scopes. Enabled by default for Neovim >= 0.10
			-- Works on older versions but has to trigger redraws during animation.
			---@type snacks.animate.Config|{enabled?: boolean}
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				easing = "outQuad",
				duration = {
					step = 20, -- ms per step
					total = 300, -- maximum duration
				},
			},
			-- what buffers to dim
			filter = function(buf)
				return vim.g.snacks_dim ~= false and vim.b[buf].snacks_dim ~= false and vim.bo[buf].buftype == ""
			end,
		},
		git = { enabled = true },
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 250 },
				easing = "linear",
			},
			spamming = 10, -- threshold for spamming detection
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		notifier = {
			enabled = true,
			timeout = 3000, -- default timeout in ms
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			-- editor margin to keep free. tabline and statusline are taken into account automatically
			margin = { top = 0, right = 1, bottom = 0 },
			padding = true, -- add 1 cell of left/right padding to the notification window
			sort = { "level", "added" }, -- sort by level and time
			-- minimum log level to display. TRACE is the lowest
			-- all notifications are stored in history
			level = vim.log.levels.TRACE,
			icons = {
				error = " ",
				warn = " ",
				info = " ",
				debug = " ",
				trace = " ",
			},
			keep = function(notif)
				return vim.fn.getcmdpos() > 0
			end,
			---@type snacks.notifier.style
			style = "compact",
			top_down = true, -- place notifications from top to bottom
			date_format = "%R", -- time format for notifications
			-- format for footer when more lines are available
			-- `%d` is replaced with the number of lines.
			-- only works for styles with a border
			---@type string|boolean
			more_format = " ↓ %d lines ",
			refresh = 50, -- refresh at most every 50ms
		},
	},

	config = function(_, opts)
		require("snacks").setup(opts)
	end,
}
