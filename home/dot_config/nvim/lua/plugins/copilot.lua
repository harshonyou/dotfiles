return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept = "<M-l>",
				accept_word = "<M-w>",
				accept_line = "<M-e>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<M-\\>",
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = false,
		},
	},
}
