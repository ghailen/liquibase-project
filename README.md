# liquibase-project

Liquibase is a database schema change management solution that enables you to revise and release database changes faster and safer from development to production.

Let's start directly by running the postgresql database and explore then the power of Liquibase step by step.

- Pull the last version of postgres from docker hub:
  ![image](https://github.com/user-attachments/assets/17d2dce6-c784-4262-a2b6-a73ce2a8f4cf)

- let's run create and run the container:
with this command:  docker run --name postgresLiquibase -e POSTGRES_USER=ghailene -e POSTGRES_PASSWORD=ghailene -e POSTGRES_DB=mydatabase -p 5432:5432 -d postgres:latest
  ![image](https://github.com/user-attachments/assets/a3090906-0948-4db5-a769-823a8fc07eac)
  
  ![image](https://github.com/user-attachments/assets/6ea6550c-76f6-420d-88f6-63367da3778a)

  
and then connect to the server in order to execute commands:
docker exec -it postgresLiquibase psql -U ghailene -d ghailene

![image](https://github.com/user-attachments/assets/83f691e4-b57b-4f56-802b-8dba8cfc977b)

let's check , if there is tables in database : with this command: select * from information_schema.tables
![image](https://github.com/user-attachments/assets/73531dce-155a-4a37-92d3-e5fe79ac5250)
as we can see there is no tables.

The postgres is Up and all is good,
let's start by installing the liquibase:
you can install the version of liquibase: 4.31.1 using this url:
https://github.com/liquibase/liquibase/releases
use command : liquibase -v to check the version

![image](https://github.com/user-attachments/assets/bc06bcac-8fcb-4c60-aaba-90418ac88a0b)

Now let s start by defining what are change-log and change-set and different type of change-log config:

*ChangeLog

A changelog in Liquibase is an XML, YAML, JSON, or SQL file that contains a list of database changes (called changesets) that should be applied to a database.

    It serves as the master record of all changes you want Liquibase to manage.

    You can have one main changelog and include other changelogs modularly using <include> or <includeAll> tags.

example of changelog file:
<databaseChangeLog
    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
     http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-4.3.xsd">

    <changeSet id="1" author="admin">
        <createTable tableName="person">
            <column name="id" type="int"/>
            <column name="name" type="varchar(255)"/>
        </createTable>
    </changeSet>

</databaseChangeLog>

*ChangeSet:

A changeset is the individual unit of change in Liquibase. Each changeset contains a single or group of change operations (like creating tables, adding columns, etc.).

    Each changeset has a unique combination of id, author, and file path.

    It ensures a change is only executed once per database.

 Properties:

    id – unique identifier.

    author – name of the person or system applying the change.

    runOnChange, runAlways, context, and more options to control behavior.
  

Example:
<changeSet id="2" author="user123">
    <addColumn tableName="person">
        <column name="email" type="varchar(255)"/>
    </addColumn>
</changeSet>


* Types of Changelogs in Liquibase

  Liquibase supports multiple formats for changelogs:
a. XML Changelog (most common)

    1 - Verbose and structured.

    2 - Supports all Liquibase features.
  example: <databaseChangeLog>...</databaseChangeLog>

b. YAML Changelog

    Cleaner syntax, less verbose than XML.

example:
    databaseChangeLog:
  - changeSet:
      id: 1
      author: dev
      changes:
        - createTable:
            tableName: user
            columns:
              - column:
                  name: id
                  type: int

  
c. JSON Changelog

    JSON representation of the same changelog structure.

    {  "databaseChangeLog": [
    {
      "changeSet": {
        "id": "1",
        "author": "dev",
        "changes": [
          {
            "createTable": {
              "tableName": "user",
              "columns": [
                {"column": {"name": "id", "type": "int"}}
              ]
            }
          }
        ]
      }
    }]}
  

d. SQL Changelog

    Direct SQL statements.

    Less flexible (no rollback automation unless explicitly written).

  example:
  --liquibase formatted sql
  --changeset user:1
  CREATE TABLE user (id INT, name VARCHAR(255));


In this example we gonna learn the SQL example , it is good to start learning 

let's start by creating the changeLog file:
the change log file will contains the sql file in a tag named include.
you can list multiple files
![image](https://github.com/user-attachments/assets/56644090-5186-4c95-9ec4-0cf4c11cd2c6)

and the sql file which will be used to create  a table named Persons in our database "mydatabase":
![image](https://github.com/user-attachments/assets/a2c392d2-d252-477e-be8d-96941fb675e3)


Let's start by creating the liquibase properties file which contains configuration to connect to postgesql server and mention the changelog file:
first of all download postgres jar from this url :
https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.2/

and then add this properties:
![image](https://github.com/user-attachments/assets/76194477-9a34-444d-a366-037fd8f73c85)


so the structure of the project must be like this:
![image](https://github.com/user-attachments/assets/75506724-8a8e-427f-a988-1917544dc845)

if you are facing a problem with the connection to postgres using dbeaver try to check in services the postgres if it is activated or disabled in order to access it:
![image](https://github.com/user-attachments/assets/f86538c4-cf7c-460e-928a-1e2f784a4eff)

the database is empty now:
![image](https://github.com/user-attachments/assets/3fe84150-da5e-4f67-a7a6-1ff870a53868)

let's run the liquibase changeLog using : liquibase update


