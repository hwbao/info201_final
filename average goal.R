library("dplyr")
library("plotly")

kickstarter <- read.csv("./data/ks_projects_201801.csv", stringsAsFactors = FALSE)

# Use group_by function to categorize by main category and then
# Then use function select and summarize to get mean amount of goal
main_category_analysis <- function(data) {
  main_category_df <- data %>%
    select(main_category, goal) %>%
    group_by(main_category) %>%
    dplyr::summarize(main_mean_goal = round(mean(goal))) %>%
    arrange(-main_mean_goal) %>% 
    mutate(description = paste0("The main category ", main_category, 
                                "'s mean goal is ", main_mean_goal))
  
  main_category_df$main_category <- factor(main_category_df$main_category, 
                  levels = c(as.character(main_category_df$main_category)))
  
  p <- plot_ly(main_category_df,
               x = ~main_category,
               y = ~main_mean_goal,
               text = ~description,
               type = "bar"
  ) %>%
    layout(title = "Average Goal for All Category",
           xaxis = list(title = "Main category"),
           yaxis = list(title = "Goal")
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
    mutate(description = paste0("The sub category ", category, "'s mean goal is ", sub_mean_goal))
  
  sub_category_df$category <- factor(sub_category_df$category, 
               levels = c(as.character(sub_category_df$category)))
  
  sizeref <- 2.0 * max(sub_category_df$sub_mean_goal) / (10**2)
  
  pp <- plot_ly(sub_category_df, x = ~category, y = ~sub_mean_goal, 
                text = ~description, type = 'scatter', mode = 'markers',
                marker = list(size = ~sub_mean_goal, opacity = 0.5,
                              sizeref = sizeref)) %>%
    layout(title = 'Mean goal for sub_category in each main category',
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE))
  
  return(pp)
}
