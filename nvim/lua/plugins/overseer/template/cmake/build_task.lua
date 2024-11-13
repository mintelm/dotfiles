return {
    name = 'CMake: Build',
    priority = 20,
    condition = {
        callback = function()
            for name in vim.fs.dir('.') do
                if name == 'CMakeLists.txt' then return true end
            end
            return false
        end,
    },
    builder = function(_)
        return {
            cmd = { 'cmake' },
            args = { '--build', 'build-cc', '-j' },
        }
    end,
}
