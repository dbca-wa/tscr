# -----------------------------------------------------------------------------#
# Hex sticker
#
# remotes::install_github("GuangchuangYu/hexSticker")
library(hexSticker)
library(showtext)
sysfonts::font_add_google("Knewave", "knewave")
logo <- here::here("man", "figures", "tscr_logo.png")
tscr <- here::here("man", "figures", "threatened_things.png")
darkred <- "#a50b0b"
darkblue <- "#000321"
# logo s_, text p_, bg h_
hexSticker::sticker(
  tscr,
  asp = 0.684,
  s_x = 1.0, s_y = 1.05, s_width = 1, # s_height = 0.1,
  package = "", p_x = 1, p_y = 0.5, p_size = 32,
  # p_family = "knewave",
  p_color = darkred,
  h_fill = darkblue, h_color = darkred,
  url = "dbca-wa.github.io/tscr",
  u_size = 6, u_color = "#ffffff", u_x = 1.05, u_y = 0.1,
  white_around_sticker = T,
  filename = logo
)
