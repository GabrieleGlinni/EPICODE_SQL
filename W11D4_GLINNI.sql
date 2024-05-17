/* Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. */

SELECT g.Name AS GenreName, COUNT(t.TrackId) AS NumberOfTracks
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
HAVING COUNT(t.TrackId) >= 10
ORDER BY NumberOfTracks DESC;

/* Trovate le tre canzoni più costose. */

SELECT Name, UnitPrice
FROM Track
ORDER BY UnitPrice DESC
LIMIT 3;

/* Elencate gli artisti che hanno canzoni più lunghe di 6 minuti. */

SELECT a.Name AS NomeArtista, t.Name AS NomeCanzone, t.Milliseconds AS Durata
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
WHERE t.Milliseconds > 360000
ORDER BY t.Milliseconds DESC;

/* Individuate la durata media delle tracce per ogni genere. */

SELECT g.Name AS GenreName, AVG(t.Milliseconds) AS AvgDuration
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;

/* Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome. */

SELECT g.Name AS NomeGenere, t.Name AS NomeCanzone
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
WHERE t.Name LIKE '%Love%'
ORDER BY g.Name, t.Name;

/* Trovate il costo medio per ogni tipologia di media. */

SELECT mt.Name AS MediaTypeName, AVG(t.UnitPrice) AS AvgUnitPrice
FROM Track t
JOIN MediaType mt ON t.MediaTypeId = mt.MediaTypeId
GROUP BY mt.Name;

/* Individuate il genere con più tracce. */

SELECT g.Name AS NomeGenere, COUNT(t.TrackId) AS NumeroTracce
FROM Genre g
JOIN Track t ON g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY NumeroTracce DESC
LIMIT 1;

/* Trovate gli artisti che hanno lo stesso numero di album dei The Rolling Stones. */

SELECT 
    artist.name, COUNT(*) AS numero_album
FROM
    album
        LEFT JOIN
    artist ON album.artistid = artist.artistid
GROUP BY artist.name
HAVING numero_album = (SELECT 
        COUNT(*)
    FROM
        album
    INNER JOIN artist ON album.artistid = artist.artistid
    WHERE
        artist.name = 'The Rolling Stones');

/* Trovate l’artista con l’album più costoso. */

SELECT a.Name AS ArtistName, al.Title AS AlbumTitle, SUM(t.UnitPrice) AS TotalPrice
FROM Artist a
JOIN Album al ON a.ArtistId = al.ArtistId
JOIN Track t ON al.AlbumId = t.AlbumId
GROUP BY a.Name, al.Title
ORDER BY TotalPrice DESC
LIMIT 1;
