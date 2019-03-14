# load package
library(dplyr)
library(plotly)

# Read the data about kickstarter and convert it into a dataframe
kickstarter <- read.csv("data/ks_projects_201801.csv", stringsAsFactors = F)

# Build the function to graph a sankey diagram which demonstrate where did the
# pledged in each main category go (to which top three amount pledged category).
draw_sankey_graph <- function(kickstarter) {
  # create my own color vector for the link line of the sankey diagram
  my_color <- c(
    "rgb(241, 188, 172)", "rgb(241, 188, 172)", "rgb(241, 188, 172)",
    "rgb(241, 171, 206)", "rgb(241, 171, 206)", "rgb(241, 171, 206)",
    "rgb(223, 172, 240)", "rgb(223, 172, 240)", "rgb(223, 172, 240)",
    "rgb(170, 172, 240)", "rgb(170, 172, 240)", "rgb(170, 172, 240)",
    "rgb(128, 162, 227)", "rgb(128, 162, 227)", "rgb(128, 162, 227)",
    "rgb(167, 129, 226)", "rgb(167, 129, 226)", "rgb(167, 129, 226)",
    "rgb(227, 129, 211)", "rgb(227, 129, 211)", "rgb(227, 129, 211)",
    "rgb(227, 127, 137)", "rgb(227, 127, 137)", "rgb(227, 127, 137)",
    "rgb(202, 84, 133)", "rgb(202, 84, 133)", "rgb(202, 84, 133)",
    "rgb(183, 87, 202)", "rgb(183, 87, 202)", "rgb(183, 87, 202)",
    "rgb(92, 86, 201)", "rgb(92, 86, 201)", "rgb(92, 86, 201)",
    "rgb(86, 164, 202)", "rgb(86, 164, 202)", "rgb(86, 164, 202)",
    "rgb(54, 179, 178)", "rgb(54, 179, 178)", "rgb(54, 179, 178)",
    "rgb(47, 81, 176)", "rgb(47, 81, 176)", "rgb(47, 81, 176)",
    "rgb(111, 52, 176)", "rgb(111, 52, 176)", "rgb(111, 52, 176)",
    "rgb(177, 50, 144)", "rgb(177, 50, 144)", "rgb(177, 50, 144)",
    "rgb(142, 51, 151)", "rgb(142, 51, 151)", "rgb(142, 51, 151)",
    "rgb(63, 50, 151)", "rgb(63, 50, 151)", "rgb(63, 50, 151)",
    "rgb(49, 110, 151)", "rgb(49, 110, 151)", "rgb(49, 110, 151)",
    "rgb(52, 152, 118)", "rgb(52, 152, 118)", "rgb(52, 152, 118)"
  )

  # filter the data to keep only main category and their top three small 
  # category with their pledged amount
  new_data <- kickstarter %>%
    dplyr::filter(main_category != category) %>%
    dplyr::group_by(main_category, category) %>%
    dplyr::summarize(category_pledged = sum(usd_pledged_real)) %>%
    dplyr::mutate(hoverinfo = paste0(
      "The amount ",
      category,
      "received from backers are ",
      category_pledged
    )) %>%
    top_n(3, wt = category_pledged)

  # to give specific number to main_category
  new_data$fac_main_cate <- as.numeric(factor(new_data$main_category)) - 1

  # arrange the data with order
  arrange_data <- new_data %>%
    arrange(fac_main_cate)

  # give different category their own code, and make sure they are not same
  # witht the main category code
  arrange_data$fac_cate <- as.numeric(factor(arrange_data$category)) +
    length(unique(arrange_data$main_category)) - 1

  # build the color into data frame so we can give the link of 
  # same main category the same color
  arrange_data$color <- my_color[0:45]

  #draw the sankey graph with the plotly
  draw_graph <- plot_ly(
    type = "sankey",
    domain = list(x = c(0, 1), y = c(0, 1)),
    orientation = "h",

    textfont = list(
      size = 16,
      color = "rgb(194, 202, 214)",
      family = "Roboto"
    ),
    opacity = 0,

    #create each node
    node = list(
      # label = c(new_data$fac_main_cate, new_data$fac_cate),
      # label = 0:34, # works!
      label = c(
        unique(arrange_data$main_category),
        sort(unique(arrange_data$category),
          decreasing = F
        )
      ),
      pad = 15,
      thickness = 25,
      color = "transparent",
      line = list(color = "transparent", width = 0.5)
    ),

    # create each node and give them color and hover infomation
    link = list(
      source = arrange_data$fac_main_cate,
      target = arrange_data$fac_cate,
      value = arrange_data$category_pledged,
      label = arrange_data$hoverinfo,
      color = arrange_data$color
    )
  ) %>%
    layout(
      title = "Total Pledged(USD) Within Each Category and
      its top 3 Distribution to Sub Categories",
      font = list(
        size = 11,
        color = "#C0C0C0"
      ),
      autosize = T,
      xaxis = list(showgrid = T, zeroline = T, showticklabels = F),
      yaxis = list(showgrid = F, zeroline = F, showticklabels = F),
      plot_bgcolor = "transparent",
      paper_bgcolor = "transparent"
    )
  return(draw_graph)
}