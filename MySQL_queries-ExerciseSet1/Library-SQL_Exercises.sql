USE library;
-- 1. Show the members under the name "Jens S." who were born
-- before 1970 that became members of the library in 2013.
SELECT * FROM tmember
WHERE cName='Jens S.' AND year(dBirth)<'1970' AND year(dNewMember)='2013';

-- 2. Show those books that have not been published by the publishing
-- companies with ID 15 and 32, except if they were published before 2000.
SELECT * FROM tbook
WHERE nPublishingCompanyID NOT IN (15,32) OR nPublishingYear<'2000' ORDER BY nPublishingCompanyID;

-- 3. Show the name and surname of the members who have a phone number, but no address.
SELECT cName, cSurname FROM tmember
WHERE cPhoneNo IS NOT NULL AND cAddress IS NULL;

-- 4. Show the authors with surname "Byatt" whose name starts by an "A" (uppercase) and contains an "S" (uppercase).
SELECT * FROM tauthor
WHERE cSurname='Byatt' AND cNAME LIKE BINARY 'A%' AND cName LIKE BINARY '%S%';

-- 5. Show the number of books published in 2007 by the publishing company with ID 32.
SELECT COUNT(tbook.nBookID) FROM tbook
WHERE nPublishingYear='2007' AND nPublishingCompanyID=32;

-- 6. For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT tloan.dLoan, COUNT(tbook.nBookID)
FROM tloan
JOIN tbookcopy ON tloan.cSignature=tbookcopy.cSignature
JOIN tbook ON tbookcopy.nBookID=tbook.nBookID
WHERE library.tloan.cCPR='0305393207' AND year(library.tloan.dLoan)='2014'
GROUP BY tloan.dLoan ORDER BY tloan.dLoan;

-- 7. Modify the previous clause so that only those days where the member was loaned more than one book appear.
SELECT tloan.dLoan, COUNT(tbook.nBookID)
FROM tloan
JOIN tbookcopy ON tloan.cSignature=tbookcopy.cSignature
JOIN tbook ON tbookcopy.nBookID=tbook.nBookID
WHERE library.tloan.cCPR='0305393207' AND year(library.tloan.dLoan)='2014'
GROUP BY tloan.dLoan HAVING COUNT(tbook.nBookID)>1
ORDER BY tloan.dLoan;

-- 8. Show all library members from the newest to the oldest.
-- Those who became members on the same day will be sorted alphabetically
-- (by surname and name) within that day.
SELECT * FROM tmember
ORDER BY dNewMember DESC, cSurname, cName;

-- 9. Show the title of all books published by the publishing company with ID 32 along with their theme or themes.
SELECT tbook.cTitle, ttheme.cName
FROM tbook, tbooktheme, ttheme
WHERE tbook.nBookID=tbooktheme.nBookID AND tbooktheme.nThemeID=ttheme.nThemeID AND tbook.nPublishingCompanyID=32;

-- 10. Show the name and surname of every author along with the number of books authored by them,
-- but only for authors who have registered books on the database.
SELECT tauthor.cName, tauthor.cSurname, COUNT(tbook.cTitle)
FROM tauthor, tauthorship, tbook
WHERE tauthor.nAuthorID=tauthorship.nAuthorID AND tbook.nBookID=tauthorship.nBookID
GROUP BY tauthor.nAuthorID ORDER BY COUNT(tbook.cTitle);

-- 11. Show the name and surname of all the authors with published
-- books along with the lowest publishing year for their books.
SELECT tauthor.cName, tauthor.cSurname, Min(tbook.nPublishingYear)
FROM tauthor, tauthorship, tbook
WHERE tauthor.nAuthorID=tauthorship.nAuthorID AND tauthorship.nBookID=tbook.nBookID
GROUP BY tauthor.cName, tauthor.cSurname
ORDER BY tauthor.cSurname, tauthor.cName, Min(tbook.nPublishingYear);

-- 12. For each signature and loan date, show the title of the corresponding
-- books and the name and surname of the member who had them loaned.
SELECT tloan.dLoan, tbook.cTitle, tmember.cName, tmember.cSurname
FROM tloan, tbook, tmember, tbookcopy
WHERE tbook.nBookID=tbookcopy.nBookID AND tbookcopy.cSignature=tloan.cSignature AND tloan.cCPR=tmember.cCPR
ORDER BY tloan.dLoan DESC;

