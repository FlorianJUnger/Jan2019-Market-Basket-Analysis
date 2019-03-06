source("Step_4_Split_B2B_and_transform_back_to_transactional_format.R")

### B2B Rules

summary(b2b.basket1)

itemFrequencyPlot(b2b.basket1, type="absolute",
                  topN = 15, horiz=TRUE, col="cadetblue2",
                  xlab='Frequency', main='Product frequency, absolute')

rulesb2b <- apriori(b2b.basket1, parameter = list(supp=0.001, conf=0.2, minlen=4))
rulesb2b <- sort(rulesb2b, by='count', decreasing = TRUE)
inspect(rulesb2b[1:25])
summary(rulesb2b)

plot(rulesb2b,control=list(col=brewer.pal(11,"Spectral")),main="B2B Rules plot", jitter= 0)

# top ten most important rules

inspect(sort(rulesb2c, by = "support")[1:10])

# Rules for upselling 

LaptopRules <- subset(rulesb2b, rhs %in% "Eluktronics Pro Gaming Laptop")
LaptopRules <- subset(LaptopRules, lhs %in% "iMac")

LaptopRules1 <- subset(rulesb2b, lhs %in% "iMac")
inspect(sort(LaptopRules1, by = "count")[1:25]) 

inspect(sort(LaptopRules, by = "count")) 

plot(LaptopRules1[1], method = "graph", measure = "support", 
     shading = "lift", engine = "igraph", data = NULL, control = NULL) 
dev.off()

### B2C Rules 

summary(b2c.basket1)

itemFrequencyPlot(b2c.basket1, type="absolute",
                  topN = 15, horiz=TRUE, col="cadetblue2",
                  xlab='Frequency', main='Product frequency, absolute')

rulesb2c <- apriori(b2c.basket1, parameter = list(supp=0.01, conf=0.1))
rulesb2c <- sort(rulesb2c, by='confidence', decreasing = TRUE)
inspect(rulesb2c)
summary(rulesb2c)

plot(rulesb2c,control=list(col=brewer.pal(11,"Spectral")),main="B2B Rules plot", jitter= 0)

# top ten most important rules

inspect(sort(rulesb2c, by = "support"))
