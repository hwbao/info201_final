# load package 
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

my_color <- c("rgb(232, 129, 129)", "rgb(232, 206, 129)", "rgb(232, 211, 129)",
              "rgb(216, 232, 129)", "rgb(166, 232, 129)", "rgb(129, 232, 180)",
              "rgb(232, 129, 214)",
              "rgb(129, 228, 232)", "rgb(129, 182, 232)", "rgb(129, 146, 232)", 
              "rgb(142, 232, 129)", "rgb(158, 129, 232)", "rgb(185, 129, 232)", 
              "rgb(195, 129, 232)", "rgb(218, 129, 232)",
              "rgb(232, 129, 173)", "rgb(232, 129, 183)", "rgb(232, 129, 214)")

draw_sankey_graph <- function(kickstarter) {
  #new_data <- kickstarter %>%
  # dplyr::filter(main_category != category) %>%
  #dplyr::group_by(main_category, category) %>%
  # dplyr::summarize(category_pledged = sum(usd_pledged_real)) %>% 
  # ungroup() %>%
  #top_n(as.numeric(top), wt=category_pledged)
  
  new_data <- kickstarter %>%
    dplyr::filter(main_category != category) %>%
    dplyr::group_by(main_category, category) %>%
    dplyr::summarize(category_pledged = sum(usd_pledged_real)) %>% 
    dplyr::mutate(hoverinfo = paste0("The amount ",
                                     category,
                                     "received from backers are ",
                                     category_pledged)) %>%
    top_n(3, wt = category_pledged)
  
  
  new_data$fac_main_cate <- as.numeric(factor(new_data$main_category)) - 1
  
  arrange_data <- new_data %>%
    arrange(fac_main_cate)
  
  arrange_data$fac_cate <- as.numeric(factor(arrange_data$category)) +
    length(unique(arrange_data$main_category)) - 1
  
  draw_graph <- plot_ly(type = "sankey", 
                        domain = list(x =  c(0,1), y =  c(0,1)),
                        orientation = "h",
                        valueformat = ".0f",
                        valuesuffix = "TWh",
                        width = 1080,
                        height = 1000,
                        textfont = list(size = 16),
                        
                        node = list(
                          # label = c(new_data$fac_main_cate, new_data$fac_cate),
                          # label = 0:34, # works!
                          label = c(unique(arrange_data$main_category),
                                    sort(unique(arrange_data$category),
                                         decreasing = F)),
                          pad = 15,
                          thickness = 20,
                          color = my_color[0:15],
                          line = list(color = 'black', width = 0.5)
                        ),
                        
                        link = list(source = arrange_data$fac_main_cate,
                                    target = arrange_data$fac_cate,
                                    value =  arrange_data$category_pledged,
                                    label = arrange_data$hoverinfo)
  ) %>%
    layout(
      title = "Total Pledged(USD) Each Category Get and Distribution to Their Sub Category",
      font = list(
        size = 11,
        color = "#C0C0C0"
      ),
      xaxis = list(showgrid = T, zeroline = T),
      yaxis = list(showgrid = F, zeroline = F),
      plot_bgcolor = "transparent",
      paper_bgcolor = "transparent"
    )
  return(draw_graph)
}
