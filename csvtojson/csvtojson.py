import pandas as pd

# Path of the input CSV file
datapath = r"driver_registration.csv"

# Path of the output JSON file
datatarget = r"driver_registration.json"

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
    driverreg[i] = [
        {"id": id[i]},
        {"date_created": date_created[i]},
        {"date_last_modified": date_last_modified[i]},
        {"active_date": active_date[i]},
        {"name": name[i]},
        {"phone": phone[i]},
        {"resign_date": resign_date[i]},
        {"resign_reason": resign_reason[i]},
        {"status": status[i]},
        {"tipe": tipe[i]},
        {"area": area[i]},
        {"operator": operator[i]},
        {"modified_by": modified_by[i]},
        {"vehicle_type": vehicle_type[i]},
        {"helmet_qty": helmet_qty[i]},
        {"jacket_qty": jacket_qty[i]},
        {"vehicle_brand": vehicle_brand[i]},
        {"vehicle_year": vehicle_year[i]},
        {"bike_type": bike_type[i]},
        {"first_ride_bonus_awarded": first_ride_bonus_awarded[i]},
        {"is_doc_completed": is_doc_completed[i]}
        ]
    i += 1

#print(driverreg)

df_driverreg = pd.DataFrame(driverreg)
df_driverreg.to_json(datatarget, indent = 4)