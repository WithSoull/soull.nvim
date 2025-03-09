return {
	"gaelph/logsitter.nvim",
	dependencies = {"nvim-treesitter/nvim-treesitter"},
	config = function()
		require("logsitter").setup({
			path_format = "default",
			prefix = "[LS] ->",
			separator = "->",
		})
	end
}
