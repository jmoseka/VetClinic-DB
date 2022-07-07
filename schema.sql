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

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN IF NOT EXISTS species_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN IF NOT EXISTS owner_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);