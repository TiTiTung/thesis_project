# ================================================================================= #
#         Calculate the gold reserve ratio of central banks around the world       
# ================================================================================= #
require("stringr")
library(magrittr)
library(tidyverse)
library(fGarch)
library(xts)
library(rugarch)
library(rmgarch)
library(lubridate)
library(highcharter)
setwd("/Volumes/GoogleDrive/我的雲端硬碟/Gold (master108.05)/Gold_Code/data")
# ===============================================================
# transform the data type in csv file to numeric, for calculate
# ===============================================================
# dependent variable and Control variable
ALL_variable <- read.csv("Quarterly_aLL_variable.csv", 
                         stringsAsFactors = FALSE, row.names = 1 )

# independent variable
gold_reserve_ratio <- read.csv("Quarterly_gold_reserve_ratio.csv", 
                               stringsAsFactors = FALSE, row.names = 1 )
gold_tonne <- read.csv("Quarterly_gold_tonne.csv", 
                       stringsAsFactors = FALSE, row.names = 1 ) 


# =====================================================
# clear data
# =====================================================
# 2003 - 2011 就不加入Dummy
gold_price <- ALL_variable$GP %>% log() %>% diff() 
variables <- ALL_variable %>% 
  select(EX_US, CPI_US, INFR_US, IGR_US, IR_US, OP_US, 
         VIX, PSI, total_S, total_D) %>% as.matrix() %>% diff() #, PSI, total_S, total_D # diff() cause .[-1,]


# =====================================================
# Determine the boundary of the gold reserve ratio
# =====================================================
threshold <- seq(0.01, 1, by = 0.01)

# vector for LogLikelihood
LLD <- vector(length = length(threshold), mode = "double")
# vector for LogLikelihood
sell_buy <- c()


i=44
for ( i in 66:80) {
  # Use the boundary to distinguish buyside and sellside
  ratio_threshold <- gold_reserve_ratio > threshold[i]
  # column sum
  sell_side <- (ratio_threshold * gold_tonne) %>% map_dbl(sum) %>% diff() 
  # put "!" in front of ratio_threshold for transforming sell_side to buy_side
  buy_side <- ((!ratio_threshold) * gold_tonne) %>% map_dbl(sum) %>% diff() 
  # make a matrix containing sell_side and buy_side for the fefault value
  # mean.model(... , external.regressors = [matrix])
  exreg <- matrix(c(sell_side, buy_side), ncol = 2, 
                  dimnames = list(names(sell_side), 
                                c(str_c("sell",threshold[i]), 
                                  str_c("buy",threshold[i])))) 
  # Save buy and sell side files in every threshold
  #sell_buy <- cbind(sell_buy, exreg) 
  exreg <- cbind(exreg, variables) %>% as.matrix()
  # ============================================================================
  #                                    GARCH       
  # ============================================================================
  ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(2,2), include.mean=TRUE, 
                                       external.regressors = exreg ),  
                       distribution.model="norm")
  fit = ugarchfit(spec = ug_spec, data = gold_price)
  (fit)
  # ============================================================================
  # likelihood
  LLD[i] <-   likelihood(fit)
  
}# End of the loop





# ============================================================================= #
#                                visualization       
# ============================================================================= #
plot(threshold, LLD, type = "l", lwd = 2, main = "Log Likelihood (2003 - 2011)")

Likelihood <- highchart() %>%
  hc_title(text = list("Log Likelihood (2003 - 2016)")) %>%
  hc_subtitle(text = list("Model : GARCH ( 1 , 1 )")) %>%
  hc_xAxis(categories = threshold[1:80],
           plotBands = list(
             list(from = 19, to = 21, color = "#DCDCDC",
                  label = list(text = "??????????????????"))
           ))%>% 
  hc_add_series(LLD[1:80], yAxis = 0, name = "Likelihood") %>%
  hc_add_theme(hc_theme_smpl())

