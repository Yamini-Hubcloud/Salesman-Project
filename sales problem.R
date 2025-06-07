# ----------------------------------------
# Travelling Salesman Problem (TSP) using TAopt
# ----------------------------------------

# Load required package
if (!require("NMOF")) install.packages("NMOF")
library(NMOF)

# ----------------------------------------
# Define Coordinates of Cities
# ----------------------------------------
coords <- data.frame(
  x = c(6734,2233,5530,401,3082,7608,7573,7265,6898,1112,5468,5989,4706,4612,6347,
        6107,7611,7462,7732,5900,4483,6101,5199,1633,4307,675,7555,7541,3177,7352,
        7545,3245,6426,4608,23,7248,7762,7392,3484,6271,4985,1916,7280,7509,10,
        6807,5185,3023),
  y = c(1453,10,1424,841,1644,4458,3716,1268,1885,2049,2606,2873,2674,2035,2683,
        669,5184,3590,4723,3561,3369,1110,2182,2809,2322,1006,4819,3981,756,4506,
        2801,3305,3173,1198,2216,3779,4595,2244,2829,2135,140,1569,4899,3239,2676,
        2993,3258,1942)
)

# ----------------------------------------
# Objective Function: Total Tour Distance
# ----------------------------------------
calculate_distance <- function(order, coords) {
  coords_ordered <- coords[order, ]
  dists <- sqrt(diff(coords_ordered$x)^2 + diff(coords_ordered$y)^2)
  dists <- c(dists, sqrt((coords_ordered[1,1] - coords_ordered[nrow(coords),1])^2 +
                           (coords_ordered[1,2] - coords_ordered[nrow(coords),2])^2))
  sum(dists)
}

# ----------------------------------------
# Neighbourhood Function: Swap 2 cities
# ----------------------------------------
neighbour_swap <- function(x) {
  i <- sample(seq_along(x), 2)
  x[c(i[1], i[2])] <- x[c(i[2], i[1])]
  x
}

# ----------------------------------------
# Run Tabu Search Optimization
# ----------------------------------------
set.seed(40457994)  # Reproducible results

start_time <- Sys.time()
TA_result <- TAopt(
  OF = function(i) calculate_distance(i, coords),
  algo = list(
    neighbour = neighbour_swap,
    x0 = sample(1:nrow(coords)),  # Initial random tour
    nS = 30000,                   # Search steps
    nT = 100,                     # Number of temperature levels
    tau = seq(2000, 0, length.out = 100)
  )
)
end_time <- Sys.time()

# ----------------------------------------
# Output Best Result
# ----------------------------------------
cat("\n🔹 Best Tour Distance Found:", round(TA_result$OFvalue, 2), "units\n")
cat("🔹 Best Order of Cities:\n")
print(TA_result$xbest)
cat("🔹 Elapsed Time:", round(difftime(end_time, start_time, units = "secs"), 2), "\n")

# ----------------------------------------
# Save Best Tour Coordinates
# ----------------------------------------
best_tour_coords <- coords[TA_result$xbest, ]
write.csv(best_tour_coords, "best_tour_coords.csv", row.names = FALSE)

# ----------------------------------------
# Plot Best Tour
# ----------------------------------------
# Add labels for the plot
tour <- rbind(best_tour_coords, best_tour_coords[1, ])  # Close loop
tour$city <- c(TA_result$xbest, TA_result$xbest[1])     # Add labels

# Plot with ggplot2
ggplot(tour, aes(x = x, y = y)) +
  geom_path(color = "blue", linewidth = 1.2, arrow = arrow(type = "closed", length = unit(0.2, "cm"))) +
  geom_point(color = "red", size = 3) +
  geom_text_repel(aes(label = city), size = 3, max.overlaps = 50) +
  ggtitle("📍 Best Tour Found using TAopt (TSP)") +
  xlab("X") + ylab("Y") +
  theme_minimal()

#Save Plot
ggsave("best_tour_plot.png", width = 8, height = 6)
