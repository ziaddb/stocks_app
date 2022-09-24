get_stock_recent_plot<-function(stock_name,slider)
{
   fig_list <- NULL
   stock <- getSymbols(as.character(stock_name), src = "yahoo", auto.assign = FALSE,) 
   bbands <- BBands(stock[,4],s.d=2)
   df_stock <- data.frame(tail(stock,n = slider))
   df_bbands <- data.frame(tail(bbands,n = slider))
   df_stock$time_line <- as.Date(row.names(df_stock))
   df_bbands$time_line <- as.Date(row.names(df_bbands))
   fig <- ggplot(df_stock,aes(x =time_line , y=df_stock[,4]) )+geom_point()+geom_line(aes(y=df_bbands$up)) +geom_line(aes(y=df_bbands$dn)) 
   fig <- fig+geom_line(aes(y=df_bbands$mavg)) +labs(y ="Price ($)", x = "Day")

  return(fig)
}


monthly_returns_plot <- function(ticker, base_year)
{
  
  df_stock <- monthly_returns(ticker, base_year)
  fig <- plot_ly(x = df_stock$time_line,y=df_stock[,1],type = 'scatter', mode = 'lines+markers')
  
  return(fig)
}


monthly_returns <- function(ticker, base_year)
{
  # Obtain stock price data from Yahoo! Finance
  stock <- getSymbols(ticker, src = "yahoo", auto.assign = FALSE) 
  # Remove missing values
  stock <- na.omit(stock)
  # Keep only adjusted closing stock prices
  stock <- stock[, 6]
  # Confine our observations to begin at the base year and end at the last available trading day
  horizon <- paste0(as.character(base_year), "/", as.character(Sys.Date()))
  stock <- stock[horizon]
  # Calculate monthly arithmetic returns
  data <- periodReturn(stock, period = "monthly", type = "arithmetic")
  
  df_data <- data.frame(data)
  
  df_data$time_line <- as.Date(rownames(df_data))
  
  return(df_data)
}


