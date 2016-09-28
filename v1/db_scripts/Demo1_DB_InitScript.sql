DROP DATABASE IF EXISTS Stomp_test;
CREATE DATABASE Stomp_test;

USE Stomp_test;


source /Library/WebServer/Documents/StompGit/v1/db_scripts/db_and_table_init.sql;
source /Library/WebServer/Documents/StompGit/v1/db_scripts/procedures_init.sql;
source /Library/WebServer/Documents/StompGit/v1/db_scripts/data1_init.sql;