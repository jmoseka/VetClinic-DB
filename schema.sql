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