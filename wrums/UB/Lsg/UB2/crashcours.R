data = read.table('../../Daten.txt', sep=' ')
data = data[complete.cases(data),]
print(mean(data$Alter))
