return function()
    vim.g.coq_settings = {
        auto_start = 'shut-up',
        clients = {
            buffers = {
                enabled = false
            }
        }
    }
end
