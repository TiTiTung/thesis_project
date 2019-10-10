library(highcharter)
library(dplyr)
library(purrr)
setwd("/Volumes/GoogleDrive/我的雲端硬碟/Gold (master108.05)/Gold_Code/data")

df <- data_frame(
  name = c("United States", "Germany", "France", "Italy", "Switzerland", 
           "Netherlands","Japan", "China",
           "2018",
           "Russia",
           "","","","","","","",
           "India"),
  lat = c(37, 55,  46, 41, 46, 52, 36, 35,35, 61,61,61,61,61,61,61,61, 20),
  lon = c(-95, -10, 2, 12, 8, 5, 138, 95,110, 60,70,80,90,100,110,120,130, 78),
  z = c(8134.67 , 3406.77   , 2451.84  , 2435.41   , 1040.10   , 
        621.44  ,  765.22 , 1054.09,1800  , 700,800,900,1000,1200,1460,1680,1900 ,557.75 ),
  color = colorize(c(200,200,200,200,200,200,200,600,500,seq(800,100,-100),200))
)



hcmap( showInLegend = FALSE) %>% 
  hc_add_series(data = df, type = "mapbubble", name = "Country", maxSize = '20%',
                dataLabels = list(enabled = TRUE, format = '{point.name}'),
                ) %>% 
  hc_title(text = "Tonnes of gold on<span style=\"color:#e5b13a\"> 2011 - 2018 </span>"
           ,useHTML = TRUE)







# =====================================================
# 2003 - 2007
# =====================================================
df <- data_frame(
  name = c("United States", "Germany", "France", "Italy", "Switzerland", 
           "Netherlands","Japan", "China", "Portugal"),
  lat = c(37, 55,  46, 41, 46, 52, 36, 35, 39),
  lon = c(-95, -10, 2, 12, 8, 5, 138, 104, -8),
  z = c(8134.67 , 3445.80 , 3024.70 , 2451.84 , 1846.18 , 
        842.56 ,  765.22 , 599.98 , 561.97 ),
  color = colorize(z)
)

# =====================================================
# 2008 - 2009
# =====================================================
df <- data_frame(
  name = c("United States", "Germany", "France", "Italy", "Switzerland", 
           "Netherlands","Japan", "China", "Russia", "Taiwan"),
  lat = c(37, 55,  46, 41, 46, 52, 36, 35, 61, 23),
  lon = c(-95, -10, 2, 12, 8, 5, 138, 104, 105, 120),
  z = c(8134.67 , 3417.37  , 2568.35 , 2451.84  , 1113.20  , 
        621.44  ,  765.22 , 599.98 , 457.00, 423.63),
  color = colorize(z)
)

# =====================================================
# 2010 - 2011
# =====================================================
df <- data_frame(
  name = c("United States", "Germany", "France", "Italy", "Switzerland", 
           "Netherlands","Japan", "China", "Russia", "India"),
  lat = c(37, 55,  46, 41, 46, 52, 36, 35, 61, 20),
  lon = c(-95, -10, 2, 12, 8, 5, 138, 104, 105, 78),
  z = c(8134.67 , 3406.77   , 2451.84  , 2435.41   , 1040.10   , 
        621.44  ,  765.22 , 1054.09  , 750, 557.75 ),
  color = colorize(z)
)

# =====================================================
# 2011 - 2015
# =====================================================
df <- data_frame(
  name = c("United States", "Germany", "France", "Italy", "Switzerland", 
           "Netherlands","Japan", "China",
           "Russia",
           "","","","",
           "India"),
  lat = c(37, 55,  46, 41, 46, 52, 36, 35, 61,61,61,61,61, 20),
  lon = c(-95, -10, 2, 12, 8, 5, 138, 104, 70,80,90,100,110, 78),
  z = c(8134.67 , 3406.77   , 2451.84  , 2435.41   , 1040.10   , 
        621.44  ,  765.22 , 1054.09  , 700,800,900,1000,1200 ,557.75 ),
  color = colorize(c(200,200,200,200,200,200,200,200,seq(500,100,-100),200))
)
