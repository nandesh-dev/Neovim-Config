return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
	end,
}
