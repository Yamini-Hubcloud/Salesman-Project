# Salesman-Project
Project Overview: Solving the Travelling Salesman Problem using TAopt in R
This project addresses the Travelling Salesman Problem (TSP), a foundational problem in combinatorial optimization. The objective is to determine the shortest possible route that visits a list of cities exactly once and returns to the starting point. Solving this problem efficiently becomes increasingly difficult as the number of cities grows, making it a well-known challenge in operations research and computer science.

Using R and the NMOF package, this study implements the Threshold Accepting Optimization (TAopt) algorithm to find a near-optimal tour across 48 cities, defined by their (x, y) coordinates. The algorithm seeks to minimize the total Euclidean distance of the tour, including a return leg to the starting city.

The core components of the methodology include:

Distance Function: A custom calculate_distance() function computes the total tour length based on the input order of cities.

Neighbourhood Function: Randomly swaps two cities in the current route to explore nearby solutions.

TAopt Algorithm: Configured with 30,000 search steps, 100 temperature levels, and a linear cooling schedule to explore the solution space. A random seed ensures reproducibility.

The algorithm outputs the best tour distance found, the corresponding city order, and visualizes the path using ggplot2. The best tour coordinates are saved in a CSV file, and a plot is exported as a PNG for reporting purposes.

This project demonstrates how heuristic meta-heuristics like TAopt can be applied effectively to NP-hard problems like the TSP. It provides a practical and visual solution path using real spatial data and highlights the power of R for optimization and visualization.
