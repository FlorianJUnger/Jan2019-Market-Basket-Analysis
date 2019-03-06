
source("Step_3_Apriori_rules_Electronidex.R")

### Split dataset into B2B and B2C

# in order to split the Data in B2B and B2C we need to transform the data format from transactional data to 
# a dataframe. After we split it with an ifelse Rule, we need to change it back to transactional data so 
# we can run our apriori Analysis on it

# converting transactional data to dataframe  

en.matrix <- as(en.tr, "matrix")
en.df <- as.data.frame(en.matrix)
en.df

for (i in 1:ncol(en.df)){
  en.df[,i] <- as.numeric(en.df[,i])}   #replacing T/F with 0/1

en.df$ProductsPerTrans <- rowSums(en.df)
en.df

# Pruning to get only Laptops and PCs for the split

en.types
en.laptops <- en.types[74:83,2]
en.laptops
en.pcs <- en.types[51:59,2]
en.pcs
en.laptops.full <- en.df[, colnames(en.df) %in% en.laptops] #en.df only with laptops
en.laptops.full
en.pcs.full <- en.df[, colnames(en.df) %in% en.pcs] #en.df with only PCs
en.pcs.full

en.laptops.full$Counts.lt <- rowSums(en.laptops.full)
en.pcs.full$Counts.pcs <- rowSums(en.pcs.full)

en.ltpc <- cbind(en.laptops.full, en.pcs.full)

# Separation B2B and B2C

# Rule 1: if a laptop and a PC bought -> B2B
# Rule 2: if more than 5 items in one purchase -> B2B

en.ltpc.2 <- en.ltpc
en.df$customer_type <- ifelse(en.ltpc.2$Counts.lt > 1 | en.ltpc.2$Counts.pcs > 1, "B2B", 
                              ifelse((en.df[,127]) > 5, "B2B", "B2C")

en.df.dnm <- en.df
en.df.dnm$customer_type <- ifelse(
  en.ltpc.2$Counts.lt > 1| en.ltpc.2$Counts.pcs >1, "B2B", "B2C") #to assess importance of category #1

b2b.df <- en.df[en.df$customer_type == "B2B", ]
b2b.df

b2c.df <- en.df[en.df$customer_type == "B2C", ]
b2c.df
write.csv(b2b.df, "b2b.csv")
write.csv(b2c.df, "b2c.csv")

# Converting B2B and B2C back to transactional data

b2c.basket <-
  apply(b2c.df[-c(126:127)],2,as.logical) #deleting customer_type and count

b2c.basket
b2c.basket1 <- as(b2c.basket, "transactions")

b2b.basket <-
  apply(b2b.df[-c(126:127)],2,as.logical) #deleting customer_type and count

b2b.basket1 <- as(b2b.basket, "transactions")
summary(b2b.basket1)
summary(b2c.basket1)

# Transaction sizes for b2b and b2c

transaction.sizes.b2b <- as.data.frame(size(b2b.basket1))
transaction.sizes.b2c <- as.data.frame(size(b2c.basket1))

ggplot(transaction.sizes.b2b, aes(size(b2b.basket1), fill=as.factor(size(b2b.basket1))))+
  geom_bar()+ xlab("Basket Size")+ ggtitle("Basket Size for B2B customers")+ guides(fill=FALSE)

ggplot(transaction.sizes.b2c, aes(size(b2c.basket1),fill=as.factor(size(b2c.basket1))))+
  geom_bar()+xlab("Basket Size")+ggtitle("Basket Size for B2C customers")+ guides(fill=FALSE)
