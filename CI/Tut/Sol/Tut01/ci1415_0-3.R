normDist = rnorm(50, mean=2, sd=3)

print(summary(normDist))
print(mean(normDist))
print(median(normDist))
print(min(normDist))
print(max(normDist))

fileUrl = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
irisDS = read.table(
    fileUrl, header=FALSE, sep=",",col.names=c("sepalLength", "sepalWidth", "pentalLength", "pentalWidth", "class")
)

print(summary(irisDS))
print(sd(irisDS$sepalWidth))
