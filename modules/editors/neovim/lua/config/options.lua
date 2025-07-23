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
  opt.guifont = "Maple Mono:h9"

  g.neovide_opacity = 0.5
  g.neovide_hide_mouse_when_typing = true
  g.neovide_scroll_animation_length = 0.1
end
