#=====================================================
# ???????????????
#=====================================================
library(highcharter)
require("stringr")
library(lubridate)
setwd("/Volumes/GoogleDrive/我的雲端硬碟/Gold (master108.05)/Gold_Code/data")

ALL_variable <- read.csv("Gold_Variables_Dummy(Data).csv", stringsAsFactors = FALSE) 
# ALL_variable <- ALL_variable[1:108,]



ALL_variable$date %<>% ymd %>% format("%Y-%m")



#sret <- xts(ALL_variable, as.Date(ALL_variable$date))

#=====================================================
# Gold price
#=====================================================
highchart() %>%
  hc_title(text = list("Monthly Gold price")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold price"))) %>%
  hc_xAxis(categories = ALL_variable$date,
           plotBands = list(
             list(from = 69, to = 103, color = "#DCDCDC",
                  label = list(text = "??????????????????")),
             list(from = 45, to = 61, color = "#DCDCDC",
                  label = list(text = "This is a plotBand"))
           )) %>%
  #hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI_US") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold Price",color = "red" ) %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# EX 
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and US Exchange Rate")) %>%
  hc_subtitle(text = list("Source: World Gold Council, IFS")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "Exchange Rate"), 
                          opposite = TRUE,
                          minorTickInterval = "auto",
                          minorGridLineDashStyle = "LongDashDotDot",
                          plotBands = list(
                            list(from = 1.478, to = 1.644, color = "rgba(100, 0, 0, 0.1)",
                                 label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$EX_US, yAxis = 1, name = "EX_US") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# Oil Price
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and Oil Price")) %>%
  hc_subtitle(text = list("Source: World Gold Council, IFS")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "Oil Price"), 
                          opposite = TRUE,
                          plotBands = list(
                            list(from = 1.478, to = 1.644, color = "rgba(100, 0, 0, 0.1)",
                                 label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$OP_US, yAxis = 1, name = "Oil Price") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# CPI
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and US CPI")) %>%
  hc_subtitle(text = list("Source: World Gold Council, IFS")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "CPI"), 
                          opposite = TRUE,
                          plotBands = list(
                            list(from = 1.478, to = 1.644, color = "rgba(100, 0, 0, 0.1)",
                                 label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# US Income Growth Rate
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and US Income Growth Rate")) %>%
  hc_subtitle(text = list("Source: World Gold Council, IFS")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "Income Growth Rate"), 
                          opposite = TRUE,
                          plotBands = list(
                            list(
                                 label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$IGR_US, yAxis = 1, name = "IGR_US") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())

#=====================================================
# US Inflation Change Rate
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and US Inflation Change Rate")) %>%
  hc_subtitle(text = list("Source: World Gold Council, IFS")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "Inflation Change Rate"), 
                          opposite = TRUE,
                          minorTickInterval = "auto",
                          minorGridLineDashStyle = "LongDashDotDot",
                          plotBands = list(
                            list(from = 0.96, to = 4.68, color = "rgba(100, 0, 0, 0.1)",
                                 label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$INFR_US, yAxis = 1, name = "INFR_US") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# US interest rate
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and US Interest Rate")) %>%
  hc_subtitle(text = list("Source: World Gold Council, IFS")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "Interest Rate"), 
                          opposite = TRUE,
                          plotBands = list(
                            list(
                                 label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$IR_US, yAxis = 1, name = "IR_US") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# VIX
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and VIX")) %>%
  hc_subtitle(text = list("Source: World Gold Council, CBOE")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "VIX"), 
                          opposite = TRUE,
                          plotBands = list(
                            list(
                              label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$VIX, yAxis = 1, name = "VIX") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


#=====================================================
# PSI
#=====================================================
highchart() %>%
  hc_title(text = list("Gold Price and World Political Stability Index")) %>%
  hc_subtitle(text = list("Source: World Gold Council, WGI")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "PSI"), 
                          opposite = TRUE,
                          plotBands = list(
                            list(
                              label = list(text = "This is a plotBand"))))) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$PSI, yAxis = 1, name = "PSI") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price") %>%
  hc_add_theme(hc_theme_google())


# ======================================================================= #
# ======================================================================= #

#=====================================================
# Gold price and Gold total demand
#=====================================================
highchart() %>%
  hc_title(text = list("Gold price and Gold total demand")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold price")),
                     list(title = list(text = "Tonnes"), opposite = TRUE)) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$total_D, yAxis = 1, name = "Gold Demand", 
                type = "area", color = "#DCDCDC") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold Price") %>%
  hc_add_theme(hc_theme_gridlight())




#=====================================================
# Gold price and Gold total supply
#=====================================================
highchart() %>%
  hc_title(text = list("Gold price and Gold total supply")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "Gold Price")),
                     list(title = list(text = "Tonnes"), opposite = TRUE)) %>%
  hc_xAxis(categories = ALL_variable$date) %>%
  hc_add_series(ALL_variable$total_S, yAxis = 1, name = "Gold Supply", 
                type = "area", color = "#DCDCDC") %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold price",color = "red" ) %>%
  hc_add_theme(hc_theme_gridlight())




