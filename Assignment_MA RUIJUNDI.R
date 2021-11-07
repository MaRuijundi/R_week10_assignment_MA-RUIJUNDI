############# read csv ###############
data<- read.csv("food-price-index-September-2021-index-numbers-csv-tables.csv",sep = ",",header = T)
head(data)

################ Create data tables ##############
library(data.table)
FoodDF= data.frame(x= data$Series_reference ,y= data$Period,z=data$Data_value)
head(FoodDF,3)

FoodDT = data.table(x= data$Series_reference ,y= data$Period,z=data$Data_value)
head(FoodDT,3)

tables()

FoodDT[1259,]
FoodDT[c(2,3)]
FoodDT[,c(2,3)]


########################## Ordering with plyr   ###############
library(plyr)
arrange(data,Series_reference)
arrange(data,desc(Series_reference))

### Summarizing data ###
head(data,n=3)
tail(data,n=3)
summary(data)

sum(is.na(data$Data_value))
any(is.na(data$Data_value))

colSums(is.na(data))


### Another way for summarise ###
ddply(data,.(Series_reference),summarise,sum=sum(Data_value))

############################ Easier cutting #####################
library(lattice)
library(survival)
library(Formula)
library(ggplot2)
library(Hmisc)
data$Series_reference = cut2(data$Data_value,g=4)
table(data$Series_reference)


############### Reshaping data #############
library(reshape2)
head(data)

### Melting data frames ###
data$number <- rownames(data)
foodMelt <- melt(data,id=c("Series_reference","Period","Series_title_1"),measure.vars = c("Data_value"))
head(foodMelt,n=3)
tail(foodMelt,n=3)

### Casting data frames ###
foodData <- dcast(foodMelt,Series_reference ~ variable,mean)
foodData

################## Averaging values ##############
head(data)

####### factor function #######
catalog <- factor(data$Series_title_1)
catalog[1:100]

class(catalog)

### Sum the price value for each product by tapply function ###
tapply(data$Data_value,data$Series_reference,sum)
tapply(data$Data_value,data$Series_title_1,sum)

### get the average of price value for each product by tapply function ###
tapply(data$Data_value,data$Series_reference,mean)
tapply(data$Data_value,data$Series_title_1,mean)


### split ###
spFood = split(data$Data_value,data$Series_title_1)
spFood

##### Using sapply function get the sum and mean value ###
sapply(spFood,sum)
sapply(spFood,mean)







