try:
  import sqlite3
except ImportError:
  print("Error: sqlite3 module not found. This is a built-in Python module. Please ensure you're using a Python environment with the correct libraries installed.")
  exit()
  
con = sqlite3.connect("Database Creation/PediatricLabeling.db")
cur = con.cursor()

sql_commands = open('Analytics/Scripts/queries.sql', mode = 'r').read().split(';')
for sql_command in sql_commands:
    if sql_command.strip():  # Check if the command is not empty
        cur.execute(sql_command)
        result = cur.fetchall()
        
        if cur.description:
            # Retrieve and print the column names, separated by |
            column_names = [description[0] for description in cur.description]
            print(" | ".join(column_names))
        
        # Print the rows, separated by |
        for row in result:
            print(" | ".join(map(str, row)))

        print()

con.close()