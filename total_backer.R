# load package 
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

draw_sankey_graph <- function(kickstarter, top) {
  new_data <- kickstarter %>%
    dplyr::filter(main_category != category) %>%
    dplyr::group_by(main_category, category) %>%
    dplyr::summarize(category_pledged = sum(usd_pledged_real)) %>% 
    ungroup() %>%
    top_n(as.numeric(top), wt=category_pledged)
  
  new_data$fac_main_cate <- as.numeric(factor(new_data$main_category)) - 1
  
  arrange_data <- new_data %>%
    arrange(fac_main_cate)
  
  arrange_data$fac_cate <- as.numeric(factor(arrange_data$category)) +
                                      length(unique(arrange_data$main_category)) - 1
  
  
  m <- list(
    l = 50,
    r = 50,
    b = 100,
    t = 100,
    pad = 4
  )
  
    draw_graph <- plot_ly(type = "sankey", 
                          domain = list(x =  c(0,1), y =  c(0,1)),
                          orientation = "h",
                          valueformat = ".0f",
                          valuesuffix = "TWh",
                          width = 1080,
                          height = 800,
                          
                          node = list(
                            # label = c(new_data$fac_main_cate, new_data$fac_cate),
                            # label = 0:34, # works!
                            label = c(unique(arrange_data$main_category), sort(unique(arrange_data$category), decreasing = F)),
                            color = "#D175B7",
                            pad = 15,
                            thickness = 20,
                            line = list(color = "black", width = 0.5)
                          ),
                          
                          link = list(source = arrange_data$fac_main_cate,
                                      target = arrange_data$fac_cate,
                                      value =  arrange_data$category_pledged,
                                      color = "#4BC3B5")
                        ) %>%
      layout(
        title = "Total Pledged from Main Category to Sub Category",
        font = list(
          size = 11,
          color = "#C0C0C0"
        ),
        xaxis = list(showgrid = T, zeroline = T),
        yaxis = list(showgrid = F, zeroline = F),
        plot_bgcolor = "#010402",
        paper_bgcolor = "#010402"
      )

  return(draw_graph)
}
  
  