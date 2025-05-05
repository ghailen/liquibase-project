-- liquibase formatted sql

-- changeset Ghailene:1 labels: create table
-- comment: create table persons

CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);     

-- rollback drop table Persons;