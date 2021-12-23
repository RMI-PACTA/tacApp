plot_techs <- function(data) {
  plot_waterfall(data) +
    labs(x = "", y = "Power Capacity (GW)", title = unique(data$technology)) +
    theme(axis.text = element_text(angle = 90, hjust = 1))
}
