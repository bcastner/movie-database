-- create new schema database --
CREATE SCHEMA `movie_database` ;

-- initiate the database --
USE movie_database;

-- let's create the tables --
-- create the genres table --
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50)
);

-- create the directors table --
CREATE TABLE Directors (
    director_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    nationality VARCHAR(50)
);

-- create the actors table --
CREATE TABLE Actors (
    actor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    nationality VARCHAR(50)
);

-- create the movies table --
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    release_year INT,
    genre_id INT,
    director_id INT,
    runtime INT,
    language VARCHAR(50),
    FOREIGN KEY (genre_id)
        REFERENCES Genres (genre_id),
    FOREIGN KEY (director_id)
        REFERENCES Directors (director_id)
);

-- create movieactors table --
CREATE TABLE MovieActors (
    movie_id INT,
    actor_id INT,
    role VARCHAR(100),
    PRIMARY KEY (movie_id , actor_id),
    FOREIGN KEY (movie_id)
        REFERENCES Movies (movie_id),
    FOREIGN KEY (actor_id)
        REFERENCES Actors (actor_id)
);

-- create users table --
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    registration_date DATE
);

-- create ratings table --
CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    rating_date DATE,
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (movie_id)
        REFERENCES Movies (movie_id)
);

-- create the reviews table --
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (user_id)
        REFERENCES Users (user_id),
    FOREIGN KEY (movie_id)
        REFERENCES Movies (movie_id)
);

-- insert sample data --
-- we will insert multiple records into each table --
-- insert genre names into the genres table --
INSERT INTO Genres (genre_name) VALUES
('Action'),
('Comedy'),
('Drama'),
('Thriller'),
('Science Fiction'),
('Romance');
    
-- insert director info into the directors table -- 
INSERT INTO Directors (first_name, last_name, birth_date, nationality) VALUES
('Christopher', 'Nolan', '1970-07-30', 'British-American'),
('Quentin', 'Tarantino', '1963-03-27', 'American'),
('Steven', 'Spielberg', '1946-12-18', 'American'),
('Martin', 'Scorsese', '1942-11-17', 'American');

-- insert actor info into the actors table -- 
INSERT INTO Actors (first_name, last_name, birth_date, nationality) VALUES
('Leonardo', 'DiCaprio', '1974-11-11', 'American'),
('Brad', 'Pitt', '1963-12-18', 'American'),
('Tom', 'Hardy', '1977-09-15', 'British'),
('Scarlett', 'Johansson', '1984-11-22', 'American'),
('Morgan', 'Freeman', '1937-06-01', 'American');

-- insert movie data into the movies table -- 
INSERT INTO Movies (title, release_year, genre_id, director_id, runtime, language) VALUES
('Inception', 2010, 5, 1, 148, 'English'),
('The Dark Knight', 2008, 1, 1, 152, 'English'),
('Pulp Fiction', 1994, 4, 2, 154, 'English'),
('The Wolf of Wall Street', 2013, 3, 4, 180, 'English'),
('Interstellar', 2014, 5, 1, 169, 'English'),
('Fight Club', 1999, 1, 4, 139, 'English');

-- insert data into the movieactors table -- 
-- Inception --
INSERT INTO MovieActors (movie_id, actor_id, role) VALUES
(1, 1, 'Dom Cobb'),
(1, 3, 'Eames');

-- The Dark Knight --
INSERT INTO MovieActors (movie_id, actor_id, role) VALUES
(2, 3, 'Bane');

-- Pulp Fiction --
INSERT INTO MovieActors (movie_id, actor_id, role) VALUES
(3, 2, 'Tyler Durden');

-- The Wolf of Wall Street --
INSERT INTO MovieActors (movie_id, actor_id, role) VALUES
(4, 1, 'Jordan Belfort');

-- Interstellar --
INSERT INTO MovieActors (movie_id, actor_id, role) VALUES
(5, 1, 'Cooper');

