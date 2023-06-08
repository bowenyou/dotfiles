local colorscheme = "tokyonight"
local style = colorscheme .. "-night"

local color_ok, color = pcall(require, colorscheme)
if not color_ok then
  vim.notify("colorscheme " .. colorscheme .. "not found!")
end

color.setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. style)

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. "-" .. style .. "not found!")
  return
end
