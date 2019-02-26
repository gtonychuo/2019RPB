library("googledrive")
# drive_auth()

### 
RPB = "2019 程式、機率與商務/2019RPB/unit01/"
d1 = drive_ls(paste0(RPB, "DC認證：R語言導論"))
(name1 = gsub("(_|＿).*", "", d1$name))
d2 = drive_ls(paste0(RPB, "DC認證：資料框整理技巧"))
(name2 = gsub("(_|＿|-).*", "", d2$name))
setdiff(name1, name2)
setdiff(name2, name1)

###
library(googlesheets)
# library(dplyr)
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
setdiff(q$name, name1)

s120 = c("黃柏融", name1)
setdiff(s120, q$name)
setdiff(q$name, s120)

q = rbind(q, q[q$name == "王欣",])
q[nrow(q),"name"] = "黃柏融"
q[nrow(q),"uGithub"] = "否"
q[nrow(q),"enroll"] = FALSE
q119 = subset(q, name %in% s120)

table(q119$enroll)
ta = read.table('clipboard',sep='\t',stringsAsFactors=F)[,1]
ta = c(ta, read.table('clipboard',sep='\t',stringsAsFactors=F)[,1])
q119$ta = q119$name %in% ta
table(q119$enroll,q119$ta)
setdiff(ta, q119$name)
q119$uR =  q119$uR == "是"
q = subset(q119, !ta)
table(enroll = q$enroll, R = q$uR)
table( substr(q$id,1,1) )
q$level = substr(q$id,1,1)
q$level[substr(q$id,1,1) == 'b'] = 'B' 
q$level[substr(q$id,1,1) %in% c('m','Ｍ','N','D')] = 'M' 
table(q$level)
qE = subset(q, enroll)
qA = subset(q, !enroll)
table(qE$uR, qE$level)
table(qA$uR, qA$level)

write.table(qE, file="clipboard", sep="\t", row.names=F)
write.table(qA, file="clipboard", sep="\t", row.names=F)

save(d1,d2,q1,q2,qA,qE,q119,ta,file="grouping.rdata")