-- Fight Club --
INSERT INTO MovieActors (movie_id, actor_id, role) VALUES
(6, 2, 'Tyler Durden');

-- insert user data into the users table --
INSERT INTO Users (username, email, password_hash, registration_date) VALUES
('user1', 'user1@example.com', 'hash1', '2023-01-15'),
('user2', 'user2@example.com', 'hash2', '2023-02-20'),
('user3', 'user3@example.com', 'hash3', '2023-03-05'),
('user4', 'user4@example.com', 'hash4', '2023-04-10');

-- insert rating data into the ratings table --
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES
(1, 1, 9, '2023-05-01'),
(1, 2, 8, '2023-05-02'),
(2, 3, 9, '2023-05-03'),
(3, 4, 7, '2023-05-04'),
(4, 5, 10, '2023-05-05'),
(2, 6, 8, '2023-05-06');

-- insert review data into the reviews table -- 
INSERT INTO Reviews (user_id, movie_id, review_text, review_date) VALUES
(1, 1, 'Amazing movie with a complex plot.', '2023-05-10'),
(2, 3, 'A masterpiece of storytelling.', '2023-05-11'),
(3, 4, 'Great performances but too long.', '2023-05-12'),
(4, 5, 'Visually stunning and thought-provoking.', '2023-05-13');

-- start with some simple queries to manipulate and extract data --
-- retrieve all movies --
SELECT 
    *
FROM
    Movies;
    
-- select first and last names of all actors --
SELECT 
    first_name, last_name
FROM
    Actors;
    
-- get movies released after 2010 --
SELECT 
    title, release_year
FROM
    movies
WHERE
    release_year > 2010;
    
-- find all movies in the science fiction genre --
SELECT 
    M.title
FROM
    Movies M
        JOIN
    Genres G ON M.genre_id = G.genre_id
WHERE
    G.genre_name = 'Science Fiction';
    
-- get all reviews for a specific movie (e.g., movie_id = 1) --
SELECT 
    R.review_text, R.review_date, U.username
FROM
    Reviews R
        JOIN
    Users U ON R.user_id = U.user_id
WHERE
    R.movie_id = 1;
    
-- let's work on some more advanced queries --
-- calculate the average rating for each movie --
SELECT 
    M.title, AVG(R.rating) AS average_rating
FROM
    Movies M
        JOIN
    Ratings R ON M.movie_id = R.movie_id
GROUP BY M.title
ORDER BY average_rating DESC;

-- Find the top 3 highest-rated movies --
SELECT 
    M.title, AVG(R.rating) AS average_rating
FROM
    Movies M
        JOIN
    Ratings R ON M.movie_id = R.movie_id
GROUP BY M.title
ORDER BY average_rating DESC
LIMIT 3;

-- get all the movies directed by Christopher Nolan --
SELECT 
    M.title, M.release_year
FROM
    Movies M
        JOIN
    Directors D ON M.director_id = D.director_id
WHERE
    D.first_name = 'Christopher'
        AND D.last_name = 'Nolan';
        
-- find the actors who have worked in movied directed by Quentin Tarantino --
SELECT DISTINCT
    A.first_name, A.last_name
FROM
    Actors A
        JOIN
    MovieActors MA ON A.actor_id = MA.actor_id
        JOIN
	Movies M ON MA.movie_id = M.movie_id
		JOIN
    Directors D ON M.director_id = D.director_id
WHERE
    D.first_name = 'Quentin'
        AND D.last_name = 'Tarantino';
        
-- get users who rated all movies directed by Steven Spielberg --
-- first, find movie ids directed by Steven Spielberg -- 
with SpielbergMovies as (
	select movie_id
	from Movies M
	join Directors D on M.director_id = D.director_id
	where D.first_name = 'Steven' and D.last_name = 'Spielberg'
),
-- then, find users who have rated these movies --
UserRatings as (
	select user_id, movie_id
	from Ratings
	where movie_id in (select movie_id from SpielbergMovies)
)
-- finally, find users who have rated all Spielberg movies --
select U.user_id, U.username
from Users U
where not exists (
	select movie_id
	from SpielbergMovies
	where movie_id not in (
		select movie_id
		from UserRatings UR
		where UR.user_id = U.user_id
	)
);

