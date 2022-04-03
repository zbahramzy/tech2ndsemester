USE Chinook;
-- 1. How many songs are there in the playlist “Grunge”?
SELECT COUNT(Track.Name) AS numberOfSongsInPlaylistGrunge
FROM Track, Playlist, PlaylistTrack
WHERE Playlist.Name='Grunge' AND Track.TrackId=PlaylistTrack.TrackId AND Playlist.PlaylistId=PlaylistTrack.PlaylistId;

-- 2. Show information about artists whose name includes the text “Jack” and
-- about artists whose name includes the text “John”, but not the text “Martin”.
SELECT * FROM Artist
WHERE Name LIKE '%Jack%'
OR (Name LIKE '%John%' AND Name NOT LIKE '%Martin%');

-- 3. For each country where some invoice has been issued, show the total invoice monetary amount,
-- but only for countries where at least $100 have been invoiced.
-- Sort the information from higher to lower monetary amount.
SELECT BillingCountry, SUM(Total)
FROM Invoice
GROUP BY BillingCountry
HAVING SUM(Total)>=100 ORDER BY SUM(Total) DESC;

-- 4. Get the phone number of the boss of those employees who have given support to
-- clients who have bought some song composed by “Miles Davis” in “MPEG Audio File” format.
SELECT Employee.Phone
From Employee
WHERE Employee.EmployeeId=(SELECT DISTINCT E.ReportsTo
FROM Employee E
JOIN Customer C ON E.EmployeeId=C.SupportRepId
JOIN Invoice I ON I.CustomerId=C.CustomerId
JOIN InvoiceLine IL ON IL.InvoiceId=I.InvoiceId
JOIN Track T ON T.TrackId=IL.TrackId
JOIN MediaType M ON M.MediaTypeId=T.MediaTypeId
WHERE T.Composer='Miles Davis' AND M.Name='MPEG Audio File');

-- 5. Show the information, without repeated records, of all albums that feature
-- songs of the “Bossa Nova” genre whose title starts by the word “Samba”.
SELECT DISTINCT A.AlbumId, A.Title, A.ArtistId
FROM Album A
JOIN Track T ON A.AlbumId=T.AlbumId
JOIN Genre G ON T.GenreId=G.GenreId
WHERE G.Name='Bossa Nova' AND T.Name LIKE 'Samba%';

-- 6. For each genre, show the average length of its songs in minutes (without indicating seconds).
-- Use the headers “Genre” and “Minutes”, and include only genres that have any song longer than half an hour.
SELECT Genre.Name AS Genre, AVG(Milliseconds) / 60000 AS Minutes
From Track, Genre
WHERE Track.GenreId=Genre.GenreId AND Track.GenreId IN (SELECT DISTINCT GenreId FROM Track WHERE Milliseconds > 30*60*1000)
GROUP BY Track.GenreId;

-- 7. How many client companies have no state?
SELECT COUNT(CustomerId) FROM Customer WHERE State IS NULL;

-- 8. For each employee with clients in the “USA”, “Canada” and “Mexico”
-- show the number of clients from these countries s/he has given support,
-- only when this number is higher than 6. Sort the query by number of clients.
-- Regarding the employee, show his/her first name and surname separated by a space.
-- Use “Employee” and “Clients” as headers.
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS Employee, COUNT(C.Country) AS Clients
FROM Employee E
JOIN Customer C ON E.EmployeeId=C.SupportRepId
WHERE C.Country IN ('USA', 'Canada', 'Mexico')
GROUP BY E.EmployeeId HAVING Clients > 6
ORDER BY Clients ASC;

-- 9. For each client from the “USA”, show his/her surname and name (concatenated and separated by a comma) and their fax number.
-- If they do not have a fax number, show the text “S/he has no fax”. Sort by surname and first name.
SELECT CONCAT(LastName, ', ', FirstName), IF(Fax IS NULL, 'S/he has no fax', Fax) AS Fax
FROM Customer WHERE Country='USA' ORDER BY LastName, FirstName;

-- 10. For each employee, show his/her first name, last name, and their age at the time they were hired.
SELECT FirstName, LastName, TIMESTAMPDIFF(YEAR, BirthDate, HireDate) AS AgeWhenHired
FROM Employee;

