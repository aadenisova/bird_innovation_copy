from collections import defaultdict
import numpy as np
import pandas as pd
from sys import argv


dir_name = argv[1] #'rates_1_2_12/'
file_name = argv[2] #'inno_1314672_1314672.maf'


noninno_s="""GCA_008658365.1_bAlcTor1_primary,GCA_907165065.1_bCapEur3.1,GCA_009819825.1_bCarCri1.pri,GCA_017639555.1_bCicMag1.pri,GCA_020800305.1_bPorHoc1.mat.Z.cur,GCA_009769605.1_bBucAby1.pri,GCF_009829145.1_bChiLan1.pri,GCF_003957565.2_bTaeGut1.4.pri,GCA_013368605.1_bNycGra1.pri,GCA_009769525.1_bPteGut1.pri,GCA_017976375.1_bCucCan1.pri,GCF_009819795.1_bAytFul2.pri,GCA_009819775.1_bPhoRub2.pri,GCA_015220805.1_bPogPus1.pri,GCF_017639655.2_bFalNau1.pat,GCA_017639485.1_bPluApr1.pri,GCA_014839755.1_bSylBor1.pri,GCA_020745705.1_bHemCom1.pri.cur,GCA_901699155.2_bStrTur1.1,GCF_003957555.1_bCalAnn1_v1.p,GCA_020745775.1_bTheCae1.pri.cur,GCA_009819595.1_bMerNub1.pri,GCA_011004875.1_bBalReg1.pri,GCA_020740795.1_bApuApu2.pri.cur,GCF_016700215.1_bGalGal1.pat.whiteleghornlayer.GRCg7w,GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b,GCF_015220075.1_bFalRus1.pri,GCA_016904835.1_bAcaChl1.pri,GCF_009769625.2_bCygOlo1.pri.v2,GCA_020746105.1_bTroSur1.pri.cur"""#'GCF_003957565.2_bTaeGut1.4.pri,GCA_008658365.1_bAlcTor1_primary,GCA_014839755.1_bSylBor1.pri,GCA_009769605.1_bBucAby1.pri'
inno_s= """GCF_009819885.2_bCatUst1.pri.v2,GCA_009764595.1_bGeoTri1.pri,GCA_009819655.1_bSylAtr1.pri,GCA_009819605.1_bSteHir1.pri,GCA_903797595.2_bEriRub2.2,GCF_009650955.1_bCorMon1.pri,GCF_900496995.4_bAquChr1.4,GCF_015227805.1_bHirRus1.pri.v2"""#'GCA_009764595.1_bGeoTri1.pri,GCA_009819605.1_bSteHir1.pri,GCA_009819655.1_bSylAtr1.pri,GCF_900496995.4_bAquChr1.4'


not_inno = [i.split('.')[0] for i in noninno_s.split(',')]
inno = [i.split('.')[0] for i in inno_s.split(',')]

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
        if gcf in dict_.keys():
            variants = len(dict_[gcf])
            for base in dict_[gcf]:
                if base.upper() == 'A':
                    ans[0]+=1/variants
                if base.upper() == 'T':
                    ans[1]+=1/variants
                if base.upper() == 'C':
                    ans[2]+=1/variants
                if base.upper() == 'G':
                    ans[3]+=1/variants
    return ans

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
    return df/df.sum()
    
    
def character(df, file):
    
    a = (df['Innovative'].max() == 1) & (df['Not_innovative'].max() == 1) 
    b = (df['Innovative'].argmax() != df['Not_innovative'].argmax())
    cons = (a&b)
    
    a = (df['Innovative'].max() < 1) & (df['Not_innovative'].max() == 1) 
    b = df['Innovative'].iloc[df['Not_innovative'].argmax()].sum()==0
    AR_in_noninno = (a&b)
    
    a = (df['Innovative'].max() == 1) & (df['Not_innovative'].max() < 1) 
    b = df['Not_innovative'].iloc[df['Innovative'].argmax()].sum()==0
    AR_in_inno = (a&b)
    
    lists = file_name.split('_')
    s = "{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t".format(lists[1]+'_'+lists[2], 
    lists[4], 
    #lists[5], 
    lists[0],#+'_'+lists[1],
    AR_in_inno, 
    AR_in_noninno,
    cons,
    lists[6].split('.')[0],
    len(strings),
    ','.join([str(i) for i in df[df['Innovative'] >0].index.tolist()]),
    ','.join([str(i) for i in df[df['Not_innovative'] >0].index.tolist()])
    )
    
    print(s)
    


strings = get_strings(dir_name, file_name)
df = get_df(strings, not_inno, inno)
character(df, file_name)