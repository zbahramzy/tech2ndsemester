USE library;
SHOW TABLES;
SHOW COLUMNS FROM tauthor;
SHOW COLUMNS FROM tauthorship; -- links each book to the author of the book, connects tbook to tauthor
SHOW COLUMNS FROM tbook;
SHOW COLUMNS FROM tbookcopy; -- links each loan to a book, connects tloan to tbook
SHOW COLUMNS FROM tbooktheme;
SHOW COLUMNS FROM tcountry;
SHOW COLUMNS FROM tloan;
SHOW COLUMNS FROM tmember;
SHOW COLUMNS FROM tnationality;
SHOW COLUMNS FROM tpublishingcompany;
SHOW COLUMNS FROM ttheme;
SELECT * FROM tauthor;
SELECT * FROM tauthorship;
SELECT * FROM tbook;
SELECT * FROM tbookcopy;
SELECT * FROM tbooktheme;
SELECT * FROM tcountry;
SELECT * FROM tloan;
SELECT * FROM tmember;
SELECT * FROM tnationality;
SELECT * FROM tpublishingcompany;
SELECT * FROM ttheme;

SELECT DISTINCT * FROM tmember;
SELECT * FROM tmember LIMIT 5 OFFSET 1;
SELECT * FROM tmember LIMIT 1, 5;
SELECT * FROM tmember ORDER BY cName;
SELECT * FROM tmember WHERE dBirth BETWEEN '2000-01-01' AND '2020-01-01';
-- SELECT CONCAT(FirstName,', ', City) AS new_column FROM customers;
-- ASC, DESC

-- 1. Show the members under the name "Jens S." who were born
-- before 1970 that became members of the library in 2013.
SELECT * FROM tmember WHERE cName='Jens S.' AND year(dBirth)<'1970' AND year(dNewMember)='2013';

-- 2. Show those books that have not been published by the publishing
-- companies with ID 15 and 32, except if they were published before 2000.
SELECT * FROM tbook where nPublishingCompanyID NOT IN (15,32) OR nPublishingYear<'2000' ORDER BY nPublishingCompanyID;

-- 3. Show the name and surname of the members who have a phone number, but no address.
SELECT cName, cSurname FROM tmember WHERE cPhoneNo IS NOT NULL AND cAddress IS NULL;

-- 4. Show the authors with surname "Byatt" whose name starts by an "A" (uppercase) and contains an "S" (uppercase).
SELECT * FROM tauthor WHERE cSurname='Byatt' AND (cNAME LIKE BINARY 'A%' AND cName LIKE BINARY '%S%');

-- 5. Show the number of books published in 2007 by the publishing company with ID 32.
SELECT * FROM tbook where nPublishingYear='2007' AND nPublishingCompanyID=32;

-- 6. For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT library.tloan.dLoan, library.tbook.nBookID, library.tbook.cTitle, library.tloan.cCPR
FROM tloan, tbook, tbookcopy
WHERE library.tloan.cCPR='0305393207' AND library.tloan.cSignature=library.tbookcopy.cSignature
  AND library.tbookcopy.nBookID=library.tbook.nBookID
  AND year(library.tloan.dLoan)='2014' ORDER BY dLoan ASC;

-- 7. Modify the previous clause so that only those days where the member was loaned more than one book appear.