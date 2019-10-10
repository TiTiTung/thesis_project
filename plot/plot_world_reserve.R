library(highcharter)
setwd("/Volumes/GoogleDrive/我的雲端硬碟/Gold (master108.05)/Gold_Code/data")
zz <- read.csv("Top10_reserve_rate.csv", stringsAsFactors = FALSE )
#write.csv(zzz, "Top10_reserve_rate.csv")




highchart() %>%
  hc_title(text = list("Gold Reserves")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Reserves")),
                     list(title = list(text = NULL), opposite = TRUE)) %>%
  hc_xAxis(categories = zz$date,
           plotBands = list(
             list(from = 69, to = 103, color = "#DCDCDC",
                  label = list(text = "??????????????????"))
           )) %>%
  hc_add_series(zz$China, yAxis = 0, name = "China") %>%
  hc_add_series(zz$France, yAxis = 0, name = "France") %>%
  hc_add_series(zz$Germany, yAxis = 0, name = "Germany" ) %>%
  hc_add_series(zz$India, yAxis = 0, name = "India") %>%
  hc_add_series(zz$Japan, yAxis = 0, name = "Japan" ) %>%
  hc_add_series(zz$Italy, yAxis = 0, name = "Italy") %>%
  hc_add_series(zz$Netherlands, yAxis = 0, name = "Netherlands" ) %>%
  hc_add_series(zz$Russia, yAxis = 0, name = "Russia") %>%
  hc_add_series(zz$Switzerland, yAxis = 0, name = "Switzerland") %>%
  hc_add_series(zz$Taiwan, yAxis = 0, name = "Taiwan" ) %>%
  hc_add_series(zz$United.States, yAxis = 0, name = "United States") %>%
  hc_add_theme(hc_theme_google())

#=====================================================
# over 0.3
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Reserves")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Reserves")),
                     list(title = list(text = NULL), opposite = TRUE)) %>%
  hc_xAxis(categories = zz$date,
           plotBands = list(
             list(from = 35, to = 47, color = "#DCDCDC",
                  label = list(text = "jdsknvdskjv"))
             )) %>%
  hc_add_series(zz$France, yAxis = 0, name = "France") %>%
  hc_add_series(zz$Germany, yAxis = 0, name = "Germany" ) %>%
  hc_add_series(zz$Italy, yAxis = 0, name = "Italy") %>%
  hc_add_series(zz$Netherlands, yAxis = 0, name = "Netherlands" ) %>%
  hc_add_series(zz$United.States, yAxis = 0, name = "United States") %>%
  hc_add_theme(hc_theme_smpl())

#=====================================================
# under 0.3
#=====================================================

highchart() %>%
  hc_title(text = list("Gold Reserves")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Reserves")),
                     list(title = list(text = NULL), opposite = TRUE)) %>%
  hc_xAxis(categories = zz$date,
           plotBands = list(
             list(from = 35, to = 47, color = "#DCDCDC",
                  label = list(text = "This is a plotBand"))
           ))%>% 
  #hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI_US") %>%
  hc_add_series(zz$China, yAxis = 0, name = "China") %>%
  hc_add_series(zz$India, yAxis = 0, name = "India") %>%
  hc_add_series(zz$Japan, yAxis = 0, name = "Japan" ) %>%
  hc_add_series(zz$Russia, yAxis = 0, name = "Russia") %>%
  #hc_add_series(zz$Switzerland, yAxis = 0, name = "Switzerland") %>%
  hc_add_series(zz$Taiwan, yAxis = 0, name = "Taiwan" ) %>%
  hc_add_theme(hc_theme_smpl())

#=====================================================
# Switzerland
#=====================================================

