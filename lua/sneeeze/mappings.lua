local map = vim.keymap.set

map("n", "<leader>li", "<cmd>LspInfo<CR>")
map("n", "<leader>lr", "<cmd>LspRestart<CR>")
map("n", "<leader>lI", "<cmd>Mason<CR>")

map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>Y", [["+y$]])
map({ "n", "v" }, "<leader>p", [["+p]])
map({ "n", "v" }, "<leader>P", [["+P]])
map({ "n", "v" }, "<leader>d", [["_d]])

map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

map("n", "<A-u>", "<cmd>vertical resize -2<CR>")
map("n", "<A-i>", "<cmd>resize +2<CR>")
map("n", "<A-o>", "<cmd>resize -2<CR>")
map("n", "<A-p>", "<cmd>vertical resize +2<CR>")

-- nice for deleting snippet placeholders
map("s", "<C-h>", [[<C-g>"_c]])
map("s", "<BS>", [[<C-g>"_c]])

-- luasnips
map({ "s", "i" }, "<C-l>", function()
	if require("luasnip").choice_active() then
		require("luasnip").change_choice(1)
	end
end)

-- telescope
map("n", "<C-p>", require("telescope.builtin").find_files)
map("n", "<leader>fg", require("telescope.builtin").live_grep)
map("n", "<leader>fo", require("telescope.builtin").oldfiles)
map("n", "<leader>fb", require("telescope.builtin").buffers)
map("n", "<leader>fh", require("telescope.builtin").help_tags)
map("n", "<leader>fc", require("telescope.builtin").commands)
map("n", "z=", require("telescope.builtin").spell_suggest)

-- git
map("n", "<leader>gs", "<cmd>Git<CR>")
map("n", "<leader>gl", "<cmd>Git log<CR>")

map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
map("n", "]g", require("gitsigns").next_hunk)
map("n", "[g", require("gitsigns").prev_hunk)
map("n", "<leader>gp", require("gitsigns").preview_hunk)
map("n", "<leader>grh", require("gitsigns").reset_hunk)
map("n", "<leader>grb", require("gitsigns").reset_buffer)

-- harpoon
map("n", "<leader>a", function()
	require("harpoon.mark").add_file()
end)
map("n", "<C-e>", function()
	require("harpoon.ui").toggle_quick_menu()
end)

map("n", "<C-h>", function()
	require("harpoon.ui").nav_file(1)
end)
map("n", "<C-t>", function()
	require("harpoon.ui").nav_file(2)
end)
map("n", "<C-n>", function()
	require("harpoon.ui").nav_file(3)
end)
map("n", "<C-s>", function()
	require("harpoon.ui").nav_file(4)
end)

map("n", "<leader>r", function()
	local old_name = vim.fn.expand "%:t"
	local new_name = vim.fn.input("New file name: ", old_name)

	if new_name == "" or new_name == old_name then
		print()
		return
	end

	vim.cmd("Rename " .. new_name)
end)

map("n", "]b", "<cmd>bnext<CR>")
map("n", "[b", "<cmd>bprevious<CR>")
map("n", "]q", "<cmd>cnext<CR>")
map("n", "[q", "<cmd>cprevious<CR>")

map("n", "<leader>t", vim.cmd.Ex)
map("n", "<leader>s", "<cmd>set spell!<CR>")
map("n", "<leader><leader>s", "<cmd>source %<CR>")
