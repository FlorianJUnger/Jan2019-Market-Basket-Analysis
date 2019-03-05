## Market Basket Analysis 
## Jorma, Deniz, Florian 
## 09/01/2019
## Preparing datasets

### Packages

pacman::p_load(readr, caret,plotly, ggplot2, labeling, promises, 
               ggridges, doParallel, mlbench, inum, e1071, 
               corrplot, ggpubr, rpart, rpart.plot, Matrix,
               gbm, boot, arules, arulesViz, dplyr, RColorBrewer)

### Github

current_path = rstudioapi::getActiveDocumentContext()$path #save working directory
setwd(dirname(current_path))
setwd("..")

### Load data

en.tr <- read.transactions(
  "C:/Users/Dell/Desktop/Ubiqum Data Analytics/Data Analytics II/Market Basket Analysis/Jan2019-Market-Basket-Analysis/datasets/ElectronidexTransactions2017.csv", 
  format = "basket", sep = ",", rm.duplicates = TRUE)

en.types <- read.csv(
  "C:/Users/Dell/Desktop/Ubiqum Data Analytics/Data Analytics II/Market Basket Analysis/Jan2019-Market-Basket-Analysis/datasets/ElectronidexProductTypes.csv",
  header = TRUE)

bw <- read.csv(
  "C:/Users/Dell/Desktop/Ubiqum Data Analytics/Data Analytics II/Market Basket Analysis/Jan2019-Market-Basket-Analysis/datasets/existing.csv",
  header = TRUE)

bwnew <- read.csv(
  "C:/Users/Dell/Desktop/Ubiqum Data Analytics/Data Analytics II/Market Basket Analysis/Jan2019-Market-Basket-Analysis/datasets/new.csv",
  header = TRUE)
