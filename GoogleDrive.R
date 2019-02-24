library("googledrive")
drive_auth()

### Unit01 作業
RPB = "2019 程式、機率與商務/2019RPB/unit01/"
d1 = drive_ls(paste0(RPB, "DC認證：R語言導論"))
name1 = gsub("(_|＿).*", "", d1$name)
d2 = drive_ls(paste0(RPB, "DC認證：資料框整理技巧"))
name2 = gsub("(_|＿).*", "", d2$name)
setdiff(name1, name2)

