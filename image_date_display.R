# 2025-09-30
# 画像ファイルから撮影日の情報を取得して、
# 元の画像の右上に表示して保存する関数を作成
# loading packages
library(magick)
library(tidyverse)


image_date_display = 
  function(path) {
    # number of files
    len = length(dir(path = path))
    files = dir(path = path, full.names = TRUE,
                pattern = "JPG")
    
    df = tibble(dir = files)
    
    # loading file information
    img_info = tibble(
      dir = dir(path = path, full.names = TRUE)
    ) |> 
      mutate(info = map(dir, file.info)) |> 
      unnest(info)
    
    rec_date = img_info$mtime |> 
      as.Date()
    
    
    # loading image file
    img = image_read(df$dir)
    
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
    savefile = str_replace(files, ".JPG", "_label.JPG")
    
    for (i in 1:len) {
      image_write(image = img_annt[i], savefile[i])
    }
}

path = "./data/"
image_date_display(path = path)

