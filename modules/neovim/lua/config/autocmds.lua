local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Reset wezterm values.
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  group = augroup("reset_wezterm_padding"),
  callback = function()
    require("wezterm").set_user_var("set_padding", 20)
  end,
})

-- Function to sort packages inside a specific block
local function sort_packages_block(lines)
  local normal_packages = {}
  local input_packages = {}

  for _, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    if trimmed ~= "" and trimmed ~= "[" and trimmed ~= "]" then
      if string.match(trimmed, "^inputs%.") then
        table.insert(input_packages, line)
      else
        table.insert(normal_packages, line)
      end
    end
  end

  table.sort(normal_packages)
  table.sort(input_packages)

  return vim.list_extend(normal_packages, input_packages)
end

-- Main function that scans the buffer and sorts any packages blocks
local function auto_sort_nix_packages()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local inside_packages_block = false
  local start_idx = nil

  for idx, line in ipairs(lines) do
    if not inside_packages_block then
      if line:match("^%s*packages%s*=%s*with%s+pkgs;%s*%[") then
        inside_packages_block = true
        start_idx = idx
      end
    else
      if line:match("^%s*%]") then
        -- End of block
        if start_idx then
          local block_lines = vim.list_slice(lines, start_idx + 1, idx - 1)
          local sorted_block = sort_packages_block(block_lines)

          vim.api.nvim_buf_set_lines(bufnr, start_idx, idx - 1, false, sorted_block)
        end
        inside_packages_block = false
        start_idx = nil
      end
    end
  end
end

-- Auto-command that triggers only on saving .nix files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    auto_sort_nix_packages()
  end,
})
