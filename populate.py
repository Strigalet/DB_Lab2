import csv
import os
import re
import psycopg2
import psycopg2.extras


row_nums = [1, 18, 19, 20, 21, 29, 30, 31, 39, 40, 41, 49, 50, 51, 59, 60, 61, 69, 70, 71, 79, 80, 81, 88, 89, 91, 98, 99, 101, 108, 109, 111, 118, 119, 121]
check_size = 50





sql_query = (
    '''
        INSERT INTO zno (
            zno_year,
            OUTID,
            Birth,
            SEXTYPENAME,
            REGNAME,
            AREANAME,
            TERNAME,
            REGTYPENAME,
            TerTypeName,
            ClassProfileNAME,
            ClassLangName,
            EONAME,
            EOTYPENAME,
            EORegName,
            EOAreaName,
            EOTerName,
            EOParent,
            UkrTest,
            UkrTestStatus,
            UkrBall100,
            UkrBall12,
            UkrBall,
            UkrAdaptScale,
            UkrPTName,
            UkrPTRegName,
            UkrPTAreaName,
            UkrPTTerName,
            histTest,
            HistLang,
            histTestStatus,
            histBall100,
            histBall12,
            histBall,
            histPTName,
            histPTRegName,
            histPTAreaName,
            histPTTerName,
            mathTest,
            mathLang,
            mathTestStatus,
            mathBall100,
            mathBall12,
            mathBall,
            mathPTName,
            mathPTRegName,
            mathPTAreaName,
            mathPTTerName,
            physTest,
            physLang,
            physTestStatus,
            physBall100,
            physBall12,
            physBall,
            physPTName,
            physPTRegName,
            physPTAreaName,
            physPTTerName,
            chemTest,
            chemLang,
            chemTestStatus,
            chemBall100,
            chemBall12,
            chemBall,
            chemPTName,
            chemPTRegName,
            chemPTAreaName,
            chemPTTerName,
            bioTest,
            bioLang,
            bioTestStatus,
            bioBall100,
            bioBall12,
            bioBall,
            bioPTName,
            bioPTRegName,
            bioPTAreaName,
            bioPTTerName,
            geoTest,
            geoLang,
            geoTestStatus,
            geoBall100,
            geoBall12,
            geoBall,
            geoPTName,
            geoPTRegName,
            geoPTAreaName,
            geoPTTerName,
            engTest,
            engTestStatus,
            engBall100,
            engBall12,
            engDPALevel,
            engBall,
            engPTName,
            engPTRegName,
            engPTAreaName,
            engPTTerName,
            fraTest,
            fraTestStatus,
            fraBall100,
            fraBall12,
            fraDPALevel,
            fraBall,
            fraPTName,
            fraPTRegName,
            fraPTAreaName,
            fraPTTerName,
            deuTest,
            deuTestStatus,
            deuBall100,
            deuBall12,
            deuDPALevel,
            deuBall,
            deuPTName,
            deuPTRegName,
            deuPTAreaName,
            deuPTTerName,
            spaTest,
            spaTestStatus,
            spaBall100,
            spaBall12,
            spaDPALevel,
            spaBall,
            spaPTName,
            spaPTRegName,
            spaPTAreaName,
            spaPTTerName
        ) VALUES %s
    ''',
    '''
        UPDATE zno_temp SET record_id = %s, is_done = %s WHERE zno_year = %s
    '''
)



connection = psycopg2.connect("dbname=postgres user=postgres password=password")
cursor = connection.cursor()


for ch in os.listdir('data'):

    
    reader = re.findall(r'Odata(\d{4})File.csv', ch)
    if reader:
        with open(os.path.join('data', ch), encoding='cp1251') as csvfile:
            
            csv_reader = csv.reader(csvfile, delimiter=';')
            next(csv_reader)
            counter = 0
            check = []
            cursor.execute('SELECT record_id, is_done FROM zno_temp WHERE zno_year = %s', reader)
            curfetch = cursor.fetchone()

            if curfetch is None:
                cursor.execute('INSERT INTO zno_temp (zno_year, record_id, is_done) VALUES (%s, %s, %s)', reader + [counter, False])
            else:
                if curfetch[-1]:
                    continue
                for r in csv_reader:
                    counter += 1
                    if counter >= curfetch[0]:
                        break
            for r in csv_reader:
                   
                for i in range(len(r)):
                    if r[i] == 'null':
                        r[i] = None
                    else:
                        if i in row_nums:
                            r[i] = r[i].replace(',', '.')

                counter += 1
                check.append(reader + r)
                if not counter % check_size:
                    psycopg2.extras.execute_values(cursor, sql_query[0], check)
                    cursor.execute(sql_query[1], [counter, False] + reader)
                    check = list()
                    connection.commit()
            if check:
                psycopg2.extras.execute_values(cursor, sql_query[0], check)
                cursor.execute(sql_query[1], [counter, True] + reader)
                check = list()
                connection.commit()
                    
                

cursor.close()
connection.close()
