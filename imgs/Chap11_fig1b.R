
library(RColorBrewer)
myPalette <- brewer.pal(5, "Set2") 

# You can change the border of each area with the classical parameters:
pie(1:4, labels = c("Gr-A","Gr-B","Gr-C","Gr-D","Gr-E"), border="white", col=myPalette )