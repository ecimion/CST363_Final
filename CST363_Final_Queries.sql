USE cst363final;

-- -----------------------------------------------------
-- Selects from Movies and MovieStats tables to display title of movies, genre, and average rating
-- -----------------------------------------------------

SELECT Movies.Title, Movies.Genre, MovieStats.AvgUserRating
FROM Movies JOIN MovieStats
ON Movies.MovieId = MovieStats.MovieId;

-- -----------------------------------------------------
-- Selects highest grossing movie in each genre
-- Can someone fix this? It's all adding to one row instead of multiple :/
-- -----------------------------------------------------

SELECT * FROM
	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Suspense'
	ORDER BY Gross DESC
	LIMIT 1) t1

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Sci-Fi'
    ORDER BY Gross DESC
	LIMIT 1) t2

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Drama'
    ORDER BY Gross DESC
	LIMIT 1) t3

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Romance'
    ORDER BY Gross DESC
	LIMIT 1) t4

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Crime'
    ORDER BY Gross DESC
	LIMIT 1) t5

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Action'
    ORDER BY Gross DESC
	LIMIT 1) t6

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Mystery'
    ORDER BY Gross DESC
	LIMIT 1) t7

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Animation'
    ORDER BY Gross DESC
	LIMIT 1) t8

JOIN

	(SELECT Title, Genre, Gross
	FROM Movies JOIN MovieStats
	WHERE Movies.MovieId = MovieStats.MovieId
	AND Genre = 'Horror'
    ORDER BY Gross DESC
	LIMIT 1) t9



-- -----------------------------------------------------
-- Selects each avaible Genre from Movies once
-- -----------------------------------------------------
SELECT DISTINCT(Genre) FROM Movies


-- -----------------------------------------------------
-- Selects and Concats title and year as selection from Movies. Output will look like: "movie_name (yyyy)"
-- -----------------------------------------------------
SELECT CONCAT(title, ' (', Year, ')') AS selection FROM Movies


-- -----------------------------------------------------
--  Crates a view that selects from Movie, Director, Movie and Movie Stats. Uses 4 INNER JOIN statements to insure MovieId is
-- similar across all. INNER JOIN on CastCrew acts as a conduit for MovieId, DirectorId and ActorId
-- -----------------------------------------------------
 CREATE VIEW Complete_Information AS
 SELECT m.MovieId, m.Title AS MOVIE_NAME, m.Year AS MOVIE_YEAR, m.Genre AS MOVIE_GENRE,
                ms.Budget AS MOVIE_BUDGET, ms.Gross AS MOVIE_GROSS, ms.AcademyAwards AS MOVIE_ACADEMYAWARDS, ms.AvgUserRating AS MOVIE_AVGUSERRATING,
                CONCAT(d.Firstname, ' ', d.LastName) AS MOVIE_DIRECTORNAME,
                CONCAT(a.FirstName,' ', a.LastName) AS MOVIE_ACTORNAME, a.AcademyAwardWinner AS MOVIE_ACADEMYAWARDWINNER
 FROM Movies m
 INNER JOIN MovieStats ms ON m.MovieId = ms.MovieId
 INNER JOIN CastCrew cc ON ms.MovieId = cc.MovieId
 INNER JOIN Director d ON d.DirectorId = cc.Director
 INNER JOIN Actors a ON a.ActorId = cc.LeadActor


-- -----------------------------------------------------
-- Updates the MovieStat's Average User Rating by using a select statment to average ratings from the MovieRatings table
-- -----------------------------------------------------
UPDATE MovieStats ms
SET AvgUserRating = (SELECT AVG(Rating) FROM MovieRatings mr WHERE ms.MovieId = mr.MovieId)


-- -----------------------------------------------------
-- Creates a view that selects a CONCAT of title and year, average user rating, username, user first name, user last name and a movie rating from each user.
-- Inner Joins are used to gather similar data between each table.
-- -----------------------------------------------------
CREATE VIEW UserRatings AS
SELECT m.MovieId, CONCAT(m.title, ' (', m.Year, ')') AS MOVIE_NAME_YEAR, ms.AvgUserRating, u.UserName, u.FirstName, u.LastName, mr.Rating
FROM MovieRatings mr
INNER JOIN MovieStats ms ON mr.MovieID = ms.MovieId
INNER JOIN Movies m ON mr.MovieId = m.MovieId
INNER JOIN Users u ON mr.UserId = u.UserId
