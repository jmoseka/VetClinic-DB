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

