import pandas as pd
import datetime
import re

# Path of the input CSV file
datapath = r"driver_registration.csv"

# Path of the output JSON file
datatarget = r"driver_registration.json"

# Assign column names to the data and read the CSV file
colnames = ['id',
'date_created',
'date_last_modified',
'active_date',
'name',
'phone',
'resign_date',
'resign_reason',
'status',
'tipe',
'area',
"CONCAT('operator_',id)",
'modified_by',
'vehicle_type',
'helmet_qty',
'jacket_qty',
'vehicle_brand',
'vehicle_year',
'bike_type',
'first_ride_bonus_awarded',
'is_doc_completed']
data = pd.read_csv(datapath, names=colnames, header=None)

# Take all dates and reformat with a timezone
date_split = re.split('[- :]', data['date_created'][0])
date_prep = []  
for i in date_split:
    date_prep.append(int(i))
date_reformat = datetime.datetime(date_prep[0], date_prep[1], date_prep[2], date_prep[3], date_prep[4], date_prep[5])
date_reformatted = date_reformat.strftime('%Y-%m-%dT%H:%M:%SZ')
print(date_reformatted)

# Take all phone numbers and prepend a '+' string
data['phone'] = "+" + data['phone'].astype(str)

# Take all first_ride_bonus_awarded values and prepend a '+' string
data['first_ride_bonus_awarded'] = data['first_ride_bonus_awarded'].replace({'\\0' : '\u0000'})

# Format data into a JSON file
data.to_json(datatarget, indent = 2, orient = 'records')