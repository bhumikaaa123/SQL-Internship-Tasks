# Day 01: Library Database

## Objective
Design and create a normalized relational database for a library system. This task includes creating an ER diagram, normalizing tables to 3NF, and writing SQL scripts to implement the database.

## Tools Used
- MySQL
- dbdiagram.io
- Word / Markdown for documentation

  ## Entities and Tables
The database includes the following tables:
1. *Categories* – Organizes books into categories (e.g., Fiction, Science).  
2. *Authors* – Stores information about authors.  
3. *Books* – Stores information about books and references categories.  
4. *BookAuthors* – Handles many-to-many relationship between Books and Authors.  
5. *Members* – Stores library members’ information.  
6. *Loans* – Tracks which books are borrowed by which members and when.

## Deliverables
1. *ER Diagram* – Shows tables and relationships.
2. *Normalization Report* – Demonstrates 1NF → 2NF → 3NF.
3. *SQL Scripts* – create_database.sql containing all CREATE TABLE statements with PKs and FKs.
4. *SQL Output Screenshots* – Proof of table creation.
