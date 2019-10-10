# ============================================================================= #
# ============================================================================= #
#                                     GARCH 
# ============================================================================= #
# ============================================================================= #
SST <- (gold_price - mean(gold_price))^2 %>% sum()
SSR <- (fit@fit$fitted.values - mean(gold_price))^2 %>% sum()
SSE <- (gold_price - fit@fit$fitted.values)^2 %>% sum() # 等於 fit@fit$residuals
sse <- (fit@fit$residuals)^2 %>% sum()

# ============================================================================= #
#                                     R-squared 
# ============================================================================= #
SSR/SST
1-(SSE/SST)

# ============================================================================= #
#                                   Adjusted  R-squared 
# ============================================================================= #
SST_Adj <- (gold_price - mean(gold_price))^2 %>% sum() /
  (length(gold_price) - 1)
SSE_Adj <- (gold_price - fit@fit$fitted.values)^2 %>% sum() / 
  (length(gold_price) - 11)

SSR_Adj / SST_Adj
1-(SSE_Adj / SST_Adj)







# ============================================================================= #
#                                     test         
# ============================================================================= #
# model
# data = iris
model <- lm(formula= Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width,
            data=iris)

summary(model)

## R-squared:  0.8586,	Adjusted R-squared:  0.8557



# ============================================================================= #
# R-squared 
SST_1 <- ( iris$Sepal.Length - mean(iris$Sepal.Length) )^2 %>% sum
SSR_1 <- 
SSE_1 <- (model$residuals)^2 %>% sum

1-(SSE_1 / SST_1)

## [1] 0.8586117



# ============================================================================= #
# Adjusted  R-squared 
# SSRes/(n−p−1) / SSTotal/(n−1)
# n = number of samples
# p = number of parameters

SST_2 <- ( iris$Sepal.Length - mean(iris$Sepal.Length) )^2 %>% sum /
  (nrow(iris) - 1)

SSE_2 <- (model$residuals)^2 %>% sum /
  (nrow(iris) - 4) # p = number of parameters


1-(SSE_2/SST_2)

## [1] 0.8557065



