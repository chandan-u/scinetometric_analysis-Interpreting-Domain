import geocoder
import csv
f1 = open('../dataset/Scientometric Interpreting_1990 2016.csv', 'r')

                            

f2 = open('../dataset/authors.csv', 'a')

csvreader = csv.reader(f1, delimiter=",", quotechar='"')

csvwriter = csv.writer(f2, delimiter=",", quotechar='"', quoting = csv.QUOTE_MINIMAL)

for i, row in enumerate(csvreader):
     #print row
     #if int(row[0]) > lines :
         
         #geo_obj = geocoder.google(row[5])
         #row.append(geo_obj.postal)
         #csvwriter.writerow(row)
      
     
     if i == 0 :
     	print i+1, row
     
     else:
     	authors = row[0].split(",")
     	affiliations = row[13].split(";")
     	for author, affiliation in zip(authors,affiliations):
            csvwriter.writerow([author, affiliation])
            










         