Switzerland <- highchart() %>%
  hc_title(text = list("Gold Reserves")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_xAxis(categories = zz$date)%>% 
  #hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI_US") %>%
  hc_add_series(zz$China, yAxis = 0, name = "China", color = "#DCDCDC") %>%
  hc_add_series(zz$India, yAxis = 0, name = "India", color = "#DCDCDC") %>%
  hc_add_series(zz$Italy, yAxis = 0, name = "Italy", color = "#DCDCDC" ) %>%
  hc_add_series(zz$Japan, yAxis = 0, name = "Japan", color = "#DCDCDC" ) %>%
  hc_add_series(zz$Russia, yAxis = 0, name = "Russia", color = "#DCDCDC") %>%
  hc_add_series(zz$Taiwan, yAxis = 0, name = "Taiwan", color = "#DCDCDC" ) %>%
  hc_add_series(zz$France, yAxis = 0, name = "France", color = "#DCDCDC" ) %>%
  hc_add_series(zz$Germany, yAxis = 0, name = "Germany", color = "#DCDCDC" ) %>%
  hc_add_series(zz$Netherlands, yAxis = 0, name = "Netherlands", color = "#DCDCDC" ) %>%
  hc_add_series(zz$United.States, yAxis = 0, name = "United States", color = "#DCDCDC" ) %>%
  hc_add_series(zz$Switzerland, yAxis = 0, name = "Switzerland") %>%
  hc_legend(align = "left", verticalAlign = "top",
            layout = "vertical", x = 0, y = 100) %>%
  hc_add_theme(hc_theme_smpl())

Switzerland %>% 
  hc_yAxis(title = list(text = "Gold Reserves"),
           minorTickInterval = "auto",
           minorGridLineDashStyle = "LongDashDotDot",
           showFirstLabel = FALSE,
           showLastLabel = FALSE,
           plotBands = list(
             list(from = 0.2, to = 0.4, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")))) 

#=====================================================
# threshold = 0.65 
#=====================================================

threshold_0.21 <- highchart() %>%
  hc_title(text = list("Gold Reserves")) %>%
  hc_subtitle(text = list("Threshold : 0.65")) %>%
  hc_xAxis(categories = zz$date,
           plotBands = list(
             list(from = 23, to = 25, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")),
             list(from = 37, to = 39, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")),
             list(from = 52, to = 54, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")),
             list(from = 62, to = 64, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")))
  )%>% 
  #hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI_US") %>%
  hc_add_series(zz$Italy, yAxis = 0, name = "Italy", color = "#828282" ) %>%
  hc_add_series(zz$France, yAxis = 0, name = "France", color = "#828282" ) %>%
  hc_add_series(zz$Germany, yAxis = 0, name = "Germany", color = "#828282" ) %>%
  hc_add_series(zz$United.States, yAxis = 0, name = "United States", color = "#828282") %>%
  hc_add_theme(hc_theme_smpl())

threshold_0.21 %>% 
  hc_yAxis(title = list(text = "Gold Reserves"),
           minorTickInterval = "auto",
           minorGridLineDashStyle = "LongDashDotDot",
           showFirstLabel = FALSE,
           showLastLabel = FALSE,
           plotLines = list(
             list(label = list(text = "This is a plotLine"),
                  color = "#CD3333",
                  width = 2.5,
                  value = 0.65))) 

#=====================================================
# threshold = 0.21
#=====================================================

threshold_0.21 <- highchart() %>%
  hc_title(text = list("Gold Reserves")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_xAxis(categories = zz$date,
           plotBands = list(
             list(from = 20, to = 38, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")))
           )%>% 
  #hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI_US") %>%
  hc_add_series(zz$Italy, yAxis = 0, name = "Italy", color = "#828282" ) %>%
  hc_add_series(zz$France, yAxis = 0, name = "France", color = "#828282" ) %>%
  hc_add_series(zz$Germany, yAxis = 0, name = "Germany", color = "#828282" ) %>%
  hc_add_series(zz$Netherlands, yAxis = 0, name = "Netherlands", color = "#828282" ) %>%
  hc_add_series(zz$United.States, yAxis = 0, name = "United States", color = "#828282" ) %>%
  hc_add_series(zz$Switzerland, yAxis = 0, name = "Switzerland", color = "#828282" ) %>%
  hc_add_series(zz$China, yAxis = 0, name = "China", color = "#D3D3D3") %>%
  hc_add_series(zz$India, yAxis = 0, name = "India", color = "#D3D3D3") %>%
  hc_add_series(zz$Japan, yAxis = 0, name = "Japan", color = "#D3D3D3" ) %>%
  hc_add_series(zz$Russia, yAxis = 0, name = "Russia", color = "#D3D3D3") %>%
  hc_add_series(zz$Taiwan, yAxis = 0, name = "Taiwan", color = "#D3D3D3" ) %>%
  hc_legend(align = "left", verticalAlign = "top",
            layout = "vertical", x = 0, y = 100) %>%
  hc_add_theme(hc_theme_smpl())

threshold_0.21 %>% 
  hc_yAxis(title = list(text = "Gold Reserves"),
           minorTickInterval = "auto",
           minorGridLineDashStyle = "LongDashDotDot",
           showFirstLabel = FALSE,
           showLastLabel = FALSE,
           plotLines = list(
             list(label = list(text = "This is a plotLine"),
                  color = "#CD3333",
                  width = 2,
                  value = 0.21))) 

