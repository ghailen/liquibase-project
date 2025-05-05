-- liquibase formatted sql

-- changeset Ghailene:1 labels: insert into table
-- comment: insert into table persons

INSERT INTO Persons (PersonID, LastName, FirstName,Address,City)
VALUES (123, 'mark', 'ghailene','rue 123','paris');  

-- rollback delete from Persons;