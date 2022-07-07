/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;

/*Answers*/
-- How many animals are there
SELECT COUNT(*) FROM animals;
--ANSWER: 10

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- ANSWER: 3

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
--ANSWER: 15.44

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,
    MAX(escape_attempts)
FROM animals GROUP BY neutered;
-- ANSWER : 7 | 3

-- What is the minimum and maximum weight of each type of animal?
SELECT species,
    MAX(weight_kg),
    MIN(weight_kg)
FROM animals GROUP BY species;
-- ANSWER : DIGIMON: MIN - 5.7 | MAX - 45
-- ANSWER : POKEMON: MIN - 11 | MAX - 17

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
    AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
-- ANSWER : 3.00

/*Write queries (using JOIN) to answer the following questions*/
-- What animals belong to Melody Pond?
SELECT name,
full_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name as animals,
species.name as species
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name AS Animals,
full_name AS Owners
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(animals.name) AS Animals_count,
species.name AS Specie
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;