local g = vim.g
local opt = vim.opt

-- Wrap.
opt.showbreak = "󱞩 "

-- Track mouse movements.
opt.mousemoveevent = true

opt.fillchars = { eob = " " } -- Disable end of buffers tildes (~).
opt.listchars = {
  precedes = "«",
  trail = "·",
}

-- Neovide settings.
if g.neovide then
  opt.guifont = "Maple Mono:h9"

  g.neovide_padding_top = 20
  g.neovide_padding_bottom = 20
  g.neovide_padding_left = 20
  g.neovide_padding_right = 20

  g.neovide_normal_opacity = 0.5
  g.neovide_hide_mouse_when_typing = true
  g.neovide_scroll_animation_length = 0.1
end
