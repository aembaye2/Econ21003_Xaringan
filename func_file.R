
#functions for drawing
options(htmltools.dir.version = FALSE)
#knitr::knit_exit()
library(knitr)
library(kableExtra)
library(dplyr)
library(ggplot2)
library(cowplot)
#install.packages("ggpmisc")                         # Install & load ggpmisc package
library("ggpmisc")
#install.packages("patchwork")                       # Install & load patchwork
library("patchwork")
library(ggpmisc)
library(gridExtra)
library(grid)
library("ggdensity")
library(ggpubr)

# Create the data frame

draw_and_table <- function(x, y, x_title = "X Axis", y_title = "Y Axis") {
  
  df <- data.frame(x=x,y=y)
  
  # Create the line plot
  line_plot <- ggplot(df, aes(x = x, y = y)) + 
    geom_line(linewidth = 1.5) +
    geom_point(size = 3) +
    theme(
      axis.title.x = element_text(size = 20),  # Enlarge x-axis title
      axis.title.y = element_text(size = 20),  # Enlarge y-axis title
      axis.text.x = element_text(size = 25),   # Enlarge x-axis labels
      axis.text.y = element_text(size = 25)    # Enlarge y-axis labels
    )+
    labs(x = x_title, y = y_title)  +  # Set custom axis titles
    scale_x_continuous(breaks = x) +  # Set x-axis breaks to match data
    scale_y_continuous(breaks = y,  labels = label_dollar(accuracy = 0.01))    # Set y-axis breaks to match data
  # Create the summary table
  summary_table <- data.frame(
    `P` = label_dollar(accuracy = 0.01)(y), #dollar(y),
    `Qd` = x
  )
  
  # Create the table using ggtexttable with larger text
  table_plot <- ggtexttable(summary_table, rows = NULL, theme = ttheme("mOrange", base_size = 40))
  
  # Arrange the line plot and table side by side
  grid.arrange(line_plot, table_plot, ncol = 2, widths = c(3, 1))
}

## Call the function with custom x, y values and axis titles
# x_values <- 1:10
# y_values <- 2 * (1:10)
# x_title = "Cups of Mocha per Month"
# y_title = "Price in dollars"
# draw_and_table(x_values, y_values, x_title , y_title  )