Likelihood %>% 
  hc_yAxis(title = list(text = "Log Likelihood"),
           #minorTickInterval = "auto",
           minorGridLineDashStyle = "LongDashDotDot",
           showFirstLabel = FALSE,
           showLastLabel = FALSE,
           plotBands = list(
             list(from = 0.2, to = 0.4, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")))) 





# ============================================================================= #
# ============================================================================= #
#                     GARCH (threshold = 0.44, Likelihood = 82.85)
# ============================================================================= #
                        i = 21
# ============================================================================= #
  # Use the boundary to distinguish buyside and sellside
  ratio_threshold <- gold_reserve_ratio > threshold[i]
  # column sum
  sell_side <- (ratio_threshold * gold_tonne) %>% map_dbl(sum) %>% diff() 
  # put "!" in front of ratio_threshold for transforming sell_side to buy_side
  buy_side <- ((!ratio_threshold) * gold_tonne) %>% map_dbl(sum) %>% diff() 
  # make a matrix containing sell_side and buy_side for the fefault value
  # mean.model(... , external.regressors = [matrix])
  exreg <- matrix(c(sell_side, buy_side), ncol = 2, 
                  dimnames = list(names(sell_side), 
                                  c(str_c("sell",threshold[i]), 
                                    str_c("buy",threshold[i])))) 
  # Save buy and sell side files in every threshold
  #sell_buy <- cbind(sell_buy, exreg) 
  exreg <- cbind(exreg, variables) %>% as.matrix()
  # GARCH 
  ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(2,2), include.mean=TRUE, 
                                       external.regressors = exreg ),  
                       distribution.model="norm")
  fit = ugarchfit(spec = ug_spec, data = gold_price)
  (fit)

# ============================================================================= #
# Sell_side                    GARCH (threshold = 0.44, Likelihood = 82.85)
# ============================================================================= #
  ratio_threshold <- gold_reserve_ratio > threshold[i]
  # column sum
  sell_side <- (ratio_threshold * gold_tonne) %>% map_dbl(sum) %>% diff() 
  exreg <- matrix(c(sell_side), ncol = 1, 
                  dimnames = list(names(sell_side), 
                                  c(str_c("sell",threshold[i])))) 
  exreg <- cbind(exreg, variables) %>% as.matrix()
  # GARCH       
  ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(2,2), include.mean=TRUE, 
                                       external.regressors = exreg ),  
                       distribution.model="norm")
  fit = ugarchfit(spec = ug_spec, data = gold_price)
  (fit)

# ============================================================================= #
# Buy_side                    GARCH (threshold = 0.44, Likelihood = 82.85)
# ============================================================================= #
  ratio_threshold <- gold_reserve_ratio > threshold[i]
  # column sum
  buy_side <- ((!ratio_threshold) * gold_tonne) %>% map_dbl(sum) %>% diff() 
  # mean.model(... , external.regressors = [matrix])
  exreg <- matrix(c(buy_side), ncol = 1, 
                  dimnames = list(names(sell_side), 
                                  c(str_c("buy",threshold[i])))) 
  exreg <- cbind(exreg, variables) %>% as.matrix()
  # GARCH   
  ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(2,2), include.mean=TRUE, 
                                       external.regressors = exreg ),  
                       distribution.model="norm")
  fit = ugarchfit(spec = ug_spec, data = gold_price)
  (fit)

# ============================================================================= #
# Total                    GARCH (threshold = 0.44, Likelihood = 82.85)
# ============================================================================= #
{

  Total <- ( gold_tonne) %>% map_dbl(sum) %>% diff() 
  # mean.model(... , external.regressors = [matrix])
  exreg <- matrix(c(Total), ncol = 1, dimnames = list(names(sell_side),c("Total"))) 
  exreg <- cbind(exreg, variables) %>% as.matrix()
  # GARCH 
  ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(2,2), include.mean=TRUE, 
                                       external.regressors = exreg ),  
                       distribution.model="norm")
  fit = ugarchfit(spec = ug_spec, data = gold_price)
  (fit)
}
                        
  


