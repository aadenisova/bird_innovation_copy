import pandas as pd
import numpy as np
from sys import argv

chrom = argv[1]
df = pd.read_csv('maf_counts2/{}.csv'.format(chrom))
df[df[['cons', 'inno', 'non_inno']].any(axis=1)].to_csv('maf_counts2_filter/{}.csv'.format(chrom), index = False)