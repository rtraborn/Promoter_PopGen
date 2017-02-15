import pandas as pd
import glob

broad = pd.read_csv('broad.csv')
peak = pd.read_csv('peak.csv')
uncategorized = pd.read_csv('uncategorized.csv')

compare = broad.append(peak).append(uncategorized)

bed = pd.read_csv('bed.txt', sep = ' ', header = None)
del bed[0]
del bed[3]
del bed[4]
del bed[5]
del bed[8]
del bed[9]
del bed[10]
del bed[11]


for name in ['all_h_dpgp3_sequences.csv']:#glob.glob('all*'):
	print name

	ages = pd.read_csv(name, sep = ',', header = None)
	ages['shape_c'] = 0.0
	ages['shape_d'] = 0 

	count = 1
	for a,b in ages.iterrows():
		#index = bed[bed[6] == b[1]].index[0]
		#c = (bed.ix[index][1], bed.ix[index][2])
		c = (b[1],b[2])


		value = float(compare[(compare.start == c[0]) & ((compare.end == c[1]))]['shape.index'])
		ages.set_value(a, 'shape_c', value)

		if value == 2.0:
			ages.set_value(a, 'shape_d', 1)
		elif value <= 0.47057:
			ages.set_value(a, 'shape_d', -1)
		count +=1
		print count

	ages.to_csv(str(name)[6:10]+'.csv')