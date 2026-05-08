-- Additional tools for C++ and Python development
-- Note: LazyVim extras for clangd and python are imported in lua/config/lazy.lua
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- C++ tools
        "clangd",
        "clang-format",
        "cmake-language-server",
        "codelldb", -- C++ debugger
        
        -- Python tools  
        "pyright",
        "ruff",
        "debugpy", -- Python debugger
        
        -- General tools
        "shellcheck",
        "shfmt",
      },
    },
  },
}
