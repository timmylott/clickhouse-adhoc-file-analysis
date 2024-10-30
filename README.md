# How to use ClickHouse to do quick adhoc file analsysis

This is great for large csv files that exceed Excel's row limit, allows you to query a csv file simply using sql

These instuctions are for MacOS

Run clickhouse server on your local machine and use DBeaver as a client.  There is a bash script here that you can run that will generate the select statements for your files to quickly get you analysing your files.

## Some Links
- ClickHouse quick start - https://clickhouse.com/clickhouse#getting_started
- Quick Install - https://clickhouse.com/docs/en/install
- DBeaver Community - https://dbeaver.io/download/

## Instuctions

Open a terminal and run this:
```
mkdir clickhouse
cd clickhouse
curl https://clickhouse.com/ | sh
```
Then run the following commmand:
```
./clickhouse server
```

ClickHouse server is now running on your local machine.

Browse to https://dbeaver.io/download/ and following the install instuctions for your OS.

Go to the directory where clickhouse was installed and you see a sub-directory called `user_files`.  Download the files from the `user_files` directory from this repo into the `user_files` directory where ClickHouse was install on your machine.

`00_generate_select.command` - Bash script that when executed creates select statements for all the files located in that user_files directory into a file called `00_user_files_select.sql`

`Electric_Vehicle_Population_Data.csv` - Is a copy of the csv from https://catalog.data.gov/dataset/electric-vehicle-population-data.  

`states.csv` - List of US state abbreviations and names

`flights-1m.parquet` - Sample parquet file from https://www.tablab.app/parquet/sample


Double click the `00_generate_select.command`. Terminal should open and you'll see an output similar to:
```
SELECT * FROM file ('Electric_Vehicle_Population_Data.csv')
SELECT * FROM file ('flights-1m.parquet')
SELECT * FROM file ('states.csv')
```

Open DBeaver and click add connection from the tool bar:
![add-connection](./assets/add-new-connection.png)

Filter for ClickHouse:
![add-clickhouse](./assets/add-clickhouse.png)

Leave default connection parameters and click Test Connection:
![connection-info](./assets/connection-info.png)

Should now have a localhost connection the left pane with a default database:
![localhost-default](./assets/localhost-default.png)

Click File -> Open File.  Browse to your clickhouse installation user_files and open the `00_user_files_select.sql`.  That contains all the select statements for the files sitting in that directory.

In the toolbar click the little database icon to set the active connection and select localhost:
![active-connection](./assets/active-connection.png)

DBeaver is now connected to your locally running ClickHouse server.  When using the clickhosue file table funtion that accesses files sitting in that user_files directory.  https://clickhouse.com/docs/en/sql-reference/table-functions/file



## Sample Queries

```
SELECT FL_DATE, SUM(DISTANCE) AS SUM_DISTANCE from file ('flights-1m.parquet')
GROUP BY FL_DATE

SELECT vd.City, st.State, COUNT(*) FROM file ('Electric_Vehicle_Population_Data.csv', CSV, '"VIN (1-10)" String,"County" String,"City" String,"State" String,"Postal Code" String,"Model Year" String,"Make" String,"Model" String,"Electric Vehicle Type" String,"Clean Alternative Fuel Vehicle (CAFV) Eligibility" String,"Electric Range" String,"Base MSRP" String,"Legislative District" String,"DOL Vehicle ID" String,"Vehicle Location" String,"Electric Utility" String,"2020 Census Tract" String') AS vd
JOIN file ('states.csv', CSV, '"State" String,"Abbreviation" String') AS st ON st.Abbreviation = vd.State
GROUP BY vd.City, st.State
ORDER BY count(*) DESC 
```
