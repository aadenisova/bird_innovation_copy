from collections import defaultdict
import numpy as np
import pandas as pd
from sys import argv


dir_name = argv[1] #'rates_1_2_12/'
file_name = argv[2] #'inno_1314672_1314672.maf'


not_inno = ['GCF_003957565', 'GCA_008658365', 'GCA_014839755']
inno = ['GCA_009764595', 'GCA_009819605', 'GCA_009819655', 'GCF_009650955']



"""
Открываем файл и преобразуем его в словарь, где каждому ID
противопоставлены буквы в рассматриваемой позиции
"""

def get_strings(directory, file):
    
    maf = open(directory+file, 'r')
    n = 0
    strings = defaultdict(list)
    for i in maf: 
        if ((n>2) & (i!='\n')):
            strings[i.split()[1][:13]].append(i.split()[-1]) #нужно как-то обозначить, что делать если много участков выравнелось
        n+=1
    return strings

"""
С использованием полученного в get_strings(directory, file)
словаря получаем массив с долей встречаемости каждого нуклеотида
в позиции
"""

def get_counts_vect(sp_list, dict_):

    ans = np.zeros(4) # массив каунтов A T C G
    for gcf in sp_list:
        variants = len(dict_[gcf])
        for base in dict_[gcf]:
            if base.upper() == 'A':
                ans[0]+=1/variants
            if base.upper() == 'T':
                ans[1]+=1/variants
            if base.upper() == 'C':
                ans[2]+=1/variants
            if base.upper() == 'G':
                ans[0]+=1/variants
    return ans/len(sp_list)

"""
Получаем таблицу со столбцами -- группами видов, 
строками -- долей каждого нуклеотида в этой позиции
среди группы
"""

def get_df(strings, not_inno, inno):

    df = pd.DataFrame({'Not_innovative': get_counts_vect(not_inno, strings),
                 'Innovative': get_counts_vect(inno, strings)})
    df['Both'] = df['Not_innovative'] + df['Innovative']
    df.index = ['A', 'T', 'C', 'G']
    return df
    
    
def character(df, file):
    
    a = (df['Innovative'].max() == 1) & (df['Not_innovative'].max() == 1) 
    b = (df['Innovative'].argmax() != df['Not_innovative'].argmax())
    cons = (a&b)
    
    a = (df['Innovative'].max() < 1) & (df['Not_innovative'].max() == 1) 
    b = (df['Innovative'].argmax() != df['Not_innovative'].argmax())
    AR_in_inno = (a&b)
    
    a = (df['Innovative'].max() == 1) & (df['Not_innovative'].max() < 1) 
    b = (df['Innovative'].argmax() != df['Not_innovative'].argmax())
    AR_in_noninno = (a&b)
    
    s = "In {}\ncons: {}\nAR_in_inno: {}\nAR_in_noninno: {}".format(file, cons, AR_in_inno, AR_in_noninno)
    
    if (cons | AR_in_inno | AR_in_noninno):
        print(s)
        print(' '.join(["-" for i in range (11)]))
    
strings = get_strings(dir_name, file_name)
df = get_df(strings, not_inno, inno)
character(df, file_name)
