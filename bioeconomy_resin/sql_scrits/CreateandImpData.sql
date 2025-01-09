#Criar a base de dados
CREATE DATABASE IF NOT EXISTS bioeconomy_resin;
USE bioeconomy_resin;

#Importar os dados da florest_areas
CREATE TABLE florest_areas (
    ID_region INT PRIMARY KEY,
    region VARCHAR(100),
    hectares FLOAT
);
LOAD DATA LOCAL INFILE 'C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\forest_areas.csv'
INTO TABLE florest_areas
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#Importar os dados da extraction_costs
CREATE TABLE extraction_costs (
    ID_region INT PRIMARY KEY,
    region VARCHAR(100),
    Extraction_Cost FLOAT,
    Production_Cost FLOAT
);
LOAD DATA LOCAL INFILE 'C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\extraction_costs.csv'
INTO TABLE extraction_costs
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID_region, region, Extraction_Cost, @Production_Cost)
SET Production_Cost = @Production_Cost;

#Importar os dados da environmental_impact
CREATE TABLE environmental_impact (
    ID_region INT PRIMARY KEY,
    region VARCHAR(100),
    CO2_Avoided FLOAT
);
LOAD DATA LOCAL INFILE 'C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\environmental_impact.csv'
INTO TABLE environmental_impact
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#Importar os dados da workforce
CREATE TABLE workforce (
    ID_region INT PRIMARY KEY,
    region VARCHAR(100),
    Workers INT
);
LOAD DATA LOCAL INFILE 'C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\workforce.csv'
INTO TABLE workforce
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#Importar os dados da resin_production
CREATE TABLE resin_production (
    ID_region INT PRIMARY KEY,
    Production_T FLOAT,
    Production_Euros FLOAT
);
LOAD DATA LOCAL INFILE 'C:\Users\anaca\DMSPROJECT\bioeconomy_resin\processed_data\resin_production.csv'
INTO TABLE resin_production
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@ID_region, @Production_T, @Production_Euros)
SET ID_region = @ID_region,
    Production_T = @Production_T,
    Production_Euros = @Production_Euros;

SHOW DATABASES;
SHOW TABLES;
DESCRIBE workforce;


