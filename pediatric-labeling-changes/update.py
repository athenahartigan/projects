try:
  import subprocess
except ImportError:
  print("Error: subprocess module not found. This is a built-in Python module. Please ensure you're using a Python environment with the correct libraries installed.")
  exit()
  
# Update the database
subprocess.run(["python", "data_load.py"])

# Update the graph
subprocess.run(["python", "labeling_changes.py"])

while True:
  queries = input("Would you like to run the queries? (y/n): ")
  if queries == "y":
    subprocess.run(["python", "queries.py"])
    break
  elif queries == "n":
    break
  else:
    print("Invalid input. Please enter 'y' or 'n'.")