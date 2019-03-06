source("Step_2_Comparing_BW_and_EN_data.R")

### Apriori functions - total Elektronidex

En.all.rules<- apriori (en.tr, parameter = list(supp = 0.02, conf = 0.4, minlen=2))

inspect(En.all.rules[1:10])

TopRules.en.all <- inspect(En.all.rules[1:10]) # Top 10 Rules of Associations between products at Electronidex
summary(En.all.rules)

#better UX for rules
#arulesViz::ruleExplorer(En.all.rules)

#sorting rules

inspect(sort(En.all.rules, by = "confidence"))
inspect(sort(En.all.rules, by = "support"))
inspect(sort(En.all.rules, by = "lift"))[1:10,]

#specific iMAc rule

iMac.rules <- subset(En.all.rules, items %in% "iMac")
inspect(iMac.rules)
iMac.rules.lhs <- subset(En.all.rules, lhs %in% "iMac")
inspect(iMac.rules.lhs)

#specific HP Laptop rule

HP.rules <- subset(En.all.rules, items %in% "HP Laptop")
inspect(HP.rules)
plot(HP.rules, method="graph", control=list(type="items")) 

HP.rules.rhs <- subset(En.all.rules, rhs %in% "HP Laptop")
inspect(HP.rules.rhs) 
plot(HP.rules.rhs, method="graph", control=list(type="items")) 

#Checking redundant rules 

is.redundant(En.all.rules)
inspect(En.all.rules[is.redundant(En.all.rules)])
rules_pruned <- En.all.rules[!is.redundant(En.all.rules)]
summary(rules_pruned)

#Vizualising overall rules 

plot(En.all.rules [1:5], method = "graph", measure = "support", 
     shading = "lift", engine = "igraph", data = NULL, control = NULL)
