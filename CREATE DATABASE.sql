-- TO CREATE DATABASE
CREATE DATABASE LibraryDB;

-- TO MAKE IN USE OF THAT DATABASE
USE LibraryDB;


-- QUERIES TO CREATE SPECIFIC TABLES WITH SPECIFIC COLUMNS


-- 1. Categories Table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

-- 2. Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE
);

-- 3. Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    Publisher VARCHAR(100),
    PublicationYear YEAR,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- 4. BookAuthors Table (Many-to-Many)
CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- 5. Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    MembershipDate DATE
);

-- 6. Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- TO DISPLAY ALL THE TABLES
SHOW TABLES;

-- TO DISPLAY EACH TABE STRUCTURE WITH COLUMNS
DESCRIBE Books;
DESCRIBE Authors;
DESCRIBE Members;
DESCRIBE Loans;
DESCRIBE BookAuthors;
DESCRIBE Categories;
