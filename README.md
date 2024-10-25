# How to use ClickHouse to do quick adhoc file analsysis

This is great for large csv files that exceed Excel's row limit, allows you to query a csv file simply using sql

These instuctions are for MacOS

Run clickhouse server on your local machine and use DBeaver as a client.  There is a bash script here that you can run that will generate the select statements for your files to quickly get you analying your files.

## Some Links
- ClickHouse quick start - https://clickhouse.com/clickhouse#getting_started
- Quick Install - https://clickhouse.com/docs/en/install
- DBeaver Community - https://dbeaver.io/download/

## Instuctions

Open a terminal and run this:
```
curl https://clickhouse.com/ | sh
```
Then run the following commmand:
```
./clickhouse server
```

ClickHouse server is now running on your local machine.  Go to the direction where clickhouse was installed and you see a sub-directory called `user-files`.  Download the `00_generate_select.command` from this repo into that directory.

Browse to https://dbeaver.io/download/ and following the install instuctions for your OS.

