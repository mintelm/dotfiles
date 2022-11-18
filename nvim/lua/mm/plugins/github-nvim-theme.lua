return function()
    local theme_style = 'dark_default'
    local colors = require('github-theme.palette').get_palette(theme_style)

    require('github-theme').setup({
        theme_style = theme_style,
        function_style = 'bold',
        comment_style = 'NONE',
        keyword_style = 'NONE',
        variable_style = 'NONE',
        colors = {
            git_signs = {
                add = colors.git.add,
                change = colors.git.change,
                delete = colors.git.delete,
            },
        },
    })
end
