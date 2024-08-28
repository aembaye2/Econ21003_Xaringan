
library(readxl)
data <- read_excel("C:/C-aembaye/Teaching/00_MasterModules_forAllCourses/Ec_2013/Lec/Lec11_AD&AS/im/gdp_1900.xlsx", sheet=1)

usgdp<- data.frame(data)[-c(1:20),]  #start from 1920
head(usgdp)

xlim<- c(min(usgdp[,1]), max(usgdp[,1]))
ylim<- c(0, max(usgdp[,2]))

xlab="Year"
ylab="U.S. Real GDP per Capita"

#plot(NULL, xlim = xlim, ylim = ylim, xaxt = "n", yaxt = "n",    xlab = "", ylab = "", bty = "n") 
plot(NULL, xlim = xlim, ylim = ylim,  xlab = xlab, ylab = ylab) 

lines(usgdp)
