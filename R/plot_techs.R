plot_techs <- function(data) {
  p <- plot_waterfall(data) +
    labs(x = "", y = "Power Capacity (GW)", title = unique(data$technology)) +
    theme(axis.text = element_text(angle = 90, hjust = 1))

  p <- suppressMessages(
    p + scale_x_discrete(labels = format_category(data$category))
  )

  p + theme(legend.position = "right")
}

format_category <- function(x) {
  x <- gsub("before", "year 0", x)
  x <- gsub("after", "year 1", x)
  tools::toTitleCase(x)
}
