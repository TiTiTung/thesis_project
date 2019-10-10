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
# ===============================================================
# transform the data type in csv file to numeric, for calculate
# ===============================================================
# dependent variable
# Control variable
ALL_variable <- read.csv("Gold_Variables_Dummy.csv", stringsAsFactors = FALSE) 


# independent variable
foreign_exchange <- read.csv("FEX_102.csv", stringsAsFactors = FALSE)
troy_ounce <- read.csv("Gold_TO_102.csv", stringsAsFactors = FALSE)
US_dollar <- read.csv("Gold_dollar_102.csv", stringsAsFactors = FALSE)

# =====================================================
# put the country name into "rowname"
# =====================================================
row.names(ALL_variable) <- ALL_variable$X
ALL_variable %<>% .[,-1]

row.names(foreign_exchange) <- foreign_exchange$X
foreign_exchange %<>% .[,-1]

row.names(troy_ounce) <- troy_ounce$X
troy_ounce %<>% .[,-1]

row.names(US_dollar) <- US_dollar$X
US_dollar %<>% .[,-1]

# =====================================================
# clear data
# =====================================================
# 2003 - 2011 就不加入Dummy
gold_price <- ALL_variable$GP 
variables <- ALL_variable %>% 
  select(EX_US, CPI_US, INFR_US, IGR_US, IR_US, OP_US, 
         VIX, PSI, total_S, total_D) %>% .[-1,]#, PSI, total_S, total_D


# =====================================================
# boundary of the gold reserve ratio
# =====================================================
gold_reserve_ratio <- US_dollar / foreign_exchange

# =====================================================
# Determine the boundary of the gold reserve ratio
# =====================================================
Frontier <- seq(0.01, 1, by = 0.01)

# vector for LogLikelihood
LLD <- vector(length = length(Frontier), mode = "double")
# vector for LogLikelihood
sell_buy <- c()



for ( i in seq_along(Frontier)) {
  # Use the boundary to distinguish buyside and sellside
  ratio_Frontier <- gold_reserve_ratio > Frontier[i]    
  # column sum
  sell_side <- (ratio_Frontier * troy_ounce) %>% map_dbl(sum) %>% 
    .[37:204] 
  # put "!" in front of ratio_Frontier for transforming sell_side to buy_side
  buy_side <- ((!ratio_Frontier) * troy_ounce) %>% map_dbl(sum)%>% 
    .[37:204]  
  
  # make a matrix containing sell_side and buy_side for the fefault value
  # mean.model(... , external.regressors = [matrix])
  exreg <- matrix(c(sell_side, buy_side), ncol = 2, 
                  dimnames = list(names(sell_side), 
                                  c(str_c("sell",Frontier[i]), 
                                    str_c("buy",Frontier[i])))) 
  # Save buy and sell side files in every Frontier
  #exreg <- cbind(exreg, variables) %>% as.matrix()
  # ============================================================================
  #                                    GARCH       
  # ============================================================================
  ug_spec = ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1,1)), 
                       mean.model=list(armaOrder=c(1,1), include.mean=TRUE, 
                                       external.regressors = exreg ),  
                       distribution.model="norm")
  fit = ugarchfit(spec = ug_spec, data = gold_price)
  likelihood(fit)
  # ============================================================================
  # likelihood
  sell_buy <- cbind(sell_buy, exreg)
  LLD[i] <-   likelihood(fit)
  
}# End of the loop


plot(Frontier, LLD, type = "l", lwd = 2, main = "Log Likelihood (2003 - 2011)")



highchart() %>%
  hc_title(text = list("Log Likelihood")) %>%
  hc_subtitle(text = list("Source: WGC, IFS  (2003 - 2011)")) %>%
  hc_yAxis_multiples(list(title = list(text = "Log Likelihood")),
                     list(title = list(text = NULL), opposite = TRUE)) %>%
  hc_xAxis(categories = Frontier,
           plotBands = list(
             list(from = 8, to = 10, color = "#DCDCDC",
                  label = list(text = ""))
           )) %>%
  #hc_add_series(ALL_variable$CPI_US, yAxis = 1, name = "CPI_US") %>%
  hc_add_series(LLD, yAxis = 0, name = "Log Likelihood",color = "" , showInLegend = FALSE) %>%
  hc_add_theme(hc_theme_google())