-- list actors who have acted in more than 2 movies --
SELECT 
    A.actor_id,
    A.first_name,
    A.last_name,
    COUNT(MA.movie_id) AS movie_count
FROM
    Actors A
        JOIN
    MovieActors MA ON A.actor_id = MA.actor_id
GROUP BY A.actor_id , A.first_name , A.last_name
HAVING COUNT(MA.movie_id) > 2;

-- find the most popular genre based on average movie ratings --
SELECT 
    G.genre_name, AVG(R.rating) AS average_genre_rating
FROM
    Ratings R
        JOIN
    Movies M ON R.movie_id = M.movie_id
		JOIN
	Genres G ON M.genre_id = G.genre_id
GROUP BY G.genre_name
ORDER BY average_genre_rating DESC
LIMIT 1;

-- calculate the total number of ratings per month -- 
SELECT 
    DATE_FORMAT(rating_date, '%Y-%m') AS rating_month,
    COUNT(*) AS total_ratings
FROM
    Ratings
GROUP BY rating_month
ORDER BY rating_month;

-- retrieve movies with their average rating and number of ratings --
SELECT 
    M.title,
    AVG(R.rating) AS average_rating,
    COUNT(R.rating_id) AS number_of_ratings
FROM
    Movies M
        LEFT JOIN
    Ratings R ON M.movie_id = R.movie_id
GROUP BY M.movie_id , M.title
ORDER BY average_rating DESC , number_of_ratings DESC;

-- find directors who have directed movies in multiple genres --
SELECT 
    D.director_id,
    D.first_name,
    D.last_name,
    COUNT(DISTINCT M.genre_id) AS genre_count
FROM
    Directors D
        JOIN
    Movies M ON D.director_id = M.director_id
GROUP BY D.director_id , D.first_name , D.last_name
HAVING COUNT(DISTINCT M.genre_id) > 1;

-- we can also work on some additional extensions -- 
-- indexes for performance --
create index idx_movies_title on Movies(title);
create index idx_ratings_user_id on Ratings(user_id);
create index idx_movieactors_actor_id on MovieActors(actor_id);

-- stored procedures and functions --
-- function to get average rating of a movie --
DELIMITER $$

CREATE FUNCTION GetMovieAverageRating(movieId INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE avgRating DECIMAL(3,2);
    SELECT AVG(rating) INTO avgRating FROM Ratings WHERE movie_id = movieId;
    RETURN avgRating;
END$$

DELIMITER ; 
-- use the function --
SELECT GETMOVIEAVERAGERATING(1) AS AverageRating;

-- trigger to update average rating in movies table --
-- first, add an average_rating column to the movies table --
ALTER TABLE Movies ADD average_rating DECIMAL(3, 2) DEFAULT NULL;
-- then, create a trigger --
DELIMITER $$

CREATE TRIGGER UpdateMovieAverageRating
AFTER INSERT ON Ratings
FOR EACH ROW
BEGIN
    UPDATE Movies
    SET average_rating = (SELECT AVG(rating) FROM Ratings WHERE movie_id = NEW.movie_id)
    WHERE movie_id = NEW.movie_id;
END$$

DELIMITER ;

-- view for movie details with average rating -- 
CREATE VIEW MovieDetails AS
    SELECT 
        M.movie_id,
        M.title,
        M.release_year,
        G.genre_name,
        D.first_name AS director_first_name,
        D.last_name AS director_last_name,
        M.average_rating
    FROM
        Movies M
            JOIN
        Genres G ON M.genre_id = G.genre_id
            JOIN
        Directors D ON M.director_id = D.director_id;

-- Use the view
SELECT 
    *
FROM
    MovieDetails
WHERE
    average_rating > 8;