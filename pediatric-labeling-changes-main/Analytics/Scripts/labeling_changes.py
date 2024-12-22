
try:
  import sqlite3
except ImportError:
  print("Error: sqlite3 module not found. This is a built-in Python module. Please ensure you're using a Python environment with the correct libraries installed.")
  exit()

try:
  import pandas as pd
except ImportError:
  print("Error: pandas library not found. Please install it using 'pip install pandas'.")
  exit()

try:
  import matplotlib.pyplot as plt
except ImportError:
  print("Error: matplotlib library not found. Please install it using 'pip install matplotlib'.")
  exit()

con = sqlite3.connect("Database Creation/PediatricLabeling.db")
cur = con.cursor()

# Fetch the data for the chart
query = """
SELECT strftime('%Y', ApprovalDate) AS Year, COUNT(*) AS Count
FROM Cohort
GROUP BY Year
ORDER BY Year;
"""
data = pd.read_sql_query(query, con)

# Close the database connection
con.close()
# Convert the 'Year' column to numeric

data['Year'] = pd.to_numeric(data['Year'])

# Check for non-numeric or missing values in the 'Count' column
data['Count'] = pd.to_numeric(data['Count'], errors='coerce')
data = data.dropna(subset=['Count'])
data.dropna(inplace=True)
data['Year'] = data['Year'].astype(int)

# Calculate regression line endpoints
x_min, x_max = data['Year'].min(), data['Year'].max()

# Calculate slope (m) and intercept (b) for the regression line
n = len(data)
sum_x = sum(data['Year'])
sum_y = sum(data['Count'])
sum_x_sq = sum(data['Year']**2)
sum_xy = sum(data['Year'] * data['Count'])

m = (n * sum_xy - sum_x * sum_y) / (n * sum_x_sq - sum_x**2)
b = (sum_y - m * sum_x) / n

# Calculate y-values for the regression line at x_min and x_max
y_min_fit = m * x_min + b
y_max_fit = m * x_max + b

# Plot the data
fig, ax = plt.subplots(figsize=(12, 6))

# Create the bar plot
bars = ax.bar(data['Year'], data['Count'], color = '#007CBA', width = 0.4)

# Plot the trend line using the endpoints
plt.plot([x_min, x_max], [y_min_fit, y_max_fit], color='#007CBA', linestyle= 'dotted')

# Set the x-ticks to the center of each bar
ax.set_xticks([bar.get_x() + bar.get_width() / 2 for bar in bars])
ax.set_xticklabels(data['Year'])

ax.set_xlabel('Year')
plt.title('Increasing number of pediatric labeling changes for drugs and biologics pursuant to the\nPediatric Research Equity Act, Best Pharmaceuticals for Children Act, and Pediatric Rule', fontsize=16)
plt.xlabel('Year', fontsize=14)
plt.ylabel('Number of Labeling Changes', fontsize=14)
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig('Analytics/Images/LabelingChangesPerYear.png', format='png')
plt.show()

#When you search in the excel, they only have 11 labeling changes with 2007 and 2007 is also the earliest it goes. This means that the excels do not have all the data.

con.close()