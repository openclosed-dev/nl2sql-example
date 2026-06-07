---
name: writing-sql
description: Writing SQL statements
---

## SQL

* SQL statements must conform to the SQL dialect for PostgreSQL 18.
* If multiple rows are expected to be returned, `LIMIT 100` must be added to the query.
* Show SQL statements before executing them.

## Database schema

All schema objects are defined in the schema `raceform`.

See table definitions in the file `03-schema-raceform.sql`
in this directory.
Comments within the file are important and should not be ignored.
