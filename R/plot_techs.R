plot_techs <- function(data, fmt_category = format_category) {
  p <- plot_waterfall(data) +
    labs(x = "", y = "Power Capacity (GW)", title = unique(data$technology)) +
    theme(axis.text = element_text(angle = 90, hjust = 1))

  p <- suppressMessages(
    p + scale_x_discrete(labels = fmt_category(data$category))
  )

  p
}

format_category <- function(x) {
  x <- gsub("before", "year 0", x)
  x <- gsub("after", "year 1", x)
  tools::toTitleCase(x)
}