# ======================================================================= #
# ======================================================================= #
# =======================      highcharter     ========================== #
# ======================================================================= #
  
#=====================================================
# sell_side and buy_side's total tonnes
#=====================================================

i = 21

  
# Use the boundary to distinguish buyside and sellside
ratio_threshold <- gold_reserve_ratio > threshold[i]
# column sum
sell_side <- (ratio_threshold * gold_tonne) %>% map_dbl(sum) 
buy_side <- ((!ratio_threshold) * gold_tonne) %>% map_dbl(sum) 

exreg <- matrix(c(sell_side, buy_side), ncol = 2, 
                dimnames = list(names(sell_side), 
                                c("sell", "buy"))) %>% as.data.frame()
# ======================================================================= #
# sell and buy
# ======================================================================= #
highchart() %>%
  hc_title(text = list("Total Tonnes of Sell side and Buy side")) %>%
  hc_subtitle(text = list("Threshold : 0.21")) %>%
  hc_yAxis_multiples(list(title = list(text = "Sell side (Tonnes)")),
                     list(title = list(text = "Buy side (Tonnes)"), opposite = TRUE)) %>%
  hc_xAxis(categories = names(sell_side),
           plotBands = list(
             list(from = 0, to = 34, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand")))
  ) %>%
  hc_add_series(exreg$sell, yAxis = 1, name = "Sell side") %>%
  hc_add_series(exreg$buy, yAxis = 0, name = "Buy side") %>%
  #hc_add_series((exreg$buy+exreg$sell), yAxis = 0, name = "Buy side") %>%
  hc_add_theme(hc_theme_smpl())

# ======================================================================= #
# sell and buy and gold price
# ======================================================================= #
highchart() %>%
  hc_title(text = list("Gold price and Total Tonnes of Sell side and Buy side")) %>%
  hc_subtitle(text = list("Threshold : 0.21")) %>%
  hc_yAxis_multiples(create_yaxis(3, height = c(2, 2, 2), turnopposite = TRUE)) %>%
  hc_xAxis(categories = names(sell_side)) %>%
  hc_add_series(ALL_variable$GP, yAxis = 0, name = "Gold Price" , type = "area") %>%
  hc_add_series(exreg$sell, yAxis = 1, name = "Sell side", type = "area") %>%
  hc_add_series(exreg$buy, yAxis = 2, name = "Buy side", type = "area") %>%
  #hc_add_series((exreg$buy+exreg$sell), yAxis = 0, name = "Buy side") %>%
  hc_add_theme(hc_theme_smpl())


#=====================================================
# Gold total demand and Central Bank’s Gold Holdings
#=====================================================
i=44
# Use the boundary to distinguish buyside and sellside
ratio_threshold <- gold_reserve_ratio > threshold[i]
# column sum
sell_side <- (ratio_threshold * gold_tonne) %>% map_dbl(sum)
Total <- ( gold_tonne) %>% map_dbl(sum)
# mean.model(... , external.regressors = [matrix])
exreg <- matrix(c(Total), ncol = 1, dimnames = list(names(sell_side),c("Total"))) 
exreg <- exreg[-1,]
exreg <- cbind(exreg, variables) %>% as.matrix() %>% as.data.frame()



highchart() %>%
  hc_title(text = list("Central Bank's Gold Holdings and Gold Price")) %>%
  hc_subtitle(text = list("Source: World Gold Council")) %>%
  hc_yAxis_multiples(list(title = list(text = "CB's gold holdings (Tonnes)")),
                     list(title = list(text = "Gold Price"), opposite = TRUE)) %>%
  hc_xAxis(categories = rownames(exreg)) %>%
  hc_add_series(exreg$exreg, yAxis = 0, name = "CB's gold holdings", 
                color = "#828282") %>%
  hc_add_series(ALL_variable$GP, yAxis = 1, name = "Gold Price") %>%
  hc_add_theme(hc_theme_smpl())
