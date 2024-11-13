return {
    name = 'CMake: Run tests',
    priority = 22,
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
            cmd = { 'ctest' },
            args = { '--test-dir', 'build-cc', '-V' },
            env = {
                GTEST_COLOR = '1',
            },
        }
    end,
}
