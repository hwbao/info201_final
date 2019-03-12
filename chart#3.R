library("shiny")
library("plotly")
library("dplyr")
library("lubridate")
ks_data <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)
# use for test
cat_num <- ks_data %>%
  select(main_category, state, deadline, backers) %>%
  mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>%
  filter(deadline == 2016) %>%
  group_by_("main_category") %>%
  mutate(total = sum(backers)) %>%
  filter(state == "successful") %>%
  mutate(num_count = n())

# rate for all main category, create an interactive babble chart
find_rate <- function(data, input_category, input_year) {
  modified_df <- data %>%
    select(input_category, state, deadline, backers) %>%
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>%
    group_by_(input_category) %>%
    filter(deadline == input_year) %>%
    mutate(total_projects = n(), total_backers = sum(backers)) %>%
    filter(state == "successful") %>%
    mutate(success = n()) %>%
    mutate(success_rate = round(success / total_projects * 100, 1)) %>%
    select(input_category, success_rate, total_projects, total_backers) %>%
    unique(by = input_category) %>%
    arrange(success_rate)
  
  
  babble_plot <- plot_ly(
    modified_df,
    x = ~success_rate,
    y = ~total_projects,
    name = ~main_category,
    type = "scatter",
    mode = "markers",
    size = ~total_backers,
    color = ~main_category,
    colors = "Paired",
    sizes = c(min(test_df$total_backers) / 300, max(test_df$total_backers) / 300),
    marker = list(
      symbol = "circle", opacity = 0.7, sizemode = "area",
      line = list(width = 2, color = "#FFFFFF")
    ),
    hoverinfo = "text",
    lengendgroup = ~main_category,
    text = ~ paste(
      "Category:", main_category,
      "<br>Success Rate:", success_rate,
      "<br>Amount Projects:", total_projects,
      "<br>Amount Backers:", total_backers
    )
  ) %>%
    layout(
      title = "Success Rates vs. Amount Projects of Each Category",
      font = list(color = "#C0C0C0"),
      xaxis = list(
        title = "Success Rates (%)",
        color = "#C0C0C0", 
        range = c(0, 110),
        zerolinewidth = 1,
        ticklen = 2,
        gridwidth = 2
      ),
      yaxis = list(
        title = "Amount Projects",
        color = "#C0C0C0",
        ticklen = 2,
        gridwidth = 2
      ),
      legend = list(font = list(color = "#C0C0C0")),
      paper_bgcolor = "#010402",
      plot_bgcolor = "#010402"
    )
  babble_plot
}

test_df <- find_rate(ks_data, "main_category", 2016)

# every years success rate for each sub category
find_line <- function(data, sub_category) {
  modified_df <- data %>%
    select(category, state, deadline) %>%
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>%
    group_by(deadline) %>%
    filter(category == sub_category) %>%
    mutate(total_count = n()) %>%
    filter(state == "successful") %>%
    mutate(success = n()) %>%
    mutate(success_rate = round(success / total_count * 100, 1)) %>%
    select(category, success_rate, deadline) %>%
    unique(by = deadline) %>%
    ungroup(deadline) %>%
    arrange(deadline)
}

test_line <- find_line(ks_data, "Drinks")

# interactive babble chart, color needs adjust
p1 <- plot_ly(
  test_df,
  x = ~success_rate,
  y = ~total_projects,
  name = ~main_category,
  type = "scatter",
  mode = "markers",
  size = ~total_backers,
  color = ~main_category,
  colors = "Paired",
  sizes = c(min(test_df$total_backers) / 300, max(test_df$total_backers) / 300),
  marker = list(
    symbol = "circle", opacity = 0.7, sizemode = "area",
    line = list(width = 2, color = "#FFFFFF")
  ),
  hoverinfo = "text",
  lengendgroup = ~main_category,
  text = ~ paste(
    "Category:", main_category,
    "<br>Success Rate:", success_rate,
    "<br>Amount Projects:", total_projects,
    "<br>Amount Backers:", total_backers
  )
) %>%
  layout(
    title = "Success Rates vs. Amount Projects of Each Category",
    font = list(color = "#C0C0C0"),
    xaxis = list(
      title = "Success Rates (%)",
      color = "#C0C0C0", 
      range = c(0, 110),
      zerolinewidth = 1,
      ticklen = 2,
      gridwidth = 2
    ),
    yaxis = list(
      title = "Amount Projects",
      color = "#C0C0C0",
      ticklen = 2,
      gridwidth = 2
    ),
    legend = list(font = list(color = "#C0C0C0")),
    paper_bgcolor = "#010402",
    plot_bgcolor = "#010402"
  )
p1

# unfinished line chart
p2 <- plot_ly(
  test_line,
  x = ~deadline,
  y = ~success_rate,
  type = "scatter",
  mode = "lines+markers"
)
p2




modified_df$"input_category" <- factor(modified_df$"input_category",
  levels = c(as.character(modified_df$"input_category"))
)

p <- plot_ly(
  modified_df,
  x = "input_category",
  y = ~success_rate,
  name = "Race chart",
  type = "bar"
  # marker = list(color = input$colors)
) %>%
  layout(
    title = paste("Success Rate vs. Different Main Category in ", input_year),
    yaxis = list(title = "Success Rate (%)"),
    xaxis = list(title = "Category")
  )

return(p)
