plot_techs <- function(data, ...) {
  # TODO: label needs to change based on sector and technology
  ylabel <- if (unique(data$sector) == "Power") {
    "Power Capacity (GW)"
  } else if (unique(data$sector) == "Coal") {
    "Tonnes of Coal (tonnes)"
  } else if (unique(data$sector) == "Oil&Gas" & unique(data$technology) == "Gas") {
    "Upstream Gas (GJ)"
  } else if (unique(data$sector) == "Oil&Gas" & unique(data$technology) == "Oil") {
    "Upstream Oil (GJ)"
  } else {"Unkonwn Unit"}

  p <- plot_waterfall(data) +
    labs(x = "", y = ylabel, title = unique(data$technology)) +
    theme(axis.text = element_text(angle = 90, hjust = 1))

  p <- suppressMessages(
    p + scale_x_discrete(labels = format_category(data$category))
  )

  p + theme(...)
}

format_category <- function(x) {
  x <- gsub("before", "year 0", x)
  x <- gsub("after", "year 1", x)
  tools::toTitleCase(x)
}
