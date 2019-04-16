# title: UNIT09B：多軸度比較分析

pacman::p_load(dplyr, ggplot2, readr, plotly, googleVis)
load("data/olist.rdata")
load("data/Z.rdata")

### 使用 `ggplot`
ggplot(segment, aes(x=log(avgItemsSold), y=avgPrice, col=avgScore)) +
  geom_point(aes(size=sqrt(noSellers))) +
  geom_text(aes(label=business_segment), size=3)


### 使用 `ggplotly`
g = ggplot(segment, aes(x=log(avgItemsSold), y=avgPrice, col=avgScore)) +
  geom_point(aes(size=sqrt(noSellers))) +
  geom_text(aes(label=business_segment), size=0.5)
ggplotly(g)


### 使用 `googleVis`
segment$year = 2018
plot( gvisMotionChart(
  segment, "business_segment", "year",
  options=list(width=800, height=600) ) )


