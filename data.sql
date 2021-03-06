/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Agumon', '2020-02-03', 10.3, TRUE,0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Gabumon', '2018-11-15', 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Pikachu', '2021-01-07', 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Devimon', '2018-05-12', 11, TRUE, 5);
/*New data*/
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Charmander', '2020-02-08', -11, FALSE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Plantmon', '2021-11-15', -5.7, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Squirtle', '1993-02-02', -11, FALSE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Angemon', '2005-06-12', -45, TRUE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Boarmon', '2005-06-07', 20.4, TRUE, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Blossom', '1998-10-13', 17, TRUE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Ditto', '2022-04-14', 22, TRUE, 4);

/*Inside a transaction update the animals table by setting the 
species column to unspecified. Then roll back.*/
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Inside a transaction:
  - Update the `animals` table by setting the `species` column to `digimon` for all animals that have a name ending in `mon`.
  - Update the `animals` table by setting the `species` column to `pokemon` for all animals that don't have `species` already set.
  - Commit the transaction.s
  - Verify that change was made and persists after commit.*/
BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/*Inside a transaction delete all records in the animals table, 
then roll back the transaction.*/
BEGIN;
DROP TABLE IF EXISTS animals;
ROLLBACK;

/*Delete all animals born after Jan 1st, 2022.*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
/*Create a savepoint for the transaction.*/
SAVEPOINT point1;
/*Update all animals' weight to be their weight multiplied by -1.
*/
UPDATE animals
SET weight_kg = weight_kg * -1;
/*Rollback to the savepoint*/
ROLLBACK TO point1;
/*Update all animals' weights that are negative to be their weight multiplied by -1*/
UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
/*Commit transaction*/
COMMIT;

--insert data to owners table
INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES('Jodie Whittaker', 38);

--insert data to species table
INSERT INTO species (name)
VALUES('Pokemon');
INSERT INTO species (name)
VALUES('Digimon');

-- Modify your inserted animals so it includes the species_id value:
--  If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
BEGIN;
UPDATE animals
SET species_id = 'pokemon';
UPDATE animals
SET species_id = 'digimon' WHERE name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET species_id = (
SELECT id
FROM species
WHERE name = 'Digimon'
)
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (
SELECT id
FROM species
WHERE name = 'Pokemon'
)
WHERE name NOT LIKE '%mon';

COMMIT;

/*
Modify your inserted animals to include owner information (owner_id):
Sam Smith owns Agumon.
Jennifer Orwell owns Gabumon and Pikachu.
Bob owns Devimon and Plantmon.
Melody Pond owns Charmander, Squirtle, and Blossom.
Dean Winchester owns Angemon and Boarmon.
*/

-- Sam Smith owns Agumon.
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Jennifer Orwell'
)
WHERE name = 'Gabumon' OR name = 'Pikachu';
COMMIT

-- Bob owns Devimon and Plantmon.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Bob'
)
WHERE name = 'Devimon' OR name = 'Plantmon';
SELECT * FROM animals;
COMMIT

-- Melody Pond owns Charmander, Squirtle, and Blossom.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Melody Pond'
)
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
SELECT * FROM animals;
COMMIT

-- Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals
SET owner_id = (
SELECT id
FROM owners
WHERE full_name = 'Dean Winchester'
)
WHERE name = 'Angemon' OR name = 'Boarmon';
SELECT * FROM animals;
COMMIT;


-- Insert the data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation)
VALUES('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation)
VALUES('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation)
VALUES('Jack Harkness', 38, '2008-06-08');

-- Insert data for specialties
INSERT INTO specializations (species_id, vets_id)
VALUES(
(SELECT id FROM species WHERE name = 'Pokemon'),
(SELECT id FROM vets WHERE name = 'William Tatcher')
);

INSERT INTO specializations (species_id, vets_id)
VALUES(
(SELECT id FROM species WHERE name = 'Digimon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez')
);

INSERT INTO specializations (species_id, vets_id)
VALUES(
(SELECT id FROM species WHERE name = 'Pokemon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez')
);

INSERT INTO specializations (species_id, vets_id)
VALUES(
(SELECT id FROM species WHERE name = 'Digimon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness')
);


-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Agumon'),
(SELECT id FROM vets WHERE name = 'William Tatcher'),
'2020-05-24'
);

INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Agumon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2020-07-22'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Gabumon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2021-02-02'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Pikachu'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-01-05'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Pikachu'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-03-08'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Pikachu'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-05-14'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Devimon'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2021-05-04'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Charmander'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2021-02-24'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Plantmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2019-12-21'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Plantmon'),
(SELECT id FROM vets WHERE name = 'William Tatcher'),
'2020-08-10'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Plantmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2021-04-07'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Squirtle'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2019-09-29'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Angemon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2020-10-03'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Angemon'),
(SELECT id FROM vets WHERE name = 'Jack Harkness'),
'2020-11-04'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2019-01-24'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2019-05-15'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-02-27'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Boarmon'),
(SELECT id FROM vets WHERE name = 'Maisy Smith'),
'2020-08-03'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Blossom'),
(SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
'2020-05-24'
);
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES(
(SELECT id FROM animals WHERE name = 'Blossom'),
(SELECT id FROM vets WHERE name = 'William Tatcher'),
'2021-01-11'
);

---- add more records into owners table
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000),
 'owner_' || generate_series(1,2500000) || '@mail.com';