# 13. Repeat exercises 9 to 12 using the modern JOIN notation.
# 13.9
SELECT tbook.cTitle, ttheme.cName
FROM tbook
JOIN tbooktheme ON tbooktheme.nBookID=tbook.nBookID
JOIN ttheme ON ttheme.nThemeID=tbooktheme.nThemeID
WHERE nPublishingCompanyID=32;
# 13.10
SELECT tauthor.cName, tauthor.cSurname, COUNT(tbook.cTitle)
FROM tauthor
JOIN tauthorship ON tauthor.nAuthorID=tauthorship.nAuthorID
JOIN tbook ON tbook.nBookID=tauthorship.nBookID
GROUP BY tauthor.nAuthorID ORDER BY COUNT(tbook.cTitle);
# 13.11
SELECT tauthor.cName, tauthor.cSurname, MIN(tbook.nPublishingYear)
FROM tauthor
JOIN tauthorship ON tauthor.nAuthorID=tauthorship.nAuthorID
JOIN tbook ON tauthorship.nBookID=tbook.nBookID
GROUP BY tauthor.cName, tauthor.cSurname
ORDER BY tauthor.cSurname, tauthor.cName, MIN(tbook.nPublishingYear);
# 13.12
SELECT tloan.dLoan, tbook.cTitle, tmember.cName, tmember.cSurname
FROM tbook
JOIN tbookcopy ON tbook.nBookID=tbookcopy.nBookID
JOIN tloan ON tbookcopy.cSignature=tloan.cSignature
JOIN tmember ON tloan.cCPR=tmember.cCPR
ORDER BY tloan.dLoan DESC;

# 14. Show all theme names along with the titles of their associated books.
# All themes must appear (even if there are no books for some particular themes).
# Sort by theme name.
SELECT ttheme.cName, tbook.cTitle
FROM ttheme
LEFT JOIN tbooktheme ON ttheme.nThemeID=tbooktheme.nThemeID
LEFT JOIN tbook ON tbooktheme.nBookID=tbook.nBookID
ORDER BY ttheme.cName ASC;

# 15. Show the name and surname of all members who joined the library in 2013
# along with the title of the books they took on loan during that same year.
# All members must be shown, even if they did not take any book on loan during 2013.
# Sort by member surname and name.
SELECT tmember.cName, tmember.cSurname, tbook.cTitle, YEAR(tmember.dNewMember), YEAR(tloan.dLoan)
FROM tbook
JOIN tbookcopy ON tbookcopy.nBookID=tbook.nBookID
JOIN tloan ON tloan.cSignature=tbookcopy.cSignature
RIGHT JOIN tmember ON tmember.cCPR=tloan.cCPR AND YEAR(tloan.dLoan)='2013'
WHERE YEAR(tmember.dNewMember)='2013'
ORDER BY tmember.cSurname, tmember.cName;

# 16. Show the name and surname of all authors
# along with their nationality or nationalities and the titles of their books.
# Every author must be shown, even though s/he has no registered books.
# Sort by author name and surname.
SELECT tauthor.cName, tauthor.cSurname, tcountry.cName, tbook.cTitle
FROM tbook
JOIN tauthorship ON tauthorship.nBookID=tbook.nBookID
RIGHT JOIN tauthor ON tauthor.nAuthorID=tauthorship.nAuthorID
JOIN tnationality ON tnationality.nAuthorID=tauthor.nAuthorID
JOIN tcountry ON tcountry.nCountryID=tnationality.nCountryID
ORDER BY tauthor.cName, tauthor.cSurname;

# 17. Show the title of those books which have had
# different editions published in both 1970 and 1989.
SELECT cTitle
FROM tbook
WHERE nPublishingYear IN ('1970','1989')
GROUP BY cTitle
HAVING COUNT(*) > 1;

# 18. Show the surname and name of all members who joined the library in December 2013
# followed by the surname and name of those authors whose name is “William”.
SELECT tmember.cSurname, tmember.cName, dNewMember, tauthor.cSurname, tauthor.cName
FROM tmember, tauthor
WHERE YEAR(dNewMember)='2013' AND MONTH(dNewMember)='12' AND tauthor.cName='William';

