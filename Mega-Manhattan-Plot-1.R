Author: Mara Krenn

#packages:
library(ggplot2)
library(dplyr)

#set right chromosome lengths
chromosome_lengths <- data.frame(
  CHR = 1:9,  # Adjust this according to your chromosome numbers
  length_bp = c(252000000, 236000000, 325000000, 410000000, 372000000, 207000000, 210000000, 344000000, 230000000)  # Replace with actual lengths in base pairs
)

# Merge the lengths with the data
data <- merge(data, chromosome_lengths, by = "CHR")

# Normalize positions by dividing by 1e6 to convert to Mbp
data <- data %>% mutate(POS_adjusted_Mbp = POS / 1e6)


# Create the plot
ggplot(data, aes(x = POS_adjusted_Mbp, y = trait, color = lod/10000)) +
  geom_point(size = 2) +
  scale_color_gradient(low = "green", high = "red") +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.background = element_rect(color = "gray50", fill = "gray90"),
    strip.text = element_text(face = "bold"),
    panel.border = element_rect(color = "gray50", fill = NA, size = 0.5)
  ) +
  facet_wrap(~ CHR, nrow = 1, scales = "free_x") + 
  labs(
    x = "Position (Mbp)",
    y = "Phenotype",
    color = "LOD"
  ) +
  # Set x-axis limits based on chromosome lengths
  geom_blank(aes(x = length_bp / 1e6))  # This ensures that each facet respects the chromosome length
