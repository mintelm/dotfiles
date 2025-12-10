return {
    name = 'CMake: Run tests',
    priority = 22,
    condition = {
        callback = function()
            return mivim.utils.is_cmake_project('.')
        end
    },
    builder = function()
        return {
            cmd = { 'ctest' },
            args = { '--test-dir', 'build-cc/BSW/*', '-V' },
            env = {
                GTEST_COLOR = '1',
            },
        }
    end,
}
