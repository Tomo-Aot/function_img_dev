# 2025-09-30
# 画像ファイルから撮影日の情報を取得して、
# 元の画像の右上に表示して保存する関数を作成
# loading packages
library(magick)
library(tidyverse)


image_date_display = 
  function(path) {
    # loading file information
    info = file.info(path)
    rec_date = info$mtime |> 
      as.Date()
    
    # number of files
    len = length(dir(path = path))
    files = dir(path = path, full.names = TRUE)
    df = tibble(dir = files)
    
    # loading image file
    img = image_read(path)
    
    img_annt = image_annotate(
      img, 
      text = rec_date,
      size = 200,
      color = "white",
      font = "Noto Sans",
      boxcolor = "darkgray",
      gravity = "northeast"
    )
    
    # SAVE IMAGE
    savefile = str_replace(path, ".JPG", "_label.JPG")
    
    image_write(image = img_annt, path = savefile)
}

path = "./data/"

for (i in 1:len) {
  image_date_display(path = df$dir)
}

