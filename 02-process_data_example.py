import pandas as pd

status = pd.read_csv("data/station_status.csv")
info = pd.read_csv("data/station_info.csv")

status['time_dt'] = pd.to_datetime(status['time'])
status['hour'] = status['time_dt'].dt.hour
status['date'] = status['time_dt'].dt.date
status['month'] = status['time_dt'].dt.month
status['dow'] =  status['time_dt'].dt.day_name()

availability = status.groupby(['station_id', 'date', 'month', 'dow', 'hour']).agg({'num_bikes_available': 'mean'}).reset_index()
availability.head()


availability.to_csv("data/availability.csv", index=False)
