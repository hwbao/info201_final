# load package 
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

new_data <- kickstarter %>%
  dplyr::group_by(category, main_category) %>%
  dplyr::summarize(category_pledged = sum(usd_pledged_real)) %>% 
  ungroup() %>% 
  top_n(20, wt=category_pledged)

new_data$fac_main_cate <- as.numeric(factor(new_data$main_category)) - 1
new_data$fac_cate <- as.numeric(factor(new_data$category)) + 7
  
  draw_graph <- plot_ly(type = "sankey", 
                        domain = list(x =  c(0,1), y =  c(0,1)),
                        orientation = "h",
                        
                        node = list(
                          # label = c(new_data$fac_main_cate, new_data$fac_cate),
                          # label = 0:34, # works!
                          label = c(unique(new_data$main_category), unique(new_data$category)),
                          
                          color = "#262C46",
                          pad = 15,
                          thickness = 15,
                          line = list(color = "black", width = 0.5)
                        ),
                        
                        link = list(source = new_data$fac_main_cate,
                                    target = new_data$fac_cate,
                                    value =  new_data$category_pledged)
                      ) %>%
    layout(
      title = "Total pledged each category get and distribution to their sub category",
      font = list(
        size = 11
      ),
      xaxis = list(showgrid = F, zeroline = F),
      yaxis = list(showgrid = F, zeroline = F)
    )

  draw_graph