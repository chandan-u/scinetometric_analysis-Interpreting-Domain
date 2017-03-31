import csv
import geocoder


f1 = open('../dataset/geocoded_locations_blanks.csv', 'r')
f2 = open('../dataset/geocoded_locations_blanks_coded1.csv', 'a')

csvreader = csv.reader(f1, delimiter=",", quotechar='"')

csvwriter = csv.writer(f2, delimiter=",", quotechar='"', quoting = csv.QUOTE_MINIMAL)


for i, row in enumerate(csvreader):
     
    print i
    if i >= 0 and len(row[13]) !=0 :
         
        geo_obj = geocoder.google(row[13], method="places")
        #geo_obj = geocoder.bing(row[13],key="An6DQft9XyD2rpIculUpNoJRMF4ovoya4ARm_BLVR6mJFU62riZXceoL_Lpyi" )
        latlng = geo_obj.latlng

        print latlng
        if len(latlng) != 0:

            row[51]=latlng[0]
            row[52]=latlng[1]
            
        else:
            row[51]=0
            row[52]=0

        csvwriter.writerow(row)





