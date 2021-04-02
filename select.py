import csv
import os
import psycopg2


sql_query = '''
    SELECT
        "Year", 
	"RegName",
        round(avg("Ball100"),3) , 
	round(avg("Ball12"),3) , 
	round(avg("Ball"),3)
    FROM "Test"
    LEFT JOIN "EO"
    ON "Test"."PTEOName"="EO"."EOName"
    LEFT JOIN "Region"
    ON "Region"."RegionID"="EO"."RegionID"
    WHERE "Test"."TestStatus"='Зараховано' AND "Test"."TestName"='Українська мова і література'
    GROUP BY "Test"."Year", "Region"."RegName"
'''

bars = ['Year', 'Region', 'ZNO Grade', 'DPA Grade', 'Test Grade']
result = 'result.csv'


def select(connection):
    cursor = connection.cursor()

    cursor.execute(sql_query)
    curfetchall = cursor.fetchall()

    with open(os.path.join('result',result), 'w', newline='') as csvf:
        csv_w = csv.writer(csvf, dialect='excel')
        csv_w.writerow(bars)
        csv_w.writerows(curfetchall)

    cursor.close()

connection = psycopg2.connect("dbname=postgres user=postgres password=password")
select(connection)
connection.close()
