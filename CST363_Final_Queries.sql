-- -----------------------------------------------------
-- Selects from Movies and MovieStats tables to display title of movies, genre, and average rating
-- -----------------------------------------------------

SELECT cst336final.Movies.Ttitle, cst336final.Movies.Genre, cst336final.MovieStats.AvgUserRating 
FROM cst336final.Movies JOIN cst336final.MovieStats
ON cst336final.Movies.MovieId = cst336final.MovieStats.MovieId;
