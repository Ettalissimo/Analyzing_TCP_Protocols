import matplotlib.pyplot as plt

# Data points for NewReno Loss Ratio
newreno_loss_ratio = [100.0, 80.0, 4.511278, 18.307906, 18.580766, 15.206727, 13.345091, 12.201964, 10.867007, 9.627119, 8.884236, 8.566058, 8.123318, 8.722603, 9.040362, 8.605228, 8.013444, 8.225539, 7.951883, 7.447125]

# Data points for NewVegas Loss Ratio
newvegas_loss_ratio = [100.0, 100.0, 2.928870, 1.757812, 1.295337, 23.076923, 39.475713, 35.767410, 38.842482, 39.915074, 35.394054, 32.977360, 35.102673, 41.510818, 43.854936, 47.237916, 46.552234, 43.475862, 44.798962, 43.604651]

# Time points
time_points = range(0, 600, 30)

# Create the plot
plt.figure(figsize=(10, 6))

# Plot NewReno Loss Ratio
plt.plot(time_points, newreno_loss_ratio, label='NewReno Loss Ratio', marker='o', linestyle='-')

# Plot NewVegas Loss Ratio
plt.plot(time_points, newvegas_loss_ratio, label='NewVegas Loss Ratio', marker='s', linestyle='-')

# Set labels and title
plt.xlabel('Temps')
plt.ylabel('Ratio de pertes \"Loss Ratio\"')
plt.title('Ratio de pertes de NewReno et NewVegas au fil du temps')

# Add legend
plt.legend()

# Grid
plt.grid(False)

# Ajuster le pas de graduation de l'axe des abscisses
plt.xticks(time_points)

# Show the plot
plt.show()
