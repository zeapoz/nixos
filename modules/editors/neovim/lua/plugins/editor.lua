return {
  {
    "folke/flash.nvim",
    opts = {
      label = { rainbow = { enabled = true } },
    },
  },
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufReadPre" },
    opts = {
      events = { "InsertLeave", "TextChanged", "BufLeave", "FocusLost" },
      silent = false,
      timeout = nil,
    },
  },
}
