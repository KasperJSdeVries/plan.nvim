local pickers    = require("telescope.pickers")
local finders    = require("telescope.finders")
local config     = require("telescope.config").values
local previewers = require("telescope.previewers")

local M          = {}

M.print_file     = function(opts)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local items = {}

	for i, line in ipairs(lines) do
		if string.match(line, 'TODO') then
			table.insert(items, { filename = vim.api.nvim_buf_get_name(0), lnum = i, col = 0, text = line })
		end
	end

	pickers.new(opts, {
		finder = finders.new_table({
			results = items,
			entry_maker = function(entry)
				return {
					display = entry.filename .. ": " .. entry.lnum,
					ordinal = entry.lnum,
				}
			end
		}),

		sorter = config.generic_sorter(opts),

		previewer = previewers.new_buffer_previewer({
			title = "Todo Preview",
			define_preview = function(self, entry)
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, { entry.text })
			end
		})
	})
		:find()
end

M.print_file()

return M
