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

function get_movie_info($id) {
    $db = db_Query("Select * FROM Complete_Information WHERE MovieId = '$id'");
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

            print "<div class='info_movie_text'><a onclick='open_panel(\"$id\")' style='color: blue; cursor: pointer;'>Click here to view user ratings</a></div>";
        }
    }
    else {
        print "<p>DATABASE ERROR</p>";
    }
}


function get_panel($id) {
    $db = db_Query("SELECT * FROM UserRatings WHERE MovieId='$id'");
    if($db->num_rows > 0) {
        while($row = $db->fetch_assoc()) {
            print "<div class='panel_text_header'>" . $row['MOVIE_NAME_YEAR'] . "</div>";
            print "<div class='panel_text_header'>" . $row['AvgUserRating'] . "</div>";
            break;
        }
        while($row = $db->fetch_assoc()) {
            print "<div class='panel_text'>Username: " . $row['UserName'] ."</div>";
            print "<div class='panel_text'>First Name: " . $row['FirstName'] ."</div>";
            print "<div class='panel_text'>Last Name: " . $row['LastName'] ."</div>";
            if($row['rating'] >= 0.75) {
                print "<div class='panel_text' style='color:green;'>Rating: " . $row['Rating'] ."</div>";
            }
            if($row['rating'] < 0.75 && $row['rating'] >= 0.5) {
                print "<div class='panel_text' style='color:orange;'>Rating: " . $row['Rating'] ."</div>";
            }
            if($row['rating'] < 0.5) {
                print "<div class='panel_text' style='color:red;'>Rating: " . $row['Rating'] ."</div>";
            }
            print "<br>";
        }
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
if($orders == "get_panel") { get_panel($id); }