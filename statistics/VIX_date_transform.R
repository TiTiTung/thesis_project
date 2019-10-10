
VIX <- read.csv("VIX.csv", stringsAsFactors = FALSE) 


x <- VIX$Date[1:1004] %>% ymd
c <- VIX$Date[1005:4774] %>% mdy
cc <- append(x,c)
VIX$Date <- cc


VIX$Month <- vix$Date
vix <- VIX
vix$Date <- vix$Date %>% format("%Y-%m")

vix2 <- vix %>% 
  group_by(Date) %>% 
  summarise(VIX_mean = mean(VIX.Close)) 

write.csv(vix2, "VIX_Monthly.csv")

write.csv(VIX, "VIX_AllData.csv")




