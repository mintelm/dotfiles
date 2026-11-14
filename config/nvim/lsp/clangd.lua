return {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '-j=4',
        '--fallback-style=llvm',
    },
    root_markers = { '.git', '.clangd', 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
}
