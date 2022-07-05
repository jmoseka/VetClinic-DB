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

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;





