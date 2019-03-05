source("Step_1_Preparing_datasets.R")

### Compare Blackwell and Electronidex product offering

# Prepare Blackwell product data

bwtype <- rbind(bw, bwnew)
bwtype <- data.frame(bwtype$ProductType, bwtype$ProductNum)
bwtype

bwtype$Company <- "Blackwell"
colnames(bwtype)[1] <- "ProductType"
colnames(bwtype)[2] <- "Product"

# Prepare Electronidex product data 

en.types
en.types$Company <- "Electronidex"

# Merge dataframes

ProductTypes <- rbind(en.types, bwtype)

# Visually compare Blackwell and Electronidex product offering 

ggplot(tally(group_by(ProductTypes, ProductType, Company)),aes(ProductType, n, fill = ProductType)) + 
  geom_col() + facet_grid(Company ~ .) + theme(axis.text.x = element_text(angle = 90, hjust = 1, size =15))+
  guides(fill=FALSE) + xlab("Products") + ylab("Count") + 
  ggtitle("Visual Representation of Product Offering between BW and EN")

# Inspect Electronidex data

inspect(en.tr[1:10])       #view transactions
length(en.tr)              #number of transactions
size(en.tr)                #number of items per transaction (potential B2B, B2C split?)
LIST(en.tr)                #List of transaction per conversion 
itemLabels(en.tr) #See labels of items 
itemInfo(en.tr)
head(en.tr@itemInfo, n=25) 
head(en.tr@data)
head(en.tr@itemInfo, n=25)
en.tr <- en.tr[which(size(en.tr)!= 0)] #remove empty rows
summary(en.tr)

# Visualise the data 

itemFrequencyPlot(en.tr, type="absolute", topN = 15,
                  horiz=TRUE, col="cadetblue2", xlab='Frequency',
                  main='Product frequency, absolute')

image(en.tr[1:100], xlab = "Items (Columns)", 
      ylab = "Transactions (Rows)")

crossTable(en.tr, measure="lift", sort=TRUE) [1:10,1:10]

image(sample(en.tr, 100))

transaction.sizes <- as.data.frame(size(en.tr))
transaction.sizes
ggplot(transaction.sizes, aes(size(en.tr)))+geom_bar() +xlab("Purchased items per transaction")+
  ylab("Count") + ggtitle("Amount of individual items per purchase") #highlights necessity to split between B2B and B2C
