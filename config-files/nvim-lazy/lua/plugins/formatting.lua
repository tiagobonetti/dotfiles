return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "100", "--target-version", "py311" },
        },
        isort = {
          prepend_args = { "--profile", "black", "--line-length", "100", "--py", "311" },
        },
      },
    },
  },
}
