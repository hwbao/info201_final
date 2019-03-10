library("dplyr")
library("plotly")

# What is the average goal for a specific category
# Read data from file  into a data frame `kickstarter`
kickstarter <- read.csv("./data/ks_projects_201801.csv", stringsAsFactors = FALSE)

# Use group_by function to categorize by main category and then
# Then use function select and summarize to get mean amount of goal
main_category_analysis <- kickstarter %>% 
  select(main_category, goal) %>%
  group_by(main_category) %>%
  dplyr::summarize(main_mean_goal = round(mean(goal))) %>%
  arrange(desc(main_mean_goal)) %>% 
  mutate(description = paste0("The main category ", main_category, "'s mean goal is ", main_mean_goal))


p <- plot_ly(main_category_analysis,
  x = ~main_category,
  y = ~main_mean_goal,
  text = ~description,
  type = "bar"
) %>%
  layout(title = "Average goal for specific category",
         xaxis = list(title = "Main category"),
         yaxis = list(title = "Goal")
  )    

# Our next job is to find average goal for sub category below each main category
# We use group_by function first to categorize df then use select and summarize function
# to get the average value for goal in each sub category
sub_category_analysis <- kickstarter %>%
  select(main_category, category, goal) %>%
  filter(main_category == "Music") %>% 
  group_by(category) %>%
  dplyr::summarize(sub_mean_goal = round(mean(goal))) %>% 
  arrange(desc(sub_mean_goal)) %>% 
  mutate(description = paste0("The sub main category ", category, "'s mean goal is ", sub_mean_goal))

pp <- plot_ly(sub_category_analysis, x = ~category, y = ~sub_mean_goal, 
              text = ~description, type = 'scatter', mode = 'markers',
             marker = list(size = ~sub_mean_goal*0.001, opacity = 0.5)) %>%
  layout(title = 'Mean goal for sub_category in each main category',
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE))

