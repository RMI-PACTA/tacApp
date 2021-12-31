plot_waterfall <- function(data, type_order = NULL, type_colours = NULL) {
  type_order <- type_order %||% c("total", "virtual", "real", "unknown")
  type_colours <- type_colours %||% c("dark_blue", "orange", "green", "grey")

  r2dii_colours <- palette_colours() %>%
    filter(.data$label %in% type_colours) %>%
    arrange(factor(.data$label, levels = type_colours))

  cols <- tibble(type = type_order, label = type_colours) %>%
    dplyr::left_join(r2dii_colours, by = "label") %>%
    select(.data$type, .data$colour_hex)

  ggplot(data, aes(category, fill = factor(type, levels = type_order))) +
    geom_rect(aes(xmin = id - 0.45, xmax = id + 0.45, ymin = end, ymax = start)) +
    scale_x_discrete(labels = data$category) +
    scale_y_continuous(sec.axis = dup_axis()) +
    scale_fill_manual(values = setNames(cols$colour_hex, cols$type)) +
    theme_2dii() +
    theme(axis.line.x = element_blank()) +
    theme(axis.ticks.x = element_blank()) +
    theme(axis.title.y.left = element_text(margin = unit(c(0, 0.4, 0, 0.4), "cm"))) +
    theme(axis.title.y.right = element_text(margin = unit(c(0, 0.4, 0, 0.4), "cm"))) +
    theme(legend.position = "bottom")
}

# styler: off
palette_colours <- function() {
  # From r2dii.plot:::palette_colours to avoid dependency on internal object
  tribble(
         ~label, ~colour_hex,
    "dark_blue",   "#1b324f",
        "green",   "#00c082",
       "orange",   "#ff9623",
         "grey",   "#d0d7e1",
  "dark_purple",   "#574099",
       "yellow",   "#f2e06e",
    "soft_blue",   "#78c4d6",
     "ruby_red",   "#a63d57",
   "moss_green",   "#4a5e54"
  )
}
# styler: on
