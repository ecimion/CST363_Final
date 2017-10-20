USE cst336final;

-- -----------------------------------------------------
-- Selects from Movies and MovieStats tables to display title of movies, genre, and average rating
-- -----------------------------------------------------

SELECT Movies.Title, Movies.Genre, MovieStats.AvgUserRating 
FROM Movies JOIN MovieStats
ON Movies.MovieId = MovieStats.MovieId;


-- -----------------------------------------------------
-- Selects each avaible Genre from Movies once
-- -----------------------------------------------------
SELECT DISTINCT(Genre) FROM Movies


-- -----------------------------------------------------
-- Selects and Concats title and year as selection from Movies. Output will look like: "movie_name (yyyy)"
-- -----------------------------------------------------
SELECT CONCAT(title, ' (', Year, ')') AS selection FROM Movies


-- -----------------------------------------------------
-- Selects from Movie, Director, Movie and Movie Stats. Uses 4 INNER JOIN statements to insure MovieId is 
-- similar across all. INNER JOIN on CastCrew acts as a conduit for MovieId, DirectorId and ActorId
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


-- -----------------------------------------------------
-- Creates a View of the previous SELECT statement
-- -----------------------------------------------------
 CREATE VIEW Complete_Information AS
 SELECT m.Title AS MOVIE_NAME, m.Year AS MOVIE_YEAR, m.Genre AS MOVIE_GENRE,
                ms.Budget AS MOVIE_BUDGET, ms.Gross AS MOVIE_GROSS, ms.AcademyAwards AS MOVIE_ACADEMYAWARDS, ms.AvgUserRating AS MOVIE_AVGUSERRATING,
                CONCAT(d.Firstname, ' ', d.LastName) AS MOVIE_DIRECTORNAME,
                CONCAT(a.FirstName,' ', a.LastName) AS MOVIE_ACTORNAME, a.AcademyAwardWinner AS MOVIE_ACADEMYAWARDWINNER
 FROM Movies m
 INNER JOIN MovieStats ms ON m.MovieId = ms.MovieId
 INNER JOIN CastCrew cc ON ms.MovieId = cc.MovieId
 INNER JOIN Director d ON d.DirectorId = cc.Director
 INNER JOIN Actors a ON a.ActorId = cc.LeadActor
