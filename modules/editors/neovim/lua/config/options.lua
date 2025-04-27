local g = vim.g
local opt = vim.opt

-- Wrap.
opt.showbreak = "󱞩 "

opt.fillchars = {
  eob = " ", -- Disable end of buffers tildes (~).
  -- Disable vertical view splits.
  vert = " ",
  vertleft = "─",
  vertright = "─",
  verthoriz = "─",
  horizup = "─",
  horizdown = "─",
}
opt.listchars = {
  precedes = "«",
  trail = "·",
}

-- Neovide settings.
if g.neovide then
  opt.guifont = "Maple Mono NF:h12.5"
  opt.linespace = -1

  g.neovide_transparency = 0.9
  g.neovide_hide_mouse_when_typing = true
  g.neovide_fullscreen = false
  g.neovide_remember_window_size = false
  g.neovide_input_ime = false
  g.neovide_scroll_animation_length = 0.1
end
