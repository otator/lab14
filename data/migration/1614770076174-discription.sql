-- create database namesd lab14
CREATE DATABASE lab14;

-- applying the schema of the books table to create books table in lab14 database
psql -f schema.sql -d lab14


-- inserting some records in the new lab14 books table
psql -f seed.sql -d lab14


-- copying database lab14 TEMPLATE into new database named lab14_normal
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;


-- create table named authors in order to start normalization
CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));


-- insert the authors names from books table into authors table
INSERT INTO authors(name) SELECT DISTINCT author FROM books;


-- add new column call author_id to the books table
ALTER TABLE books ADD COLUMN author_id INT;


-- set the books coulmn author_id to get the values of id in the authors table
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

-- drop the table author from the books table
ALTER TABLE books DROP COLUMN author;


-- add FOREIGN key for the column author_id that REFERENCES the column id in authors table
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);