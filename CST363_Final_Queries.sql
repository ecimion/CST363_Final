-- -----------------------------------------------------
-- Selects from Movies and MovieStats tables to display title of movies, genre, and average rating
-- -----------------------------------------------------

SELECT cst336final.Movies.Ttitle, cst336final.Movies.Genre, cst336final.MovieStats.AvgUserRating 
FROM cst336final.Movies JOIN cst336final.MovieStats
ON cst336final.Movies.MovieId = cst336final.MovieStats.MovieId;


-- -----------------------------------------------------
-- Selects from Movies table to display just the Genre
-- -----------------------------------------------------
SELECT DISTINCT(Genre) FROM Movies


-- -----------------------------------------------------
-- Selects from Movies table to display just the title and Year as: Title (Year)
-- -----------------------------------------------------
SELECT CONCAT(title, ' (', Year, ' )') AS selection FROM Movies


-- -----------------------------------------------------
-- Uses Inner Joins to collect similar data based on tags to output complete movie information
-- -----------------------------------------------------
 SELECT m.Title AS MOVIE_NAME, m.Year AS MOVIE_YEAR, m.Genre AS MOVIE_GENRE,
                ms.Budget AS MOVIE_BUDGET, ms.Gross AS MOVIE_GROSS, ms.AcademyAwards AS MOVIE_ACADEMYAWARDS, ms.AvgUserRating AS MOVIE_AVGUSERRATING,
                CONCAT(d.Firstname, ' ', d.LastName) AS MOVIE_DIRECTORNAME,
                CONCAT(a.FirstName,' ', a.LastName) AS MOVIE_ACTORNAME, a.AcademyAwardWinner AS MOVIE_ACADEMYAWARDWINNER
 FROM Movies m
 INNER JOIN MovieStats ms ON m.MovieId = ms.MovieId
 INNER JOIN CastCrew cc ON ms.MovieId = cc.MovieId
 INNER JOIN Director d ON d.DirectorId = cc.Director
 INNER JOIN Actors a ON a.ActorId = cc.LeadActor