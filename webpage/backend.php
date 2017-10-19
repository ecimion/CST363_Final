<?php

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Tools

function db_Query($query) {
    $conn = new mysqli("localhost", "root", "airpolo3", "cst336final");
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
    $db = db_Query("SELECT DISTINCT(Genre) FROM Movies");
    if($db->num_rows > 0) {
        print "<div class='bottom_header'>Choose a Genre</div>";
        print "<ul>";
        while($row = $db->fetch_assoc()) {
            print "<li><a class='genre_selection_item' onclick='populate_movies(\"" . $row['Genre'] . "\")'>" . $row['Genre']. "</a></li>";
        }
        print "</ul>";
    }
    else {
        print "<p>Didn't return anything</p>";
    }
}

function get_movies($genre) {
    $db = db_Query("SELECT CONCAT(title, ' (', Year, ' )') AS selection, MovieId FROM Movies WHERE Genre = '$genre'");
    if($db->num_rows > 0) {
        print "<div class='bottom_header'>Choose a Movie</div>";
        print "<ul>";
        while($row = $db->fetch_assoc()) {
            print "<li><a class='movie_selection_item' onclick='get_movie_info(\"" . $row['MovieId'] ."\")'>" . $row['selection']. "</a></li>";
        }
        print "</ul>";
    }
    else {
        print "<p>Didn't return anything</p>";
    }
}

function get_movie_info($id) {
    $db = db_Query("SELECT CONCAT(title, ' (', Year, ' )') AS selection, MovieId FROM Movies WHERE Genre = '$genre'");
    if($db->num_rows > 0) {
        print "<div class='bottom_header'>Choose a Movie</div>";
        print "<ul>";
        while($row = $db->fetch_assoc()) {
            print "<li><a class='Movie_selection_item' onclick='get_movie_info(\"" . $row['MovieId'] ."\")'>" . $row['selection']. "</a></li>";
        }
        print "</ul>";
    }
    else {
        print "<p>Didn't return anything</p>";
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