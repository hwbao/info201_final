library("dplyr")
library("plotly")

m <- list(
  l = 50,
  r = 50,
  b = 100,
  t = 100,
  pad = 4
)

# Our customized color set 
my_color <- c(
  "rgb(241, 188, 172)", "rgb(241, 171, 206)", "rgb(223, 172, 240)",
  "rgb(170, 172, 240)", "rgb(128, 162, 227)", "rgb(167, 129, 226)",
  "rgb(227, 129, 211)", "rgb(227, 127, 137)", "rgb(202, 84, 133)",
  "rgb(183, 87, 202)", "rgb(92, 86, 201)", "rgb(86, 164, 202)",
  "rgb(54, 179, 178)", "rgb(47, 81, 176)", "rgb(111, 52, 176)",
  "rgb(177, 50, 144)", "rgb(142, 51, 151)", "rgb(63, 50, 151)",
  "rgb(49, 110, 151)", "rgb(52, 152, 118)"
)

# categorize by main category and then
# calculates mean amount of goal, returns a bar chart
main_category_analysis <- function(data) {
  main_category_df <- data %>%
    select(main_category, goal) %>%
    group_by(main_category) %>%
    dplyr::summarize(main_mean_goal = round(mean(goal))) %>%
    arrange(-main_mean_goal) %>%
    mutate(description = paste0(
      "The Main Category ", main_category,
      "'s Mean Goal is $", main_mean_goal
    ))

  main_category_df$main_category <- factor(main_category_df$main_category,
    levels = c(as.character(main_category_df$main_category))
  )

  size <- length(unique(main_category_df$main_category))

  p <- plot_ly(main_category_df,
    x = ~main_category,
    y = ~main_mean_goal,
    type = "bar",
    marker = list(color = my_color[0:size]),
    hoverinfo = "text",
    text = ~ paste(
      "Category:", main_category,
      "<br>Mean Goal:", main_mean_goal, "$", 
      "<br>", description
    )
  ) %>%
    layout(
      autosize = T, margin = m,
      title = "Average Goal for All Main Category",
      font = list(color = "#C0C0C0"),
      xaxis = list(title = "Main Category"),
      yaxis = list(title = "Average Goal (USD)"),
      paper_bgcolor = "transparent",
      plot_bgcolor = "transparent"
    )

  return(p)
}

# Find average goal for sub category below each main category
# categorize df then calculates the average value for goal in each sub category,
# returns a babble chart
sub_category_analysis <- function(data, chosen_main_category) {
  sub_category_df <- data %>%
    filter(main_category == chosen_main_category) %>%
    group_by(category) %>%
    dplyr::summarize(sub_mean_goal = round(mean(goal))) %>%
    arrange(-sub_mean_goal) %>%
    mutate(description = paste0(
      "The Sub Category ",
      category, "'s Mean Goal is $", sub_mean_goal
    ))

  sub_category_df$category <- factor(sub_category_df$category,
    levels = c(as.character(sub_category_df$category))
  )

  sizeref <- 2.0 * max(sub_category_df$sub_mean_goal) / (10 ** 2)

  size <- length(unique(sub_category_df$category))

  pp <- plot_ly(sub_category_df,
    x = ~category,
    y = ~sub_mean_goal,
    type = "scatter",
    mode = "markers",
    marker = list(
      size = ~sub_mean_goal,
      sizeref = sizeref,
      color = my_color[0:size],
      opacity = 1,
      line = list(width = 0)
    ),
    hoverinfo = "text",
    text = ~ paste(
      "Category:", category,
      "<br>Sub Mean Goal:", sub_mean_goal, "$",
      "<br>", description
    )
  ) %>%
    layout(
      autosize = T, margin = m,
      title = paste("Mean Goal for Sub Categories In", chosen_main_category),
      line = list(width = 0),
      xaxis = list(title = "Sub Category"),
      yaxis = list(showgrid = FALSE, title = "Sub Category Mean Goal (USD)"),
      font = list(color = "#C0C0C0"),
      paper_bgcolor = "transparent",
      plot_bgcolor = "transparent"
    )

  return(pp)
}