USE cst363final;

-- -----------------------------------------------------
-- Selects from Movies and MovieStats tables to display title of movies, genre, and average rating
-- -----------------------------------------------------

SELECT Movies.Title, Movies.Genre, MovieStats.AvgUserRating
FROM Movies JOIN MovieStats
ON Movies.MovieId = MovieStats.MovieId;

-- -----------------------------------------------------
-- SELECTS all movies and orders by how much they grossed
-- -----------------------------------------------------

SELECT m.Title, m.Genre,ms.GrosS AS MAX_GROSS
FROM Movies 
INNER JOIN MovieStats ms ON ms.MovieId = m.MovieId
ORDER BY Gross DESC

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


-- -----------------------------------------------------
-- Selects the top 5 highest rated movies based on aveage user reviews
-- -----------------------------------------------------
SELECT * FROM Complete_Information ORDER BY AvgUserRating LIMIT 5