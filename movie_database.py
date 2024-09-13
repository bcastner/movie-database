import mysql.connector


# Establish connection
conn = mysql.connector.connect(
    host='localhost',
    user='nativeuser',
    password='Devils14*',
    database='movie_database'
)

cursor = conn.cursor()

# Execute query
query = "SELECT title, release_year FROM Movies WHERE release_year > %s"
year = (2010,)
cursor.execute(query, year)

# Fetch results
results = cursor.fetchall()
for row in results:
    print(f"Title: {row[0]}, Year: {row[1]}")

# Close connection
cursor.close()
conn.close()
