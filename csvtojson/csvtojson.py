import pandas as pd

# Path of the CSV file
datapath = r"C:\Users\abram\Downloads\GTF Technical Test\csvtojson\driver_registration.csv"

# Assign column names to the data and read the CSV file
colnames = ['id', 'date_created', 'date_last_modified', 'active_date', 'name', 'phone', 'resign_date', 'resign_reason', 'status', 'tipe', 'area', 'operator', 'modified_by', 'vehicle_type', 'helmet_qty', 'jacket_qty', 'vehicle_brand', 'vehicle_year', 'bike_type', 'first_ride_bonus_awarded', 'is_doc_completed']
data = pd.read_csv(datapath, names=colnames, header=None)

# Build into a dictionary
id = data.id
date_created = data.date_created
date_last_modified = data.date_last_modified
active_date = data.active_date
name = data.name
phone = data.phone
resign_date = data.resign_date
resign_reason = data.resign_reason
status = data.status
tipe = data.tipe
area = data.area
operator = data.operator
modified_by = data.modified_by
vehicle_type = data.vehicle_type
helmet_qty = data.helmet_qty
jacket_qty = data.jacket_qty
vehicle_brand = data.vehicle_brand
vehicle_year = data.vehicle_year
bike_type = data.bike_type
first_ride_bonus_awarded = data.first_ride_bonus_awarded
is_doc_completed = data.is_doc_completed

driverreg = {}
i = 0
while i < len(id):
    driverreg[id[i]] = [
        id[i],
        date_created[i],
        date_last_modified[i],
        active_date[i],
        name[i],
        phone[i],
        resign_date[i],
        resign_reason[i],
        status[i],
        tipe[i],
        area[i],
        operator[i],
        modified_by[i],
        vehicle_type[i],
        helmet_qty[i],
        jacket_qty[i],
        vehicle_brand[i],
        vehicle_year[i],
        bike_type[i],
        first_ride_bonus_awarded[i],
        is_doc_completed[i]
        ]
    i += 1

print(driverreg)