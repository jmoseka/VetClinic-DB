/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id SERIAL PRIMARY KEY,
name VARCHAR(100), 
date_of_birth DATE, 
escape_attempts INT, 
neutered BOOLEAN, 
weight_kg DECIMAL
);

/*Add a column species*/
ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

CREATE TABLE owners (
id SERIAL PRIMARY KEY,
full_name VARCHAR(100),
age INT
);

CREATE TABLE species (
id SERIAL PRIMARY KEY,
name VARCHAR(100)
);

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;
