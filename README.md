# Kasich Bogdan KM-83 Lab Work 2 (Variant - 2)
Instructions:

0. Download flyway tool from flyway.org
1. Search for "conf" directory and "flyway.conf" file there. Open the file and rewrite all content to:

flyway.url=jdbc:postgresql://localhost:"your localhost"/postgres

flyway.user="your username"

flyway.password="your password"

2. Add Odata2019/2020File.csv files in "data" folder.
3. Add your .sql files into /"sql" folder for future migration. (you can already use "flyway baseline/migrate" in cmd to migrate the database without data)
4. Check query.py which contains create/populate queries.
5. Run Start.py to create "zno" and "zno_temp" tables.
6. Now you can run Old_select.py to see completed task with data from "zno" table.
7. Run "flyway baseline"  and then "flyway migrate" in command line. Wait one eternity for migration.

8. Check Migration.png for successful migration.
![Migration](https://user-images.githubusercontent.com/44712899/113474406-80091f80-9478-11eb-92b4-cfa9c7f68909.png)

9. Now you can run New_select.py to see completed task with data from new created tables with migrated data from "zno".
10. Search "result" folder to see results of work. (If they are equal that means we didn't lost any data)

11. Check LogicalERD/PhysicalERD.png for data model correctness.
![PhysicalERD](https://user-images.githubusercontent.com/44712899/113462919-e9167600-942b-11eb-8025-e75afd4c76cf.png)
![LogicalERD](https://user-images.githubusercontent.com/44712899/113462924-eca9fd00-942b-11eb-9e41-22afb5cbddf3.png)


12. End.


