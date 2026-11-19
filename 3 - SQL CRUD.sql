---------------------------------------------------
--- SQL: CREATING AND UPDATING TABLES
---------------------------------------------------

-- P1: CREATE
-- P2: INSERT
-- P3: UPDATE & SET
-- P4: ALTER
-- P5: DROP

---------------------------------------------------
--- P1: Creating tables >> CREATE
--- Documentation: https://www.postgresql.org/docs/current/sql-createtable.html
---------------------------------------------------

/* Syntax:
CREATE TABLE table_name (
	column1_name column1_type ,
	column2_name column2_type ,
	column3_name column3_type 
		);
*/

-- ids INT -- column name & type

CREATE TABLE ade_1.al_icebreaker_data (
	first_name VARCHAR(10) -- column name & type
	, ice_cream VARCHAR(15)
	, fav_month VARCHAR(9)
	, transport VARCHAR(15)
	, game VARCHAR(15)
	);

-- There are many data types to choose from:
-- INT, BIGINT, FLOAT, NUMERIC
-- VARCHAR, TEXT, CHAR
-- DATE, BOOL, ARRAY

---------------------------------------------------
--- P2: Inserting new data >> INSERT
--- Documentation: https://www.postgresql.org/docs/current/sql-insert.html
---------------------------------------------------

/* Syntax:
INSERT INTO table_name VALUES 
	( value1_1, value1_2, value1_3 ),
	( value2_1, value2_2, value2_3 );
*/
INSERT INTO ade_1.al_icebreaker_data VALUES 
	('Bob', 'Vanilla', 'February', 'Bike', 'Badminton');

INSERT INTO ade_1.al_icebreaker_data (first_name, ice_cream, fav_month) VALUES -- list columns you want to insert
	(...);

SELECT * FROM ade_1.al_icebreaker_data;

-- We can also specify the names of the columns


/* Syntax:
INSERT INTO table_name (column_1, column_2, column_3)
	VALUES (value_1, value_2, value_3);
*/

---------------------------------------------------
--- P3: Updating existing data >> UPDATE & SET
--- Documentation: https://www.postgresql.org/docs/current/sql-update.html
---------------------------------------------------

-- We can update the existing data in our table on a specific record
-- We typically designate the record we want using the table's PRIMARY KEY

/* Syntax:
UPDATE table_name
SET column = new_value
WHERE ID = record_value;
*/
UPDATE ade_1.al_icebreaker_data
SET game = 'Mario' 
WHERE first_name = 'Isabelle';
---------------------- Here's a typical example
-- UPDATE my_table
-- SET flag = 1
-- WHERE ID = 2337;

---------------------------------------------------
--- P4: Modifying the table >> ALTER
--- Documentation: https://www.postgresql.org/docs/current/sql-altertable.html
---------------------------------------------------

-- The ALTER TABLE flag can interact with your table in many ways, such as
-- 1. Adding a new column

/* Syntax:
ALTER TABLE table_name
	ADD COLUMN column_name column_type;
*/
ALTER TABLE ade_1.al_icebreaker_data
	ADD COLUMN like_sql BOOL;

ALTER TABLE ade_1.al_icebreaker_data
ADD COLUMN id SERIAL;

UPDATE ade_1.al_icebreaker_data
	SET like_sql = TRUE;
	-- WHERE ...
-- 2. Dropping an existing column

/* Syntax:
ALTER TABLE table_name
	DROP COLUMN column_name;
*/

ALTER TABLE ade_1.al_icebreaker_data
	DROP COLUMN like_sql;

-- 3. Changing the data type of an existing column

/* Syntax:
ALTER TABLE table_name
	ALTER COLUMN column_name TYPE new_column_type;
*/
-- SET game = ...
-- WHERE ...

ALTER TABLE ade_1.al_icebreaker_data
	ALTER COLUMN game TYPE FLOAT
	USING CASE
		WHEN game = 'yes' THEN TRUE
		WHEN game = 'no' THEN TRUE
	END;

-- 4. BONUS: Adding constraints

/* Syntax:
ALTER TABLE table_name
	ADD CONSTRAINT your_table_pkey PRIMARY KEY (column1, column2, ...);
*/

ALTER TABLE ade_1.al_icebreaker_data
	ADD CONSTRAINT al_pkey PRIMARY KEY (id);

ALTER TABLE ade_1.al_icebreaker_data
	ADD CONSTRAINT al_not_null 
	CHECK (first_name IS NOT NULL);
	
-- Overall: There are many, many possible use cases for ALTER TABLE

---------------------------------------------------
--- P5: Deleting your table >> DROP
--- Documentation: https://www.postgresql.org/docs/current/sql-droptable.html
---------------------------------------------------
DELETE FROM ade_1.al_icebreaker_data
WHERE first_name = 'Jibraan';

-- This action is irreversible!
-- DROP will completely delete your table from the database. To remove its contents rather than deleting it, use DELETE

-- Syntax:
-- DROP TABLE IF EXISTS table_name;

CREATE TYPE ade_1.rating AS ENUM ('U', 'PG', '12A', '15', '18'); -- create ordered type

ALTER TABLE ade_1.al_icebreaker_data
	ALTER COLUMN film_rating TYPE ade_1.rating
	USING film_rating::ade_1.rating;

