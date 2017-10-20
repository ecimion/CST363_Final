<?php

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Tools

function db_Query($query) {
    $conn = new mysqli("localhost", "root", "airpolo3", "cst363final");
    if ($conn->connect_error) { print "Database Connection Error"; }
    $result = $conn->query($query);
    $conn->close();
    return $result;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Do Work

function get_genres() {
    $db = db_Query("SELECT DISTINCT(Genre) FROM Movies ORDER BY Genre");
    if($db->num_rows > 0) {
        print "<div class='bottom_header'>Choose a Genre</div>";
        print "<ul>";
        while($row = $db->fetch_assoc()) {
            print "<li><a class='genre_selection_item' onclick='populate_movies(\"" . $row['Genre'] . "\")'>" . $row['Genre']. "</a></li>";
        }
        print "</ul>";
    }
    else {
        print "<p>DATABASE ERROR</p>";
    }
}

function get_movies($genre) {
    $db = db_Query("SELECT CONCAT(title, ' (', Year, ')') AS selection, MovieId FROM Movies WHERE Genre = '$genre' ORDER BY title ASC");
    if($db->num_rows > 0) {
        print "<div class='bottom_header'>Choose a Movie</div>";
        print "<ul>";
        while($row = $db->fetch_assoc()) {
            print "<li><a class='movie_selection_item' onclick='get_movie_info(\"" . $row['MovieId'] ."\")'>" . $row['selection']. "</a></li>";
        }
        print "</ul>";
    }
    else {
        print "<p>DATABASE ERROR</p>";
    }
}


/*

 SELECT m.Title AS MOVIE_NAME, m.Year AS MOVIE_YEAR, m.Genre AS MOVIE_GENRE,
                ms.Budget AS MOVIE_BUDGET, ms.Gross AS MOVIE_GROSS, ms.AcademyAwards AS MOVIE_ACADEMYAWARDS, ms.AvgUserRating AS MOVIE_AVGUSERRATING,
                CONCAT(d.Firstname, ' ', d.LastName) AS MOVIE_DIRECTORNAME,
                CONCAT(a.FirstName,' ', a.LastName) AS MOVIE_ACTORNAME, a.AcademyAwardWinner AS MOVIE_ACADEMYAWARDWINNER
 FROM Movies m
 INNER JOIN MovieStats ms ON m.MovieId = ms.MovieId
 INNER JOIN CastCrew cc ON ms.MovieId = cc.MovieId
 INNER JOIN Director d ON d.DirectorId = cc.Director
 INNER JOIN Actors a ON a.ActorId = cc.LeadActor
 WHERE m.MovieId = '$id'
 */


function get_movie_info($id) {
    $db = db_Query("
         SELECT m.Title AS MOVIE_NAME, m.Year AS MOVIE_YEAR, m.Genre AS MOVIE_GENRE,
                ms.Budget AS MOVIE_BUDGET, ms.Gross AS MOVIE_GROSS, ms.AcademyAwards AS MOVIE_ACADEMYAWARDS, ms.AvgUserRating AS MOVIE_AVGUSERRATING,
                CONCAT(d.Firstname, ' ', d.LastName) AS MOVIE_DIRECTORNAME,
                CONCAT(a.FirstName,' ', a.LastName) AS MOVIE_ACTORNAME, a.AcademyAwardWinner AS MOVIE_ACADEMYAWARDWINNER
         FROM Movies m
         INNER JOIN MovieStats ms ON m.MovieId = ms.MovieId
         INNER JOIN CastCrew cc ON ms.MovieId = cc.MovieId
         INNER JOIN Director d ON d.DirectorId = cc.Director
         INNER JOIN Actors a ON a.ActorId = cc.LeadActor
         WHERE m.MovieId = '$id'");
    if($db->num_rows > 0) {
        while($row = $db->fetch_assoc()) {
            print "<div class='info_movie_name'>" . $row['MOVIE_NAME'] ."</div>";

            print "<div class='info_movie_text'><b>Year: </b>" . $row['MOVIE_YEAR'] . "</div>";
            print "<div class='info_movie_text'><b>Genre: </b>" . $row['MOVIE_GENRE'] . "</div>";
            print "<div class='info_movie_text'><b style='color:red;'>Budget: </b>" . $row['MOVIE_BUDGET'] . "</div>";
            print "<div class='info_movie_text'><b style='color:green;'>Gross: </b>" . $row['MOVIE_GROSS'] . "</div>";
            print "<div class='info_movie_text'><b>Academy Awards: </b>" . $row['MOVIE_ACADEMYAWARDS'] . "</div>";
            print "<div class='info_movie_text'><b>Average User Rating: </b>" . $row['MOVIE_AVGUSERRATING'] . "</div>";
            print "<div class='info_movie_text'><b>Director: </b>" . $row['MOVIE_DIRECTORNAME'] . "</div>";
            print "<div class='info_movie_text'><b>Lead Actor: </b>" . $row['MOVIE_ACTORNAME'] . "</div>";

            if($row['MOVIE_ACADEMYAWARDWINNER'] == 'T') {
                print "<div class='info_movie_text'><i>Academy Award Winning Actor</i></div>";
            }

//            print "<div class='info_movie_text'><strong>: </strong>" . $row[''] . "</div>";
//            print "<div class='info_movie_text'><strong>: </strong>" . $row[''] . "</div>";
        }
    }
    else {
        print "<p>DATABASE ERROR</p>";
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Received from front end

$orders = $_GET['orders'];
$genre = $_GET['genre'];
$id = $_GET['id'];

if($orders == "get_movies") { get_movies($genre); }
if($orders == "get_genres") { get_genres(); }
if($orders == "get_movie_info") { get_movie_info($id); }
