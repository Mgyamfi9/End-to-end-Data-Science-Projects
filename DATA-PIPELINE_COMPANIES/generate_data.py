import pandas as pd
from faker import Faker
import os 
import random

fake = Faker()

def generate_company_data_csv(company_name):
    company_data = []

    # Generate data for the company
    for _ in range(10_000):
        name = fake.name()
        address = fake.address()
        transaction_id = fake.uuid4()
        amount = fake.random_number(digits=4)
        timestamp = fake.date_time_this_year()
        app_preference = random.choice(["mobile application", "web application"])
        communication_method = random.choice(["email", "phone call", "in person"])
        email = fake.email()

        company_data.append({
            "name": name,
            "address": address,
            "transaction_id": transaction_id,
            "amount": amount,
            "timestamp": timestamp,
            "app_preference": app_preference,
            "communication_method": communication_method,
            "email": email
        })

    # Convert list of dictionaries to pandas DataFrame
    df = pd.DataFrame(company_data)


    directory = "data"
    if not os.path.exists(directory):
       os.makedirs(directory)

    file_name = os.path.join(directory, f"{company_name}_data.csv")
    df.to_csv(file_name,index=False)

    print(f"Data generated and saved to {file_name}")
    # Save DataFrame to CSV file



companies =  [

"Enterprise Life",

"Glico General ",

"Standard Chartered ",

"Activa Int. Insurance Co Gh Ltd"

"Swami India Ghana Ltd",

"Zenith Bank Ghana Limited",

"Acacia Health Insurance ",

"Juaben Rural Bank Ltd"

]

for company in companies:
    generate_company_data_csv(company)
