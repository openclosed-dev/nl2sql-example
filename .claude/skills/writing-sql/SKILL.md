---
name: writing-sql
description: |
  How to create SQL statements to query the horse racing database.
---

## SQL

* SQL statements must conform to the SQL dialect for PostgreSQL 18.
* If multiple rows are expected to be returned, `LIMIT 100` must be added to the query.
* Show SQL statements before executing them.

## Database schema

All schema objects are defined in the schema `raceform`.

See table definitions in the file `03-schema-raceform.sql`
in this directory.

The comments in the file contain explanations about tables and columns.
Take these explanations into careful consideration when creating SQL statements.
