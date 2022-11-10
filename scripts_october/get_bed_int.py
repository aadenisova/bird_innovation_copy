from sys import argv
import numpy as np
import pandas as pd

chrom = argv[1] #'NW_024545460.1.maf'
path = argv[2] #'wig_by_chrom/'
path_final = argv[3] #'wig_by_chrom_final/'
path_interval = argv[4] #'intervals_by_chrom', куда в итоге будешь сохранять файлы

"""
Чтение файла .wig с посчитанными scor'ами 
для каждого нуклеотида
"""

def rates_open(path, type_wig=None):
    if type_wig=='base-by-base':
        names = ['null_scale', 'alt_scale', 'alt_subscale', 'lnlratio', 'pval']
    else:
        names = ['lnlratio']
    
    rates = pd.read_csv(path, 
                    sep = '\t',
                    names = names,
                    skiprows=1,
                    on_bad_lines = 'warn')
    return rates

"""
Получение из файла с фиксированным шагом координат
нуклеотидов
"""

def get_coord(file):
    new_file = []
    a = open(file)
    s = []
    n = 0
    for i in a.readlines():
        if i.startswith('fixedStep'):
            n = int(i.split()[-2][6:])
        else:
            s.append(n)
            n+=1 
    return s

"""
Получение из .wig файлов интервалов, 
которые в дальнейшем будут извлечены из .maf файла
"""


def get_intervals(rates_filter, name, chrom):
    start = []
    end = []

    prev = 0
    counter = 0
    for i in rates_filter['index']:
        if prev==0:
            prev = i
        else:
            if (i-prev) == 1:
                counter+=1
                prev = i
            else:
                start.append(prev-counter)
                end.append(prev)
                counter = 0
                prev = i
                
    start.append(prev-counter)
    end.append(prev)

    df = pd.DataFrame({'chrom':chrom,'start':start, 'end':end})
    df['index'] = df['start'].astype(str)+'-'+df['end'].astype(str)
    df.to_csv(name, sep = '\t', index = False, header = False)       

def get_table(chrom, path, path_final, typ):
    ratesI_s = get_coord(path+'/'+typ+'/'+chrom)[1:]
    ratesI = rates_open(path_final+'/'+typ+'/'+chrom)
    ratesI.index = ratesI_s
    ratesI.index  = ratesI.index -1
    ratesI=ratesI.rename(columns={'lnlratio':'lnlratio_'+typ})
    return ratesI



ratesI = get_table(chrom, path, path_final, 'maf_4sp_inno')
ratesNI = get_table(chrom, path, path_final, 'maf_4sp_noninno')
ratesAll = get_table(chrom, path, path_final, 'maf_8sp')

rates = pd.concat([ratesI, ratesNI, ratesAll], axis=1)
rates['index'] = rates.index
rates=rates.dropna()

pd.options.mode.chained_assignment = None 
rates_filter = rates[rates!=0].dropna()
rates_filter1 = rates_filter[(rates_filter['lnlratio_maf_4sp_inno']>0)]

get_intervals(rates_filter1, '{}/fixed_inno_{}.bed'.format(path_interval, chrom), chrom)

#ищем участки с зафиксировавшейся мутацией в неиновационных и разным аллелем у инновационных

rates_filter = rates[rates!=0].dropna()
rates_filter2 = rates_filter[(rates_filter['lnlratio_maf_4sp_noninno']>0)]#[rates_filter2['lnlratio_maf_8sp']==rates_filter2['lnlratio_maf_8sp'].min()]

get_intervals(rates_filter2, '{}/fixed_noninno_{}.bed'.format(path_interval, chrom), chrom)

#ищем участки с зафиксировавшейся мутацией в обоих группах, но разными аллелями

rates_filter3 = rates_filter[(rates_filter['lnlratio_maf_4sp_noninno']>0)&
                            (rates_filter['lnlratio_maf_4sp_inno']>0)&
                            (rates_filter['lnlratio_maf_8sp']<0)]#[rates_filter3['lnlratio_maf_8sp']==rates_filter3['lnlratio_maf_8sp'].min()]


get_intervals(rates_filter3, '{}/two_alleles_{}.bed'.format(path_interval, chrom), chrom)