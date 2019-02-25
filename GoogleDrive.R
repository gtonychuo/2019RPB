library("googledrive")
drive_auth()

### 
RPB = "2019 程式、機率與商務/2019RPB/unit01/"
d1 = drive_ls(paste0(RPB, "DC認證：R語言導論"))
(name1 = gsub("(_|＿).*", "", d1$name))
d2 = drive_ls(paste0(RPB, "DC認證：資料框整理技巧"))
(name2 = gsub("(_|＿).*", "", d2$name))
setdiff(name1, name2)
setdiff(name2, name1)

###
library(googlesheets)
library(dplyr)
(titles = gs_ls()$sheet_title)
q1 = gs_title("期初問卷 (回應)") %>% gs_read(ws=1)
q2 = gs_title("期初問卷 (加簽) (回應)") %>% gs_read(ws=1)
identical(names(q1)[-24], names(q2))

q = rbind(q1[,-24], q2) %>% data.frame
names(q) = c(
  "time", "name", "dept", "grade", "id",
  "email", "tel", "gsuite", "github", "rpubs",
  "datacamp", "edx", "coursera",
  "uR", "uRstudio", "uDplyr", "uMarkdown", 
  "uRpubs", "uGithub", "uPython", 
  "uDatacamp", "uEdx", "uCoursera"
  ) 
q$enroll = c(rep(T, nrow(q1)), rep(F, nrow(q2)))
sum(duplicated(q$id))
q = q[!duplicated(q$id),]
q$dc1 = q$name %in% name1
q$dc2 = q$name %in% name2
c(sum(q$dc1), sum(q$dc2))
sum(q$dc1 & q$dc2)
setdiff(name1, q$name)
setdiff(name2, q$name)

mean(q$uR == "是") 
table(q$dept)
sum(grepl("財|金", q$dept))
sum(grepl("資", q$dept))
sum(grepl("企", q$dept))
table(grepl("碩|所", q$dept))
table(grepl("企", q$dept), grepl("碩|所", q$dept))
table(q$grade)

