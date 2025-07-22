require("config.lazy")
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.cmd[[colorscheme tokyonight-night]]
vim.wo.number = true
vim.opt.mouse = ""

-- Navigate down one directory
vim.keymap.set('n', '<leader>grd', function()
  vim.cmd 'cd ..'
end, { desc = 'Navigate down one directory from current' })

-- Set the working directory to the path of the current buffer.
vim.keymap.set('n', '<leader>grb', function()
  vim.cmd('cd ' .. vim.fn.expand '%:p:h')
end, { desc = 'Set working directory to path of buffer.' })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

vim.keymap.set('n', '<leader>f', function()
  vim.cmd('FzfLua files')
end, { desc = 'Fuzzy file search' })

