from datetime import timedelta

import numpy as np
import pandas as pd
import xarray as xr
from matplotlib import pyplot as plt

data = pd.read_csv('hurricane_data_after2000.csv', sep=',', na_values=[-9999.0, -99.0, 'nan'])

data['ISO_TIME'] = pd.to_datetime(data['ISO_TIME'])

data = data.set_index('ISO_TIME')

basin = data.BASIN.unique()
subbasin = data.SUBBASIN.unique()
nature = data.NATURE.unique()
print(basin)
print(subbasin)
print(nature)

data = data.rename(columns={"WMO_WIND": "WIND", "WMO_PRES": "PRES"})

fast_wind = data['WIND'].nlargest(10)
print(fast_wind)


hurr_wind = data.groupby("SID", group_keys=True)[['WIND']].max()
print(hurr_wind['WIND'].nlargest(10))

fig1 = plt.figure()
hurr_wind['WIND'].nlargest(20).plot(kind='bar')

count = data['BASIN'].value_counts()
fig2 = plt.figure()
count.plot(kind='bar')

hurrcount = data.groupby('BASIN')['SID'].nunique()
fig6 = plt.figure()
hurrcount.plot(kind='bar')

fig3 = plt.figure()
data.plot.hexbin(x='LAT', y='LON', gridsize=75, cmap='viridis')


fig4 = plt.figure()
dat_yy = data.resample('Y').count()
dat_yy['WIND'].plot()

fig5 = plt.figure()
dat_yy = data.resample('D').count()
dat_doy = dat_yy.groupby(dat_yy.index.dayofyear).mean()
dat_yy['WIND'].plot()