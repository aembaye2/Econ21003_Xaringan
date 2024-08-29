
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
library(colorspace) # for darken()
library(ggrepel)    # for geom_text_repel()
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

#----------------------------------------------------------------

library(ggplot2)
library(gridExtra)
library(ggpubr)
library(scales)

draw_and_table2 <- function(x, y, z, x_title = "X Axis", y_title = "Y Axis") {
  
  df <- data.frame(x = x, y = y, z = z)
  
  # Create the line plot
  line_plot <- ggplot(df) + 
    geom_line(aes(x = x, y = y), color = "blue", linewidth = 1.5) +
    geom_point(aes(x = x, y = y), color = "blue", size = 3) +
    geom_line(aes(x = z, y = y), color = "red", linewidth = 1.5) +
    geom_point(aes(x = z, y = y), color = "red", size = 3) +
    theme(
      axis.title.x = element_text(size = 20),  # Enlarge x-axis title
      axis.title.y = element_text(size = 20),  # Enlarge y-axis title
      axis.text.x = element_text(size = 25),   # Enlarge x-axis labels
      axis.text.y = element_text(size = 25)    # Enlarge y-axis labels
    ) +
    labs(x = x_title, y = y_title) +  # Set custom axis titles
    scale_x_continuous(breaks = x) +  # Set x-axis breaks to match data
    scale_y_continuous(labels = label_dollar(accuracy = 0.01))  # Set y-axis labels to dollar format
  
  # Create the summary table
  summary_table <- data.frame(
    `P` = label_dollar(accuracy = 0.01)(y), # Dollar format for y
    `Qd` = x,
    `Qs` = z  # Dollar format for z
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

grepl_plot<- function(){
 
  xvar_name= "Gasoline price (in dollars per gallon)"
  yvar_name="Gasoline consumption\n (gallon per day per person)"
  p<- c(3, 4, 5.5,6, 7.5,7.6, 7.8, 8.2)
  country<- c("U.S.", "Canada", "Japan", "Spain",
              "Italy", "France", "U.K.", "Germany")
  region<- c("Americas", "Americas", "Asia", "Europe",
             "Europe", "Europe", "Europe", "Europe")
  q<- c(1.3, 1.0, .4, .2,.35, .2,.38, .37 )
  
  df<- data.frame(q,p, country, region)
  nregions= length(unique(df$region))
  #"country" "region"  "cpi"     "hdi"
  
  # Okabe Ito colors
  
  # region_cols <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2" , "#999999")
  # Define a color palette
  color_palette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#999999", "#D55E00", "#CC79A7", "#F0E442", "#0072B2")
  
  region_cols <-  color_palette[1:(nregions+1)]
  country_highlight <- c("U.S.", "Canada", "Japan", "Spain",
                         "Italy", "France", "U.K.", "Germany")
  
  df <- df %>%
    mutate(
      label = ifelse(country %in% country_highlight, country, "")
    )
  
  df <- df %>%
    mutate(region = case_when(
      region == "Middle East and North Africa" ~ "Middle East\nand North Africa",
      region == "Europe and Central Asia" ~ "Europe and\nCentral Asia",
      region == "Sub Saharan Africa" ~ "Sub-Saharan\nAfrica",
      TRUE ~ region)
    )
  
  ggplot(df, aes(q, p)) +
    geom_smooth(
      aes(color = "y ~ log(x)", fill = "y ~ log(x)"),
      method = 'lm', formula = y~log(x), se = FALSE, fullrange = TRUE
    ) +
    geom_point(
      aes(color = region, fill = region),
      size = 2.5, alpha = 0.5, shape = 21
    ) +
    geom_text_repel(
      aes(label = label), # this label are the selected countries
      color = "black",
      size = 9/.pt, # font size 9 pt
      point.padding = 0.1, 
      box.padding = .6,
      min.segment.length = 0,
      max.overlaps = 1000,
      seed = 7654
    ) +
    scale_color_manual(
      name = NULL,
      values = darken(region_cols, 0.3)
    ) +
    scale_fill_manual(
      name = NULL,
      values = region_cols
    ) +
    scale_x_continuous(
      name = xvar_name ,
      limits = c(min(q)-.3, max(q)+.5),
      breaks = c(0, .25, .50, 1.0, 1.5),
      expand = c(0, 0)
    ) +
    scale_y_continuous(
      name = yvar_name,
      limits = c(min(p)-1, max(p)),
      breaks = 2:8,
      expand = c(0, 0)
    ) +
    guides(
      color = guide_legend(
        nrow = 1,
        override.aes = list(
          linetype = c(rep(0, nregions), 1),
          shape = c(rep(21, nregions), NA)
        )
      )
    ) +
    theme_minimal_hgrid(12, rel_small = 1) +
    theme(
      legend.position = "top",
      legend.justification = "right",
      legend.text = element_text(size = 9),
      legend.box.spacing = unit(0, "pt")
    )
}