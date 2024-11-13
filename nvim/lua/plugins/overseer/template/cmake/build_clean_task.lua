return {
    name = 'CMake: Build clean',
    priority = 21,
    condition = {
        callback = function()
            local iter = vim.fs.dir('.')
            while true do
                local name = iter()
                if name == nil then return false end
                if name == 'CMakeLists.txt' then return true end
            end
        end,
    },
    builder = function(_)
        return {
            cmd = { 'cmake' },
            args = { '--build', 'build-cc', '--clean-first', '-j' },
        }
    end,
}
