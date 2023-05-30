# Athens University of Economics and Business
# M.Sc. Program in Business Analytics
# Course:   Social Network Analysis - Spring 2022
# Student_id:  p2822107
# Name:  Vioni Konstantina
# Instructor:  Katia Papakonstantinopoulou



#Loading the needed libraries
import pandas as pd
import collections
import itertools


#Importing the data for each year and setting the names of the columns in the dataframes
     
authors_16 = pd.read_csv("authors-sample16.csv", header=None,names=["Year","Title_of_paper","Conference","Authors"],error_bad_lines=False)                 

authors_17 = pd.read_csv("authors-sample17.csv", header=None,names=["Year","Title_of_paper","Conference","Authors"],error_bad_lines=False)                 

authors_18 = pd.read_csv("authors-sample18.csv", header=None,names=["Year","Title_of_paper","Conference","Authors"],error_bad_lines=False)                 

authors_19 = pd.read_csv("authors-sample19.csv", header=None,names=["Year","Title_of_paper","Conference","Authors"],error_bad_lines=False)                 

authors_20 = pd.read_csv("authors-sample20.csv", header=None,names=["Year","Title_of_paper","Conference","Authors"],error_bad_lines=False)                 



#Viewing our dataframes
authors_16
authors_17
authors_18
authors_19
authors_20


# Dropping the first 3 columns of the dataframe
authors_16 = authors_16.iloc[: , 3:]
authors_17 = authors_17.iloc[: , 3:]
authors_18 = authors_18.iloc[: , 3:]
authors_19 = authors_19.iloc[: , 3:]
authors_20 = authors_20.iloc[: , 3:]
#now our dataframe contains only the authors 



#Checking for missing values
authors_16.isna().sum()
authors_17.isna().sum()
authors_18.isna().sum()
authors_19.isna().sum()
authors_20.isna().sum()


#Dropping missing values
authors_16 = authors_16.dropna()
authors_17 = authors_17.dropna()
authors_18 = authors_18.dropna()
authors_19 = authors_19.dropna()
authors_20 = authors_20.dropna()


#Creating lists for authors
list_16 = list(authors_16.Authors)
list_17 = list(authors_17.Authors)
list_18 = list(authors_18.Authors)
list_19 = list(authors_19.Authors)
list_20 = list(authors_20.Authors)


#Splitting the lists
splitting16 = [i.split(',') for i in list_16 ]
splitting17 = [i.split(',') for i in list_17 ]
splitting18 = [i.split(',') for i in list_18 ]
splitting19 = [i.split(',') for i in list_19 ]
splitting20 = [i.split(',') for i in list_20 ]



#Calculating the frequency of authors' pairs

#for 2016:
count16 = collections.defaultdict(int)
for i in splitting16:
    i.sort()
    for pair in itertools.combinations(i, 2):
        count16[pair] += 1

#for 2017
count17 = collections.defaultdict(int)
for i in splitting17:
    i.sort()
    for pair in itertools.combinations(i, 2):
        count17[pair] += 1
        
#for 2018
count18 = collections.defaultdict(int)
for i in splitting18:
    i.sort()
    for pair in itertools.combinations(i, 2):
        count18[pair] += 1

#for 2019
count19 = collections.defaultdict(int)
for i in splitting19:
    i.sort()
    for pair in itertools.combinations(i, 2):
        count19[pair] += 1
        
#for 2020
count20 = collections.defaultdict(int)
for i in splitting20:
    i.sort()
    for pair in itertools.combinations(i, 2):
        count20[pair] += 1
        
        
        
#Creating dataframes
authors_16_final = pd.DataFrame.from_records(list(dict(count16).items()), columns=['Authors','Weight'])
authors_17_final = pd.DataFrame.from_records(list(dict(count17).items()), columns=['Authors','Weight']) 
authors_18_final = pd.DataFrame.from_records(list(dict(count18).items()), columns=['Authors','Weight'])
authors_19_final = pd.DataFrame.from_records(list(dict(count19).items()), columns=['Authors','Weight'])
authors_20_final = pd.DataFrame.from_records(list(dict(count20).items()), columns=['Authors','Weight'])
        
    
#Viewing our final dataframes
authors_16_final
authors_17_final
authors_18_final
authors_19_final
authors_20_final


#Creating columns 'From' , 'To' and dropping column Authors
#for 2016:
authors_16_final['From'] = authors_16_final['Authors'].str.get(0)
authors_16_final['To'] = authors_16_final['Authors'].str.get(1)

authors_16_final = authors_16_final.iloc[: , 1:]

#for 2017:
authors_17_final['From'] = authors_17_final['Authors'].str.get(0)
authors_17_final['To'] = authors_17_final['Authors'].str.get(1)

authors_17_final = authors_17_final.iloc[: , 1:]

#for 2018:
authors_18_final['From'] = authors_18_final['Authors'].str.get(0)
authors_18_final['To'] = authors_18_final['Authors'].str.get(1)

authors_18_final = authors_18_final.iloc[: , 1:]

#for 2019:
authors_19_final['From'] = authors_19_final['Authors'].str.get(0)
authors_19_final['To'] = authors_19_final['Authors'].str.get(1)

authors_19_final = authors_19_final.iloc[: , 1:]

#for 2020:
authors_20_final['From'] = authors_20_final['Authors'].str.get(0)
authors_20_final['To'] = authors_20_final['Authors'].str.get(1)

authors_20_final = authors_20_final.iloc[: , 1:]



#Setting Column 'Weight' as the third column of the dataframe 
#for 2016:
third_column16=authors_16_final.pop('Weight')
authors_16_final.insert(3,'Weight',third_column16)

#for 2017:
third_column17=authors_17_final.pop('Weight')
authors_17_final.insert(3,'Weight',third_column17)

#for 2018:
third_column18=authors_18_final.pop('Weight')
authors_18_final.insert(3,'Weight',third_column18)

#for 2019:
third_column19=authors_19_final.pop('Weight')
authors_19_final.insert(3,'Weight',third_column19)

#for 2020:
third_column20=authors_20_final.pop('Weight')
authors_20_final.insert(3,'Weight',third_column20)


#Extracting the dataframes of each year in to csv format
authors_16_final.to_csv(r'C:\Users\konst\Desktop\Social Network\project2\final csv files\data16.csv', index=False)
authors_17_final.to_csv(r'C:\Users\konst\Desktop\Social Network\project2\final csv files\data17.csv', index=False)
authors_18_final.to_csv(r'C:\Users\konst\Desktop\Social Network\project2\final csv files\data18.csv', index=False)
authors_19_final.to_csv(r'C:\Users\konst\Desktop\Social Network\project2\final csv files\data19.csv', index=False)
authors_20_final.to_csv(r'C:\Users\konst\Desktop\Social Network\project2\final csv files\data20.csv', index=False)
