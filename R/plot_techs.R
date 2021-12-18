plot_techs <- function(data) {
  plot_waterfall(data) +
    facet_wrap(vars(.data$technology)) +
    xlab("") +
    ylab("Power Capacity (GW)") +
    # TODO: Ask where to get company name. The data seems to have only company id
    theme(axis.text = element_text(angle = 90, hjust = 1))
}
