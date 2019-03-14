library("shiny")
library("plotly")
library("dplyr")
library("lubridate")

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

# Calculate success rate for all main category, returns an interactive 
# babble chart with animation, including date, amount of projects, amount backer
# for each main category
find_rate <- function(data) {
  modified_df <- data %>%
    select(main_category, state, deadline, backers) %>%
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>%
    group_by(main_category, deadline) %>%
    filter(deadline != 2018 && deadline != 2009) %>%
    mutate(total_projects = n(), total_backers = sum(backers)) %>%
    filter(state == "successful") %>%
    mutate(success = n()) %>%
    mutate(success_rate = round(success / total_projects * 100, 1)) %>%
    select(
      main_category, success_rate, total_projects,
      total_backers, deadline
    ) %>%
    unique(by = main_category) %>%
    arrange(deadline)
  
  m <- list(
    l = 50,
    r = 50,
    b = 100,
    t = 100,
    pad = 4
  )
  
  # Draw an interactive babble chart with animation
  babble_plot <- plot_ly(
    modified_df,
    x = ~total_projects,
    y = ~success_rate,
    name = ~main_category,
    frame = ~deadline,
    type = "scatter",
    mode = "markers",
    size = ~total_backers,
    color = ~main_category,
    sizes = c(
      min(modified_df$total_backers) / 200,
      max(modified_df$total_backers) / 200
    ),
    marker = list(
      symbol = "circle",
      sizemode = "area",
      line = list(width = 0)
    ),
    hoverinfo = "text",
    legendgroup = ~main_category,
    text = ~ paste(
      "Category:", main_category,
      "<br>Success Rate:", success_rate,
      "<br>Amount Projects:", total_projects,
      "<br>Amount Backers:", total_backers
    )
  ) %>%
    layout(
      autosize = T, margin = m,
      title = "Success Rates vs. Amount Projects of Each Category",
      font = list(color = "#C0C0C0"),
      xaxis = list(
        title = "Amount Projects",
        color = "#C0C0C0",
        zerolinewidth = 1,
        ticklen = 2,
        gridwidth = 1
      ),
      yaxis = list(
        title = "Success Rates (%)",
        color = "#C0C0C0",
        range = c(0, 100),
        ticklen = 2,
        gridwidth = 1
      ),
      legend = list(font = list(color = "#C0C0C0")),
      paper_bgcolor = "transparent",
      plot_bgcolor = "transparent"
    ) %>%
    animation_slider(
      currentvalue = list(prefix = "YEAR ", font = list(color = "#C0C0C0"))
    )
  return(babble_plot)
}

# Calculate success rate for user chosen sub category, returns an interactive 
# line chart
line_plot <- function(data, input_sub_cate) {
  modified_df <- data %>%
    select(category, state, deadline) %>%
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>%
    filter(category == input_sub_cate) %>%
    group_by(deadline) %>%
    mutate(total_count = n()) %>%
    filter(state == "successful") %>%
    mutate(success = n()) %>%
    mutate(success_rate = round(success / total_count * 100, 1)) %>%
    select(category, success_rate, deadline) %>%
    unique(by = deadline) %>%
    ungroup(deadline) %>%
    arrange(deadline)
  
  # Draw a line plot
  p2 <- plot_ly(
    modified_df,
    x = ~deadline,
    y = ~success_rate,
    type = "scatter",
    mode = "lines+markers",
    colors = "rgb(241, 171, 206)",
    marker = list(color = "rgb(202, 84, 133)")
  ) %>%
    layout(
      autosize = T, margin = m,
      title = paste("Success Rates in Years of", input_sub_cate),
      font = list(color = "#C0C0C0"),
      xaxis = list(
        title = "Years",
        color = "#C0C0C0",
        zerolinewidth = 1,
        ticklen = 2,
        gridwidth = 1
      ),
      yaxis = list(
        title = "Success Rates (%)",
        color = "#C0C0C0",
        ticklen = 2,
        gridwidth = 1
      ),
      paper_bgcolor = "transparent",
      plot_bgcolor = "transparent"
    )
  
  return(p2)
}