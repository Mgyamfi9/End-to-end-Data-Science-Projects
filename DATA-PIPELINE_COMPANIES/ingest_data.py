import csv
import os
import mysql.connector

def create_table_from_csv(cursor, csv_file):
    table_name = os.path.splitext(os.path.basename(csv_file))[0].replace(" ", "_")  # Replace spaces with underscores
    with open(csv_file, 'r') as f:
        reader = csv.reader(f)
        headers = next(reader)  # Assuming the first row contains headers
        create_table_query = f"CREATE TABLE IF NOT EXISTS {table_name} ("
        for header in headers:
            create_table_query += f"{header} VARCHAR(255), "
        create_table_query = create_table_query[:-2]  # Remove trailing comma and space
        create_table_query += ")"
        cursor.execute(create_table_query)

def ingest_csv_data(cursor, csv_file):
    table_name = os.path.splitext(os.path.basename(csv_file))[0].replace(" ", "_")  # Replace spaces with underscores
    with open(csv_file, 'r') as f:
        reader = csv.reader(f)
        next(reader)  # Skip headers
        for row in reader:
            insert_query = f"INSERT INTO {table_name} VALUES ({', '.join(['%s']*len(row))})"
            cursor.execute(insert_query, row)

# MySQL connection configuration
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="MENTHORfire6488",
    database="company_db"
)

if conn.is_connected():
    print("Connected to MySQL database")
    cursor = conn.cursor()

    # Directory where CSV files are located
    csv_directory = "./data"

    # List all CSV files in the directory
    csv_files = [file for file in os.listdir(csv_directory) if file.endswith('.csv')]

    # Create a table for each CSV file and ingest data
    for csv_file in csv_files:
        create_table_from_csv(cursor, os.path.join(csv_directory, csv_file))
        ingest_csv_data(cursor, os.path.join(csv_directory, csv_file))
        print(f"Ingested data from {csv_file} into MySQL database")

    conn.commit()
    cursor.close()
    conn.close()
else:
    print("Failed to connect to MySQL database")
