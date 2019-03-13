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
find_rate <- function(data, input_year) {
  modified_df <- data %>%
    select(main_category, state, deadline, backers) %>%
    mutate(deadline = as.numeric(substring(deadline, 1, 4))) %>%
    group_by(main_category) %>%
    filter(deadline == input_year) %>%
    mutate(total_projects = n(), total_backers = sum(backers)) %>%
    filter(state == "successful") %>%
    mutate(success = n()) %>%
    mutate(success_rate = round(success / total_projects * 100, 1)) %>%
    select(main_category, success_rate, total_projects, total_backers) %>%
    unique(by = main_category) %>%
    arrange(success_rate)
  
  
  babble_plot <- plot_ly(
    modified_df,
    x = ~total_projects,
    y = ~success_rate,
    name = ~main_category,
    type = "scatter",
    mode = "markers",
    size = ~total_backers,
    color = ~main_category,
    colors = "Paired",
    sizes = c(min(modified_df$total_backers) / 200,
              max(modified_df$total_backers) / 200),
    marker = list(
      symbol = "circle", opacity = 0.7, sizemode = "area",
      line = list(width = 2, color = "#FFFFFF")
    ),
    hoverinfo = "text",
    legendgroup = ~main_category,
    text = ~paste(
      "Category:", main_category,
      "<br>Success Rate:", success_rate,
      "<br>Amount Projects:", total_projects,
      "<br>Amount Backers:", total_backers
    )
  ) %>%
    layout(
      title = "Amount Projects vs. Success Rates of Each Category",
      font = list(color = "#C0C0C0"),
      xaxis = list(
        title = "Amount Projects",
        color = "#C0C0C0", 
        zerolinewidth = 1,
        ticklen = 2,
        gridwidth = 2
      ),
      yaxis = list(
        title = "Success Rates (%)",
        color = "#C0C0C0",
        range = c(0, 110),
        ticklen = 2,
        gridwidth = 2
      ),
      legend = list(font = list(color = "#C0C0C0")),
      paper_bgcolor = "#010402",
      plot_bgcolor = "#010402"
    )
  return(babble_plot)
}

test_df <- find_rate(ks_data, 2016)

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

p2 <- plot_ly(
  test_line,
  x = ~deadline,
  y = ~success_rate,
  type = "scatter",
  mode = "lines+markers"
)
p2