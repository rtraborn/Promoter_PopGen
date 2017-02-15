import pandas as pd

df = pd.read_csv('data.txt', sep = '\t')
del df['chr']
del df['strand']
del df['nr_ctss']
del df['dominant_ctss']
del df['tpm']
del df['tpm_dom_ctss']
del df['tss.num']
del df['nCTSSs']
del df['nTSSs']
del df['cluster']

print df.quantile(q = 0.9)
print df.quantile(q = 0.1)

# a = df[df['shape.index'] == 2.0]
# a.to_csv('peak.csv', index = False)

# a = df[df['shape.index'] <= .47057]
# a.to_csv('broad.csv', index = False)

# a = df[df['shape.index'] <= .47057]
# a.to_csv('broad.csv', index = False)