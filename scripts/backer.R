# load package
library(dplyr)
library(plotly)

# Function to draw the graph for average amount of money
# that a backer would give to a project in a given specific category
draw_backer_project_relationship <- function(data, project_name) {
  my_color <- c(
    "rgb(241, 188, 172)", "rgb(241, 171, 206)", "rgb(223, 172, 240)",
    "rgb(170, 172, 240)", "rgb(128, 162, 227)", "rgb(167, 129, 226)",
    "rgb(227, 129, 211)", "rgb(227, 127, 137)", "rgb(202, 84, 133)",
    "rgb(183, 87, 202)", "rgb(92, 86, 201)", "rgb(86, 164, 202)",
    "rgb(54, 179, 178)", "rgb(47, 81, 176)", "rgb(111, 52, 176)",
    "rgb(177, 50, 144)", "rgb(142, 51, 151)", "rgb(63, 50, 151)",
    "rgb(49, 110, 151)", "rgb(52, 152, 118)"
  )

  select_project <- kickstarter %>%
    filter(main_category == project_name) %>%
    select(name, category, main_category, backers, usd_pledged_real, state) %>%
    group_by(category) %>%
    summarize(
      total_pledged = sum(usd_pledged_real),
      total_backers = sum(backers)
    ) %>%
    mutate(
      avg = round(total_pledged / total_backers),
      description = paste0(
        category,
        "'s Average Pledge from Each Backer is $",
        avg
      )
    ) %>%
    arrange(-avg)

  select_project$category <- factor(select_project$category,
    levels = c(as.character(select_project$category))
  )
  size <- length(unique(select_project$category))

  draw_each_sub <- plot_ly(select_project,
    x = ~category,
    y = ~avg,
    text = ~description,
    type = "bar",
    marker = list(color = my_color[0:size]),
    opacity = 1.5,
    name = ~category
  ) %>%
    layout(
      title = "Backer's Average Investment",
      font = list(color = "#C0C0C0"),
      xaxis = list(title = "Category"),
      yaxis = list(title = "Average Pledged (USD)"),
      paper_bgcolor = "transparent",
      plot_bgcolor = "transparent",
      showlegend = TRUE
    )
  return(draw_each_sub)
}