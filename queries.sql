/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
/* List the name of all animals born between 2016 and 2019*/
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
/* Name of all animals that are neutered and have less than 3 escape attempts */
SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
/* List the date of birth of all animals named either "Agumon" or "Pikachu"*/
SELECT * FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name FROM animals WHERE weight_kg > 10;