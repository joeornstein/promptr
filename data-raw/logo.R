## code to prepare the hex sticker logo

library(hexSticker)
library(ggplot2)
library(here)

img <- magick::image_read(here('data-raw/DALL·E 2024-02-21 05.59.41 - A line drawing of a teleprompter..png'))

img <- magick::image_crop(img, geometry = '1024x1024+0-80')

logo <- sticker(img, s_x = 1.05, s_y = 0.95, s_width = 1.5, s_height=1.5,
                package = 'promptr', p_color = 'black', p_size = 14, p_x = 0.965, p_y=1.42,
                h_color = 'black', h_size = 2, h_fill = 'white')
logo

ggsave(filename = here('data-raw/logo.png'))

usethis::use_logo(here('data-raw/logo.png'))
