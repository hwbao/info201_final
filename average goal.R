library("dplyr")
library("plotly")

kickstarter <- read.csv("./data/ks_projects_201801.csv", stringsAsFactors = FALSE)

m <- list(
  l = 50,
  r = 50,
  b = 100,
  t = 100,
  pad = 4
)
# Use group_by function to categorize by main category and then
# Then use function select and summarize to get mean amount of goal
main_category_analysis <- function(data) {
  main_category_df <- data %>%
    select(main_category, goal) %>%
    group_by(main_category) %>%
    dplyr::summarize(main_mean_goal = round(mean(goal))) %>%
    arrange(-main_mean_goal) %>% 
    mutate(description = paste0("The Main Category ", main_category, 
                                "'s Mean Goal is $", main_mean_goal))
  
  main_category_df$main_category <- factor(main_category_df$main_category, 
                                           levels = c(as.character(main_category_df$main_category)))
  
  p <- plot_ly(main_category_df,
               x = ~main_category,
               y = ~main_mean_goal,
               text = ~description,  
               type = "bar",
               color = ~main_category,
               colors = "Paired",
               opacity = 0.9
               ) %>%
    layout(autosize = T, margin = m,
           title = "Average Goal for All Main Category",
           font = list(color = "#C0C0C0"),
           xaxis = list(title = "Main Category"),
           yaxis = list(title = "Goal (USD)"),
           paper_bgcolor = "#010402",
           plot_bgcolor = "#010402"
    )  
  
  return(p)
}

# Our next job is to find average goal for sub category below each main category
# We use group_by function first to categorize df then use select and summarize function
# to get the average value for goal in each sub category
sub_category_analysis <- function(data, chosen_main_category){
  sub_category_df <- data %>%
    filter(main_category == chosen_main_category) %>% 
    group_by(category) %>%
    dplyr::summarize(sub_mean_goal = round(mean(goal))) %>% 
    arrange(-sub_mean_goal) %>% 
    mutate(description = paste0("The Sub Category ", category, "'s Mean Goal is $", sub_mean_goal))
  
  sub_category_df$category <- factor(sub_category_df$category, 
               levels = c(as.character(sub_category_df$category)))
  
  sizeref <- 2.0 * max(sub_category_df$sub_mean_goal) / (10**2)
  
  pp <- plot_ly(sub_category_df,
                x = ~category,
                y = ~sub_mean_goal, 
                text = ~description,
                type = 'scatter',
                mode = 'markers',
                marker = list(size = ~sub_mean_goal, 
                              sizeref = sizeref, color = "D175B7", line = list(width = 0) )) %>%
    layout(autosize = T, margin = m,
           title = 'Mean Goal for Sub Categories In Each Main Category',
           xaxis = list(title = "Sub Category"),
           yaxis = list(showgrid = FALSE, title = "Sub Category Goal (USD)"),
           font = list(color = "#C0C0C0"),
           paper_bgcolor = "#010402",
           plot_bgcolor = "#010402")
  
  return(pp)
}

