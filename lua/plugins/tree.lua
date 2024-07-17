return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
		end

		require("nvim-tree").setup({
			on_attach = my_on_attach,
		})
	end,
}
