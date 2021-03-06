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

-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name,
animals.name AS name_of_animals,
species.name AS name_of_species
FROM animals
JOIN owners ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name,
escape_attempts,
full_name
FROM animals
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name,
COUNT(animals.owner_id) AS Owns
FROM owners
JOIN animals ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY Owns DESC;

----------------------------------------------------------

-- Who was the last animal seen by William Tatcher?
SELECT animals.name,
visits.date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name)
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name,
species.name as specialties
FROM vets
FULL JOIN specializations ON vets.id = specializations.vets_id
FULL JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name,
visits.date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-09-30'
AND vets.name = 'Stephanie Mendez';

-- What animal has the most visits to vets?
SELECT COUNT(animals.name) AS nb_of_visit,
animals.name
FROM animals
JOIN visits ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY nb_of_visit DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name,
visits.date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.date_of_visit,
animals.name AS ANIMALS_NAME,
animals.date_of_birth AS ANIMALS_BITH,
animals.escape_attempts,
animals.weight_kg,
species.name AS ANIMALS_SPECIES,
owners.full_name AS OWNERS,
vets.name AS VET_NAME,
vets.age AS VET_age,
vets.date_of_graduation AS VET_DATE_OF_GRAD
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animals_id)
FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(animals.species_id) as count_visit,
species.name
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY count_visit DESC
LIMIT 1;

-- Use EXPLAIN ANALYZE to query what is happening.
explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;
explain analyze SELECT * FROM visits where vets_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';