# 19. Show the name and surname of the first chronological member of the library using subqueries.
SELECT cName, cSurname, dNewMember FROM tmember
WHERE dNewMember=(SELECT min(dNewMember) FROM tmember);

# 20. For each publishing year, show the number of book titles published by publishing
# companies from countries that constitute the nationality for at least three authors.
# Use subqueries.
SELECT tbook.nPublishingYear, COUNT(tbook.nBookID)
FROM tbook, tpublishingcompany
WHERE tbook.nPublishingCompanyID=tpublishingcompany.nPublishingCompanyID AND tpublishingcompany.nCountryID IN
    (SELECT tnationality.nCountryID
    FROM tnationality
    JOIN tauthor ON tauthor.nAuthorID=tnationality.nAuthorID
    GROUP BY tnationality.nCountryID HAVING COUNT(tauthor.nAuthorID)>=3)
GROUP BY tbook.nPublishingYear ORDER BY COUNT(tbook.nBookID);

# 21. Show the name and country of all publishing companies with the headings "Name" and "Country".
SELECT tpublishingcompany.cName Name, tcountry.cName Country
FROM tpublishingcompany, tcountry
WHERE tpublishingcompany.nCountryID=tcountry.nCountryID;

# 22. Show the titles of the books published between 1926 and
# 1978 that were not published by the publishing company with ID 32.
SELECT cTitle FROM tbook
WHERE nPublishingYear BETWEEN '1926' AND '1978' AND nPublishingCompanyID!=32;

# 23. Show the name and surname of the members who joined the library after 2016 and have no address.
SELECT cName, cSurname FROM tmember
WHERE YEAR(dNewMember)>2016 AND cAddress IS NULL
ORDER BY dNewMember ASC;

# 24. Show the country codes for countries with publishing companies. Exclude repeated values.
SELECT DISTINCT tpublishingcompany.nCountryID
FROM tpublishingcompany
JOIN tcountry ON tcountry.nCountryID=tpublishingcompany.nCountryID;

# 25. Show the titles of books whose title starts by "The Tale" and that are not published by "Lynch Inc".
SELECT cTitle FROM tbook
JOIN tpublishingcompany tp ON tp.nPublishingCompanyID=tbook.nPublishingCompanyID
WHERE cTitle LIKE 'The Tale%' AND tp.cName NOT LIKE 'Lynch Inc%';

# 26. Show the list of themes for which the publishing company "Lynch Inc" has published books, excluding repeated values.
SELECT DISTINCT ttheme.nThemeID, ttheme.cName
FROM ttheme
JOIN tbooktheme ON tbooktheme.nThemeID=ttheme.nThemeID
JOIN tbook ON tbook.nBookID=tbooktheme.nBookID
JOIN tpublishingcompany ON tpublishingcompany.nPublishingCompanyID=tbook.nPublishingCompanyID AND tpublishingcompany.cName LIKE 'Lynch Inc%';

# 27. Show the titles of those books which have never been loaned.
SELECT tbook.cTitle FROM tbook
WHERE tbook.nBookID NOT IN (SELECT tbookcopy.nBookID FROM tbookcopy);

# 28. For each publishing company, show its number of existing books under the heading "No. of Books".
SELECT tpublishingcompany.cName, COUNT(tbook.nBookID) AS 'No. of Books'
FROM tpublishingcompany
JOIN tbook ON tbook.nPublishingCompanyID=tpublishingcompany.nPublishingCompanyID
GROUP BY tpublishingcompany.cName ORDER BY COUNT(tbook.nBookID);

# 29. Show the number of members who took some book on a loan during 2013.
SELECT COUNT(*)
FROM tmember
JOIN tloan ON tmember.cCPR=tloan.cCPR
WHERE YEAR(tloan.dLoan)='2013';

# 30. For each book that has at least two authors,
# show its title and number of authors under the heading "No. of Authors".
SELECT tbook.cTitle, COUNT(tauthor.nAuthorID) AS 'No. of Authors'
FROM tbook
JOIN tauthorship ON tbook.nBookID=tauthorship.nBookID
JOIN tauthor ON tauthor.nAuthorID=tauthorship.nAuthorID
GROUP BY tbook.nBookID HAVING COUNT(tauthor.nAuthorID)>=2;