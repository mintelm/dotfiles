local utils = { }

function utils.opt(scope, key, value)
    local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
    scopes[scope][key] = value

    if scope ~= 'o' then
        scopes['o'][key] = value
    end
end

function utils.map(mode, lhs, rhs, opts)
  local options = { noremap = true }

  if opts then
      options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.set_tab_width(tab_width)
    utils.opt('b', 'tabstop', tab_width)
    utils.opt('b', 'shiftwidth', tab_width)
end

return utils
