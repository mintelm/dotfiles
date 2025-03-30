return {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = 'nvim-lua/plenary.nvim',
    config = true
}
