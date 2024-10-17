
CREATE DATABASE DatabaseProject;

USE DatabaseProject;

CREATE TABLE [User] (
    user_id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'),
    [password] VARCHAR(255) NOT NULL,
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Genre(
    genre_id INT PRIMARY KEY,
    [name] VARCHAR(100) NOT NULL UNIQUE,
    [description] TEXT
);

CREATE TABLE Director (
    director_id INT PRIMARY KEY,
    [name] VARCHAR(255) NOT NULL,
    birthdate DATE
);

CREATE TABLE Show (
    show_id INT PRIMARY KEY,
    genre_id INT NOT NULL,
    director_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    [description] TEXT,
    maturity_rating VARCHAR(10),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON DELETE CASCADE,
    FOREIGN KEY (director_id) REFERENCES Director(director_id) ON DELETE CASCADE
);

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY,
    genre_id INT NOT NULL,
    director_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    [description] TEXT,
    duration INT CHECK (duration > 0),
    maturity_rating VARCHAR(10),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON DELETE CASCADE,
    FOREIGN KEY (director_id) REFERENCES Director(director_id) ON DELETE CASCADE
);

CREATE TABLE Actor (
    actor_id INT PRIMARY KEY,
    [name] VARCHAR(255) NOT NULL,
    birthdate DATE
);

CREATE TABLE Rating (
    rating_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT,
    show_id INT,
    rating_value INT CHECK (rating_value BETWEEN 1 AND 5),
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES [User](user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE NO ACTION,
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE NO ACTION
);


CREATE TABLE Watchlist (
    watchlist_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id) ON DELETE NO ACTION
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_id INT,
    show_id INT,
    review_text TEXT NOT NULL,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES [User](user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE NO ACTION
);

CREATE TABLE Award (
    award_id INT PRIMARY KEY,
    [name] VARCHAR(255) NOT NULL UNIQUE,
    category VARCHAR(100),
    [description] TEXT
);

CREATE TABLE Season (
    season_id INT PRIMARY KEY,
    show_id INT NOT NULL,
    label VARCHAR(100) NOT NULL,
    release_date DATE,
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE CASCADE
);

CREATE TABLE Episode (
    episode_id INT PRIMARY KEY,
    show_id INT NOT NULL,
    season_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    episode_number INT NOT NULL,
    air_date DATE,
    [description] TEXT,
    duration INT CHECK (duration > 0),
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE CASCADE,
    FOREIGN KEY (season_id) REFERENCES Season(season_id) ON DELETE NO ACTION
);

CREATE TABLE Movie_Actor (
    movie_id INT NOT NULL,
    actor_id INT NOT NULL,
    [role] VARCHAR(100) NOT NULL,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES Actor(actor_id) ON DELETE CASCADE
);

CREATE TABLE Movie_Award (
    movie_id INT NOT NULL,
    award_id INT NOT NULL,
    [year] INT NOT NULL,
    PRIMARY KEY (movie_id, award_id, [year]),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (award_id) REFERENCES Award(award_id) ON DELETE CASCADE
);

CREATE TABLE Show_Award (
    show_id INT NOT NULL,
    award_id INT NOT NULL,
    [year] INT NOT NULL,
    PRIMARY KEY (show_id, award_id, [year]),
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE CASCADE,
    FOREIGN KEY (award_id) REFERENCES Award(award_id) ON DELETE CASCADE
);

CREATE TABLE Show_Actor (
    show_id INT NOT NULL,
    actor_id INT NOT NULL,
    [role] VARCHAR(100) NOT NULL,
    PRIMARY KEY (show_id, actor_id),
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES Actor(actor_id) ON DELETE CASCADE
);

CREATE TABLE Watchlist_Movies (
    watchlist_id INT NOT NULL,
    movie_id INT NOT NULL,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (watchlist_id, movie_id),
    FOREIGN KEY (watchlist_id) REFERENCES Watchlist(watchlist_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE
);

CREATE TABLE Watchlist_Shows (
    watchlist_id INT NOT NULL,
    show_id INT NOT NULL,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (watchlist_id, show_id),
    FOREIGN KEY (watchlist_id) REFERENCES Watchlist(watchlist_id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES Show(show_id) ON DELETE CASCADE
);

INSERT INTO [User] (user_id, email, [password]) VALUES
(1, 'alice.smith@example.com', 'Alice2023!'),
(2, 'bob.johnson@example.com', 'Bob@12345'),
(3, 'carol.brown@example.com', 'Carol!Brown1'),
(4, 'dave.wilson@example.com', 'Dave&Wilson2'),
(5, 'eve.davis@example.com', 'Eve#Davis3'),
(6, 'frank.miller@example.com', 'FrankMiller4!'),
(7, 'grace.moore@example.com', 'Grace@Moore5'),
(8, 'henry.taylor@example.com', 'Henry6!Taylor'),
(9, 'ivy.jackson@example.com', 'Ivy^Jackson7'),
(10, 'jack.white@example.com', 'Jack8White!'),
(11, 'karen.harris@example.com', 'KarenH@9'),
(12, 'luke.martin@example.com', 'Luke10*Martin'),
(13, 'mia.thomas@example.com', 'Mia#Thomas11'),
(14, 'nate.clark@example.com', 'Nate12&Clark'),
(15, 'olivia.robinson@example.com', 'Olivia13!Robinson'),
(16, 'paul.wright@example.com', 'Paul14^Wright'),
(17, 'quinn.lewis@example.com', 'Quinn15!Lewis'),
(18, 'rose.walker@example.com', 'Rose16@Walker'),
(19, 'sam.hall@example.com', 'Sam17*Hall'),
(20, 'tina.allen@example.com', 'Tina@18Allen'),
(21, 'ursula.king@example.com', 'Ursula19!King'),
(22, 'victor.young@example.com', 'Victor20^Young'),
(23, 'wendy.scott@example.com', 'Wendy21&Scott'),
(24, 'xander.adams@example.com', 'Xander22!Adams'),
(25, 'yara.baker@example.com', 'Yara23*Baker'),
(26, 'zach.mitchell@example.com', 'Zach24@Mitchell'),
(27, 'alice.kim@example.com', 'Alice25#Kim'),
(28, 'benjamin.perez@example.com', 'Ben26^Perez'),
(29, 'clara.carter@example.com', 'Clara27!Carter'),
(30, 'daniel.phillips@example.com', 'Daniel28&Phillips');


INSERT INTO Genre (genre_id, [name], [description]) VALUES
(1, 'Action', 'High-energy films with intense action sequences'),
(2, 'Drama', 'Films that focus on character development and an emotional narrative'),
(3, 'Comedy', 'Light-hearted films intended to provoke laughter'),
(4, 'Horror', 'Films designed to scare and shock audiences'),
(5, 'Sci-Fi', 'Films that explore futuristic concepts and advanced technology'),
(6, 'Romance', 'Films centered on love stories and romantic relationships'),
(7, 'Thriller', 'Suspenseful films that keep the audience on edge'),
(8, 'Documentary', 'Factual films that document real events and people'),
(9, 'Fantasy', 'Films that feature magical and supernatural elements'),
(10, 'Animation', 'Films created using animated images and characters'),
(11, 'Mystery', 'Films involving suspenseful plots and puzzles to solve'),
(12, 'Biography', 'Films depicting the life of real people'),
(13, 'Adventure', 'Films that include exciting journeys and exploration'),
(14, 'Family', 'Films suitable for family viewing'),
(15, 'Musical', 'Films that feature music and dance as a central element'),
(16, 'Western', 'Films set in the American West during the late 19th to early 20th centuries'),
(17, 'Crime', 'Films that focus on criminal acts and their consequences'),
(18, 'History', 'Films that dramatize historical events'),
(19, 'Sports', 'Films centered around athletic competitions and sports'),
(20, 'War', 'Films that depict warfare and military conflicts'),
(21, 'Noir', 'Stylized crime dramas with moral ambiguity'),
(22, 'Superhero', 'Films featuring superheroes and their adventures'),
(23, 'Post-Apocalyptic', 'Films set in a world after a catastrophic event'),
(24, 'Teen', 'Films aimed at a teenage audience'),
(25, 'Satire', 'Films that use humor to critique society and politics'),
(26, 'Epics', 'Large-scale films often set in historical times'),
(27, 'Romantic Comedy', 'A combination of romance and comedy'),
(28, 'Zombies', 'Films involving the undead and apocalyptic scenarios'),
(29, 'Gothic', 'Films that evoke a dark, mysterious atmosphere'),
(30, 'Psychological', 'Films that explore the mind and emotional experiences');

INSERT INTO Director (director_id, [name], birthdate) VALUES
(1, 'Steven Spielberg', '1946-12-18'),
(2, 'Christopher Nolan', '1970-07-30'),
(3, 'Greta Gerwig', '1983-08-04'),
(4, 'Martin Scorsese', '1942-11-17'),
(5, 'Ava DuVernay', '1972-08-24'),
(6, 'Quentin Tarantino', '1963-03-27'),
(7, 'Jordan Peele', '1979-02-21'),
(8, 'Patty Jenkins', '1971-07-24'),
(9, 'James Cameron', '1954-08-16'),
(10, 'Catherine Hardwicke', '1955-10-21'),
(11, 'David Fincher', '1962-08-28'),
(12, 'Bong Joon-ho', '1969-09-14'),
(13, 'Taika Waititi', '1976-08-16'),
(14, 'Sofia Coppola', '1971-05-14'),
(15, 'Denis Villeneuve', '1967-10-03'),
(16, 'Greta Gerwig', '1983-08-04'),
(17, 'Nia DaCosta', '1989-11-22'),
(18, 'Francis Ford Coppola', '1939-04-07'),
(19, 'Richard Linklater', '1960-07-30'),
(20, 'Rian Johnson', '1973-12-17'),
(21, 'J.J. Abrams', '1966-06-27'),
(22, 'Chloé Zhao', '1982-03-31'),
(23, 'Barry Jenkins', '1979-11-19'),
(24, 'Alfonso Cuarón', '1961-11-28'),
(25, 'Emma Thomas', '1969-02-06'),
(26, 'Wes Anderson', '1969-05-01'),
(27, 'Peter Jackson', '1961-10-31'),
(28, 'David O. Russell', '1958-04-15'),
(29, 'Luca Guadagnino', '1971-08-10'),
(30, 'Andy Muschietti', '1973-08-26');


INSERT INTO Show (show_id, genre_id, director_id, title, release_date, [description], maturity_rating) VALUES
(1, 1, 1, 'The Fast and the Fearless', '2022-01-01', 'An action-packed adventure.', 'PG-13'),
(2, 2, 2, 'Tears of Joy', '2022-02-01', 'A touching drama.', 'R'),
(3, 3, 3, 'Laugh Out Loud', '2022-03-01', 'A hilarious comedy.', 'PG'),
(4, 4, 4, 'Nightmare Unleashed', '2022-04-01', 'A spine-chilling horror.', 'R'),
(5, 5, 5, 'Galactic Odyssey', '2022-05-01', 'A thrilling sci-fi journey.', 'PG-13'),
(6, 6, 6, 'Love in Bloom', '2022-06-01', 'A heartwarming romance.', 'PG'),
(7, 7, 7, 'Edge of Suspense', '2022-07-01', 'A suspenseful thriller.', 'R'),
(8, 8, 8, 'Real Stories', '2022-08-01', 'An insightful documentary.', 'G'),
(9, 9, 9, 'Magic Awaits', '2022-09-01', 'A magical fantasy tale.', 'PG'),
(10, 10, 10, 'Adventure Awaits', '2022-10-01', 'An animated adventure.', 'G'),
(11, 1, 11, 'The Return of the Brave', '2023-01-01', 'Another action-packed adventure.', 'PG-13'),
(12, 2, 12, 'Heartstrings', '2023-02-01', 'A gripping drama series.', 'R'),
(13, 3, 13, 'Comedy Gold', '2023-03-01', 'A comedy that will make you laugh out loud.', 'PG'),
(14, 4, 14, 'Shadows of Fear', '2023-04-01', 'A terrifying new horror series.', 'R'),
(15, 5, 15, 'Future Shock', '2023-05-01', 'Exploring the future of humanity.', 'PG-13'),
(16, 6, 16, 'A Love Story', '2023-06-01', 'A romantic saga.', 'PG'),
(17, 7, 17, 'Twists and Turns', '2023-07-01', 'A thriller that keeps you guessing.', 'R'),
(18, 8, 18, 'Voices of the World', '2023-08-01', 'Documenting real stories from around the world.', 'G'),
(19, 9, 19, 'Enchanted Realms', '2023-09-01', 'Another magical tale awaits.', 'PG'),
(20, 10, 20, 'Animated Adventures', '2023-10-01', 'More animated adventures for everyone.', 'G'),
(21, 1, 21, 'Heroes Rise', '2024-01-01', 'An epic action series.', 'PG-13'),
(22, 2, 22, 'Deep Waters', '2024-02-01', 'A drama that explores deep emotions.', 'R'),
(23, 3, 23, 'Life’s a Joke', '2024-03-01', 'A comedic take on life.', 'PG'),
(24, 4, 24, 'Fear Incarnate', '2024-04-01', 'The scariest series yet.', 'R'),
(25, 5, 25, 'Beyond the Stars', '2024-05-01', 'Adventures in outer space.', 'PG-13'),
(26, 6, 26, 'Timeless Romance', '2024-06-01', 'A love story for the ages.', 'PG'),
(27, 7, 27, 'Mind Games', '2024-07-01', 'A mind-bending thriller series.', 'R'),
(28, 8, 28, 'Nature’s Wonders', '2024-08-01', 'Exploring the wonders of nature.', 'G'),
(29, 9, 29, 'Fantasy Realms', '2024-09-01', 'A new world to discover.', 'PG'),
(30, 10, 30, 'Fun Times Ahead', '2024-10-01', 'More fun and adventures await!', 'G');

INSERT INTO Movie (movie_id, genre_id, director_id, title, release_date, [description], duration, maturity_rating) VALUES
(1, 1, 1, 'The Fast and the Furious', '2021-01-01', 'An action-filled blockbuster.', 120, 'PG-13'),
(2, 2, 2, 'The Heartbreak Story', '2021-02-01', 'An emotional drama film.', 130, 'R'),
(3, 3, 3, 'Laugh Riot', '2021-03-01', 'A laugh-out-loud comedy.', 90, 'PG'),
(4, 4, 4, 'The Haunting', '2021-04-01', 'A terrifying horror flick.', 100, 'R'),
(5, 5, 5, 'Intergalactic Adventures', '2021-05-01', 'A mind-bending sci-fi adventure.', 140, 'PG-13'),
(6, 6, 6, 'Love at First Sight', '2021-06-01', 'A love story that warms the heart.', 110, 'PG'),
(7, 7, 7, 'The Last Thrill', '2021-07-01', 'A gripping thriller film.', 115, 'R'),
(8, 8, 8, 'Beyond the Lens', '2021-08-01', 'A fascinating documentary.', 85, 'G'),
(9, 9, 9, 'The Enchanted Journey', '2021-09-01', 'A fantastical journey.', 130, 'PG'),
(10, 10, 10, 'Animated Dreams', '2021-10-01', 'An animated masterpiece.', 95, 'G'),
(11, 1, 11, 'Adrenaline Rush', '2022-01-01', 'Another action blockbuster.', 125, 'PG-13'),
(12, 2, 12, 'Tears of a Warrior', '2022-02-01', 'An impactful drama.', 135, 'R'),
(13, 3, 13, 'Giggles and Gags', '2022-03-01', 'A comedy that will make you smile.', 88, 'PG'),
(14, 4, 14, 'Fearful Nights', '2022-04-01', 'A chilling horror experience.', 102, 'R'),
(15, 5, 15, 'Space Odyssey', '2022-05-01', 'A thrilling journey through space.', 142, 'PG-13'),
(16, 6, 16, 'Forever Yours', '2022-06-01', 'A heartwarming romantic tale.', 113, 'PG'),
(17, 7, 17, 'The Edge of Fear', '2022-07-01', 'A suspenseful journey.', 118, 'R'),
(18, 8, 18, 'History Uncovered', '2022-08-01', 'A deep dive into history.', 87, 'G'),
(19, 9, 19, 'Mystical Realms', '2022-09-01', 'A new magical world.', 128, 'PG'),
(20, 10, 20, 'Animated Adventures for All', '2022-10-01', 'An animated adventure for all ages.', 90, 'G'),
(21, 1, 21, 'Ultimate Action Showdown', '2023-01-01', 'The ultimate action thrill ride.', 130, 'PG-13'),
(22, 2, 22, 'The Depths of Emotion', '2023-02-01', 'A powerful and emotional story.', 140, 'R'),
(23, 3, 23, 'Comedy Extravaganza', '2023-03-01', 'A comedy filled with laughter.', 94, 'PG'),
(24, 4, 24, 'The Dark Night', '2023-04-01', 'A horrifying tale that terrifies.', 105, 'R'),
(25, 5, 25, 'Cosmic Frontiers', '2023-05-01', 'Exploring the final frontier.', 150, 'PG-13'),
(26, 6, 26, 'Eternal Love', '2023-06-01', 'A romantic epic.', 115, 'PG'),
(27, 7, 27, 'Thriller of the Year', '2023-07-01', 'A thriller that keeps you on the edge.', 120, 'R'),
(28, 8, 28, 'Illuminating Insights', '2023-08-01', 'An enlightening documentary.', 90, 'G'),
(29, 9, 29, 'Adventure in the Magical Realm', '2023-09-01', 'A magical adventure awaits.', 140, 'PG'),
(30, 10, 30, 'The Joyful Animation', '2023-10-01', 'A joyful animated tale.', 88, 'G');


INSERT INTO Actor (actor_id, [name], birthdate) VALUES
(1, 'Florence Pugh', '1990-01-01'),
(2, 'Harry Styles', '1985-02-02'),
(3, 'Tony Eliot', '1980-03-03'),
(4, 'John Doe', '1975-04-04'),
(5, 'Randolph Macon', '1995-05-05'),
(6, 'Thomas Jefferson', '1970-06-06'),
(7, 'Dave Jones', '1988-07-07'),
(8, 'Leo Messi', '1972-08-08'),
(9, 'Jack Harlow', '1960-09-09'),
(10, 'Chris Pratt', '1978-10-10'),
(11, 'Zendaya Coleman', '1968-11-11'),
(12, 'Emma Watson', '1992-12-12'),
(13, 'Michael B. Jordan', '1983-01-13'),
(14, 'Natalie Portman', '1974-02-14'),
(15, 'Florence Welch', '1991-03-15'),
(16, 'Ryan Gosling', '1986-04-16'),
(17, 'Margot Robbie', '1979-05-17'),
(18, 'John Boyega', '1987-06-18'),
(19, 'Viola Davis', '1971-07-19'),
(20, 'Tom Hiddleston', '1969-08-20'),
(21, 'Ansel Elgort', '1982-09-21'),
(22, 'Timothée Chalamet', '1993-10-22'),
(23, 'Emily Blunt', '1977-11-23'),
(24, 'Leonardo DiCaprio', '1964-12-24'),
(25, 'Shailene Woodley', '1994-01-25'),
(26, 'Joseph Gordon-Levitt', '1981-02-26'),
(27, 'Chris Evans', '1973-03-27'),
(28, 'Tessa Thompson', '1966-04-28'),
(29, 'Florence Pugh', '1995-05-29'),
(30, 'Jesse Plemons', '1989-06-30');


INSERT INTO Rating (rating_id, user_id, movie_id, show_id, rating_value) VALUES
(1, 1, 1, NULL, 5),
(2, 2, 2, NULL, 4),
(3, 3, 3, NULL, 3),
(4, 4, 4, NULL, 2),
(5, 5, 5, NULL, 1),
(6, 6, 6, NULL, 5),
(7, 7, 7, NULL, 4),
(8, 8, 8, NULL, 3),
(9, 9, 9, NULL, 2),
(10, 10, 10, NULL, 1),
(11, 11, 1, NULL, 5),
(12, 12, 2, NULL, 4),
(13, 13, 3, NULL, 3),
(14, 14, 4, NULL, 2),
(15, 15, 5, NULL, 1),
(16, 16, 6, NULL, 5),
(17, 17, 7, NULL, 4),
(18, 18, 8, NULL, 3),
(19, 19, 9, NULL, 2),
(20, 20, 10, NULL, 1),
(21, 21, NULL, 2, 5),
(22, 22, NULL, 3, 4),
(23, 23, NULL, 4, 3),
(24, 24, NULL, 5, 2),
(25, 25, NULL, 1, 1),
(26, 26, NULL, 6, 5),
(27, 27, NULL, 8, 4),
(28, 28, NULL, 7, 3),
(29, 29, NULL, 9,  2),
(30, 30, NULL, 11, 1);

INSERT INTO Watchlist (watchlist_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(31, 1),
(32, 2);


INSERT INTO Review (review_id, user_id, movie_id, show_id, review_text) VALUES
(1, 1, 1, NULL, 'Amazing movie!'),
(2, 2, 2, NULL, 'Very touching story.'),
(3, 3, 3, NULL, 'Loved it! So funny.'),
(4, 4, 4, NULL, 'Not scary enough.'),
(5, 5, 5, NULL, 'Mind-blowing sci-fi.'),
(6, 6, 6, NULL, 'A beautiful love story.'),
(7, 7, 7, NULL, 'Thrilling from start to finish.'),
(8, 8, 8, NULL, 'Informative and well-made.'),
(9, 9, 9, NULL, 'Fantastic world-building.'),
(10, 10, NULL, 10, 'So enjoyable for kids!'),
(11, 11, NULL, 11,'Another fantastic entry!'),
(12, 12, NULL, 12, 'Very emotional and powerful.'),
(13, 13, NULL, 13,'Hilarious and charming.'),
(14, 14, NULL, 14,'Could be scarier.'),
(15, 15, NULL, 15,'A great adventure.'),
(16, 16, NULL, 16,'Heartwarming and lovely.'),
(17, 17, NULL, 17,'Kept me on the edge of my seat.'),
(18, 18, NULL, 18,'A great educational piece.'),
(19, 19, NULL, 19,'A captivating story.'),
(20, 20, NULL, 20,'A classic for children.'),
(21, 21, NULL, 21,'Action-packed and thrilling!'),
(22, 22, 2, NULL, 'Very moving and relatable.'),
(23, 23, 3, NULL, 'A comedy gem!'),
(24, 24, 4, NULL, 'Not what I expected.'),
(25, 25, 5, NULL, 'A must-see for sci-fi fans.'),
(26, 26, 6, NULL, 'Romantic and touching.'),
(27, 27, 7, NULL, 'An intense experience.'),
(28, 28, 8, NULL, 'So insightful.'),
(29, 29, 9, NULL, 'Magical and enchanting.'),
(30, 30, 10, NULL, 'Delightful and fun!');

INSERT INTO Award (award_id, [name], category, [description]) VALUES
(1, 'Oscar for Best Picture', 'Best Picture', 'Awarded to the best picture of the year.'),
(2, 'Oscar for Best Director', 'Best Director', 'Awarded to the best director of the year.'),
(3, 'Oscar for Best Actor', 'Best Actor', 'Awarded to the best performance by an actor.'),
(4, 'Oscar for Best Actress', 'Best Actress', 'Awarded to the best performance by an actress.'),
(5, 'Oscar for Best Supporting Actor', 'Best Supporting Actor', 'Awarded to the best supporting actor.'),
(6, 'Oscar for Best Supporting Actress', 'Best Supporting Actress', 'Awarded to the best supporting actress.'),
(7, 'Emmy for Best Original Screenplay', 'Best Screenplay', 'Awarded for the best original screenplay.'),
(8, 'Golden Globe for Best Adapted Screenplay', 'Best Screenplay', 'Awarded for the best adapted screenplay.'),
(9, 'Annie Award for Best Animation', 'Best Animation', 'Awarded for the best animated feature.'),
(10, 'BAFTA for Best Foreign Language', 'Best Foreign Language', 'Awarded for the best foreign language production.'),
(11, 'Oscar for Best Documentary Feature', 'Best Documentary', 'Awarded for the best documentary.'),
(12, 'Grammy for Best Original Score', 'Best Score', 'Awarded for the best score.'),
(13, 'Oscar for Best Original Song', 'Best Song', 'Awarded for the best original song.'),
(14, 'Oscar for Best Cinematography', 'Best Cinematography', 'Awarded for the best cinematography.'),
(15, 'ACE Eddie Award for Best Film Editing', 'Best Editing', 'Awarded for the best editing.'),
(16, 'Oscar for Best Visual Effects', 'Best Visual Effects', 'Awarded for the best visual effects.'),
(17, 'Oscar for Best Production Design', 'Best Production Design', 'Awarded for the best production design.'),
(18, 'Oscar for Best Costume Design', 'Best Costume Design', 'Awarded for the best costume design.'),
(19, 'Oscar for Best Makeup and Hairstyling', 'Best Makeup', 'Awarded for the best makeup and hairstyling.'),
(20, 'Oscar for Best Sound Mixing', 'Best Sound Mixing', 'Awarded for the best sound mixing.'),
(21, 'Oscar for Best Sound Editing', 'Best Sound Editing', 'Awarded for the best sound editing.'),
(22, 'Oscar for Best Animated Short', 'Best Animated Short', 'Awarded for the best animated short.'),
(23, 'Oscar for Best Live Action Short', 'Best Live Action Short', 'Awarded for the best live action short.'),
(24, 'Oscar for Best Documentary Short', 'Best Documentary Short', 'Awarded for the best documentary short.'),
(25, 'VMA for Best Visual Effects', 'Best Visual Effects', 'Awarded for exceptional visual effects.'),
(26, 'Oscar for Best Stunt Coordination', 'Best Stunt Coordination', 'Awarded for outstanding stunt coordination.'),
(27, 'Emmy for Best Casting', 'Best Casting', 'Awarded for exceptional casting.'),
(28, 'SAG Award for Best Ensemble', 'Best Ensemble', 'Awarded for the best ensemble cast.'),
(29, 'Oscar for Best Action', 'Best Action', 'Awarded for the best action production.'),
(30, 'Oscar for Best Comedy', 'Best Comedy', 'Awarded for the best comedy production.');


INSERT INTO Season (season_id, show_id, label, release_date) VALUES
(1, 1, 'Season 1: Twilight Zone', '2022-01-01'),
(2, 1, 'Season 2: Beyond the Dimension', '2023-01-01'),
(3, 2, 'Season 1: New Beginnings', '2022-02-01'),
(4, 3, 'Season 1: Uncharted Realms', '2022-03-01'),
(5, 4, 'Season 1: The Awakening', '2022-04-01'),
(6, 5, 'Season 1: Hidden Treasures', '2022-05-01'),
(7, 6, 'Season 1: Echoes of Time', '2022-06-01'),
(8, 7, 'Season 1: The Journey Begins', '2022-07-01'),
(9, 8, 'Season 1: The New Frontier', '2022-08-01'),
(10, 9, 'Season 1: Secrets Unveiled', '2022-09-01'),
(11, 10, 'Season 1: The Final Chapter', '2022-10-01'),
(12, 1, 'Season 3: Through the Looking Glass', '2024-01-01'),
(13, 2, 'Season 2: A World Apart', '2024-02-01'),
(14, 3, 'Season 2: The Next Step', '2024-03-01'),
(15, 4, 'Season 2: Rising Tides', '2024-04-01'),
(16, 5, 'Season 2: Unraveled Mysteries', '2024-05-01'),
(17, 6, 'Season 2: Whispers in the Dark', '2024-06-01'),
(18, 7, 'Season 2: Trials and Triumphs', '2024-07-01'),
(19, 8, 'Season 2: New Horizons', '2024-08-01'),
(20, 9, 'Season 2: Shadows of the Past', '2024-09-01'),
(21, 10, 'Season 2: The Reckoning', '2024-10-01');


INSERT INTO Episode (episode_id, show_id, season_id, title, episode_number, air_date, [description], duration) VALUES
(1, 1, 1, 'Pilot: Introduction to the Characters and Plot', 1, '2022-10-01', 'The main characters are introduced as they navigate the complexities of their intertwined lives.', 45),
(2, 1, 1, 'Episode 2: The Story Deepens with New Challenges', 2, '2022-10-08', 'As tensions rise, the characters face unexpected challenges that test their resolve.', 50),
(3, 1, 1, 'Episode 3: Unexpected Twists and Turns', 3, '2022-10-15', 'A shocking betrayal alters the course of the story, leading to unforeseen consequences.', 48),
(4, 2, 1, 'Pilot: The Start of an Exciting Journey', 1, '2022-11-01', 'A group of adventurers embarks on a quest that will change their lives forever.', 42),
(5, 2, 1, 'Episode 2: The Plot Thickens', 2, '2022-11-08', 'Alliances are formed and broken as the journey becomes increasingly perilous.', 49),
(6, 2, 1, 'Episode 3: New Characters Introduced', 3, '2022-11-15', 'The arrival of a mysterious stranger adds intrigue and tension to the group dynamic.', 51),
(7, 3, 1, 'Pilot: A Hilarious Beginning', 1, '2022-12-01', 'A quirky group of friends navigates the ups and downs of life, leading to laugh-out-loud moments.', 44),
(8, 3, 1, 'Episode 2: Laughs and Chaos Ensue', 2, '2022-12-08', 'Misunderstandings and mishaps create a whirlwind of comedy for the group.', 46),
(9, 3, 1, 'Episode 3: A Holiday Special', 3, '2022-12-15', 'The friends come together for a holiday celebration that quickly spirals out of control.', 52),
(10, 4, 1, 'Pilot: A Chilling Introduction', 1, '2023-01-01', 'In a small town, strange occurrences begin to unfold, setting the stage for a suspenseful series.', 47),
(11, 4, 1, 'Episode 2: Mysteries Unfold', 2, '2023-01-08', 'The townspeople begin to investigate the eerie happenings that threaten their community.', 53),
(12, 4, 1, 'Episode 3: Dark Secrets Revealed', 3, '2023-01-15', 'As secrets come to light, the town’s past reveals its hidden horrors.', 45),
(13, 5, 1, 'Pilot: A Journey Through Space', 1, '2023-02-01', 'A crew sets off on a mission to explore uncharted territories in the galaxy.', 54),
(14, 5, 1, 'Episode 2: Encounter with Aliens', 2, '2023-02-08', 'The crew encounters a mysterious alien race that challenges their understanding of life in the universe.', 55),
(15, 5, 1, 'Episode 3: Battles in the Cosmos', 3, '2023-02-15', 'Intergalactic conflicts arise as the crew must fight to protect their ship and newfound allies.', 50),
(16, 6, 1, 'Pilot: A Romantic Beginning', 1, '2023-03-01', 'Two strangers meet under unexpected circumstances, sparking a surprising romance.', 40),
(17, 6, 1, 'Episode 2: A Misunderstanding', 2, '2023-03-08', 'A miscommunication leads to a comedic fallout that tests the budding relationship.', 38),
(18, 6, 1, 'Episode 3: Love Triumphs', 3, '2023-03-15', 'Through trials and tribulations, the couple learns the importance of trust and communication.', 43),
(19, 7, 1, 'Pilot: A Thrilling Start', 1, '2023-04-01', 'An elite team is called to action to stop a catastrophic event from occurring.', 46),
(20, 7, 1, 'Episode 2: A Chase Begins', 2, '2023-04-08', 'The team embarks on a high-stakes pursuit that tests their skills and loyalty.', 52),
(21, 8, 1, 'Pilot: A Documentary on Nature', 1, '2023-05-01', 'Explore the beauty and complexity of the natural world in this captivating documentary.', 60),
(22, 8, 1, 'Episode 2: Exploring the Ocean Depths', 2, '2023-05-08', 'Dive deep into the mysteries of the ocean, uncovering its secrets and wonders.', 55),
(23, 9, 1, 'Pilot: A Fantasy World Unveiled', 1, '2023-06-01', 'A young hero discovers a hidden realm filled with magic and adventure.', 58),
(24, 9, 1, 'Episode 2: The Journey Continues', 2, '2023-06-08', 'The hero faces new challenges and meets unexpected allies on their quest.', 57),
(25, 10, 1, 'Pilot: An Animated Adventure', 1, '2023-07-01', 'Join a group of animated characters as they embark on a whimsical journey.', 42),
(26, 10, 1, 'Episode 2: Friendship and Fun', 2, '2023-07-01', 'The characters learn valuable lessons about friendship while navigating playful challenges.', 39),
(27, 11, 1, 'Pilot: A Thrilling Mystery', 1, '2023-08-01', 'A detective investigates a perplexing case that baffles everyone involved.', 48),
(28, 11, 1, 'Episode 2: Clues and Red Herrings', 2, '2023-07-01', 'As the detective delves deeper, misleading clues complicate the investigation.', 45),
(29, 12, 1, 'Pilot: A Suspenseful Beginning', 1, '2023-07-01', 'In a world filled with tension, a gripping story begins to unfold.', 50),
(30, 12, 1, 'Episode 2: The Tension Escalates', 2, '2023-07-01', 'With stakes rising, characters must confront their fears to find the truth.', 49);


INSERT INTO Movie_Actor (movie_id, actor_id, [role]) VALUES
(1, 1, 'Lead'),
(1, 2, 'Supporting'),
(2, 1, 'Lead'),
(2, 3, 'Supporting'),
(3, 2, 'Lead'),
(3, 4, 'Supporting'),
(4, 3, 'Lead'),
(4, 5, 'Supporting'),
(5, 1, 'Lead'),
(5, 6, 'Supporting'),
(6, 2, 'Lead'),
(6, 7, 'Supporting'),
(7, 3, 'Lead'),
(7, 8, 'Supporting'),
(8, 4, 'Lead'),
(8, 9, 'Supporting'),
(9, 5, 'Lead'),
(9, 10, 'Supporting'),
(10, 6, 'Lead'),
(10, 11, 'Supporting'),
(11, 7, 'Lead'),
(11, 12, 'Supporting'),
(12, 8, 'Lead'),
(12, 13, 'Supporting'),
(13, 9, 'Lead'),
(13, 14, 'Supporting'),
(14, 10, 'Lead'),
(14, 15, 'Supporting'),
(15, 11, 'Lead'),
(15, 16, 'Supporting'),
(16, 12, 'Lead'),
(16, 17, 'Supporting');

INSERT INTO Movie_Award (movie_id, award_id, [year]) VALUES
(1, 1, 2022),
(1, 2, 2022),
(2, 3, 2022),
(2, 4, 2023),
(3, 5, 2023),
(3, 6, 2023),
(4, 7, 2023),
(4, 8, 2023),
(5, 9, 2024),
(5, 10, 2024),
(6, 11, 2024),
(6, 12, 2024),
(7, 13, 2024),
(7, 14, 2024),
(8, 15, 2024),
(8, 16, 2024),
(9, 17, 2024),
(9, 18, 2024),
(10, 19, 2025),
(10, 20, 2025),
(11, 21, 2025),
(11, 22, 2025),
(12, 23, 2025),
(12, 24, 2025),
(13, 25, 2025),
(13, 26, 2025),
(14, 27, 2025),
(14, 28, 2025),
(15, 29, 2025),
(15, 30, 2025);

INSERT INTO Show_Award (show_id, award_id, [year]) VALUES
(1, 1, 2022),
(1, 2, 2022),
(2, 3, 2022),
(2, 4, 2023),
(3, 5, 2023),
(3, 6, 2023),
(4, 7, 2023),
(4, 8, 2023),
(5, 9, 2024),
(5, 10, 2024),
(6, 11, 2024),
(6, 12, 2024),
(7, 13, 2024),
(7, 14, 2024),
(8, 15, 2024),
(8, 16, 2024),
(9, 17, 2024),
(9, 18, 2024),
(10, 19, 2025),
(10, 20, 2025),
(11, 21, 2025),
(11, 22, 2025),
(12, 23, 2025),
(12, 24, 2025),
(13, 25, 2025),
(13, 26, 2025),
(14, 27, 2025),
(14, 28, 2025),
(15, 29, 2025),
(15, 30, 2025);

INSERT INTO Show_Actor (show_id, actor_id, [role]) VALUES
(1, 1, 'Main Character'),
(1, 2, 'Supporting Character'),
(2, 1, 'Main Character'),
(2, 3, 'Supporting Character'),
(3, 2, 'Main Character'),
(3, 4, 'Supporting Character'),
(4, 3, 'Main Character'),
(4, 5, 'Supporting Character'),
(5, 1, 'Main Character'),
(5, 6, 'Supporting Character'),
(6, 2, 'Main Character'),
(6, 7, 'Supporting Character'),
(7, 3, 'Main Character'),
(7, 8, 'Supporting Character'),
(8, 4, 'Main Character'),
(8, 9, 'Supporting Character'),
(9, 5, 'Main Character'),
(9, 10, 'Supporting Character'),
(10, 6, 'Main Character'),
(10, 11, 'Supporting Character'),
(11, 7, 'Main Character'),
(11, 12, 'Supporting Character'),
(12, 8, 'Main Character'),
(12, 13, 'Supporting Character'),
(13, 9, 'Main Character'),
(13, 14, 'Supporting Character'),
(14, 10, 'Main Character'),
(14, 15, 'Supporting Character'),
(15, 11, 'Main Character'),
(15, 16, 'Supporting Character');

INSERT INTO Watchlist_Movies (watchlist_id, movie_id, date_added) VALUES
(1, 1, '2024-01-01'),
(1, 2, '2024-01-05'),
(1, 3, '2024-01-10'),
(2, 4, '2024-01-15'),
(2, 5, '2024-01-20'),
(2, 6, '2024-01-25'),
(3, 7, '2024-02-01'),
(3, 8, '2024-02-05'),
(3, 9, '2024-02-10'),
(4, 10, '2024-02-15'),
(4, 11, '2024-02-20'),
(4, 12, '2024-02-25'),
(5, 13, '2024-03-01'),
(5, 14, '2024-03-05'),
(5, 15, '2024-03-10'),
(6, 16, '2024-03-15'),
(6, 17, '2024-03-20'),
(6, 18, '2024-03-25'),
(7, 19, '2024-04-01'),
(7, 20, '2024-04-05'),
(7, 21, '2024-04-10'),
(8, 22, '2024-04-15'),
(8, 23, '2024-04-20'),
(8, 24, '2024-04-25'),
(9, 25, '2024-05-01'),
(9, 26, '2024-05-05'),
(9, 27, '2024-05-10'),
(10, 28, '2024-05-15'),
(10, 29, '2024-05-20'),
(10, 30, '2024-05-25');

INSERT INTO Watchlist_Shows (watchlist_id, show_id, date_added) VALUES
(1, 1, '2024-01-01'),
(1, 2, '2024-01-05'),
(1, 3, '2024-01-10'),
(2, 4, '2024-01-15'),
(2, 5, '2024-01-20'),
(2, 6, '2024-01-25'),
(3, 7, '2024-02-01'),
(3, 8, '2024-02-05'),
(3, 9, '2024-02-10'),
(4, 10, '2024-02-15'),
(4, 11, '2024-02-20'),
(4, 12, '2024-02-25'),
(5, 13, '2024-03-01'),
(5, 14, '2024-03-05'),
(5, 15, '2024-03-10'),
(6, 16, '2024-03-15'),
(6, 17, '2024-03-20'),
(6, 18, '2024-03-25'),
(7, 19, '2024-04-01'),
(7, 20, '2024-04-05'),
(7, 21, '2024-04-10'),
(8, 22, '2024-04-15'),
(8, 23, '2024-04-20'),
(8, 24, '2024-04-25'),
(9, 25, '2024-05-01'),
(9, 26, '2024-05-05'),
(9, 27, '2024-05-10'),
(10, 28, '2024-05-15'),
(10, 29, '2024-05-20'),
(10, 30, '2024-05-25');


-- 1. Count of Movies per Genre
SELECT g.name AS Genre_Name, COUNT(m.movie_id) AS Total_Movies
FROM Genre g
LEFT JOIN Movie m ON g.genre_id = m.genre_id
GROUP BY g.name
ORDER BY Total_Movies DESC;

-- 2. Average Rating for Each Movie
SELECT m.title AS Movie_Title, AVG(r.rating_value) AS Average_Rating
FROM Movie m
JOIN Rating r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING COUNT(r.rating_id) > 0
ORDER BY Average_Rating DESC;

-- 3. Top 5 Users with the Most Ratings
SELECT TOP 5 u.email, COUNT(r.rating_id) AS Rating_Count
FROM [User] u
JOIN Rating r ON u.user_id = r.user_id
GROUP BY u.email
ORDER BY Rating_Count DESC;

-- 4. Movies with the Highest Number of Awards
SELECT m.title AS Movie_Title, COUNT(ma.award_id) AS Total_Awards
FROM Movie m
JOIN Movie_Award ma ON m.movie_id = ma.movie_id
GROUP BY m.title
ORDER BY Total_Awards DESC;

-- Average Rating for each Show
SELECT g.name AS Genre_Name, AVG(r.rating_value) AS Average_Rating
FROM Genre g
JOIN Show s ON g.genre_id = s.genre_id
JOIN Rating r ON s.show_id = r.show_id
GROUP BY g.name
HAVING COUNT(r.rating_id) > 0
ORDER BY Average_Rating DESC;



-- 6. List of Actors and the Number of Movies They've Acted In
SELECT a.name AS Actor_Name, COUNT(ma.movie_id) AS Movies_Acted_In
FROM Actor a
LEFT JOIN Movie_Actor ma ON a.actor_id = ma.actor_id
GROUP BY a.name
ORDER BY Movies_Acted_In DESC;

-- 7. Count of shows per genre
SELECT g.name AS Genre_Name, COUNT(s.show_id) AS Total_Shows
FROM Genre g
LEFT JOIN Show s ON g.genre_id = s.genre_id
GROUP BY g.name
ORDER BY Total_Shows DESC;


-- 8. Top 3 Genres with the Highest Average Movie Ratings
SELECT TOP 3 g.name AS Genre_Name, AVG(r.rating_value) AS Avg_Rating
FROM Genre g
JOIN Movie m ON g.genre_id = m.genre_id
JOIN Rating r ON m.movie_id = r.movie_id
GROUP BY g.name
ORDER BY Avg_Rating DESC;


-- 9. Total Number of Awards earned per Movie
SELECT m.title AS Movie_Title, COUNT(ma.award_id) AS Total_Awards
FROM Movie m
LEFT JOIN Movie_Award ma ON m.movie_id = ma.movie_id
GROUP BY m.title
ORDER BY Total_Awards DESC;


-- 10. Total Duration of All Episodes per Show
SELECT s.title AS Show_Title, SUM(e.duration) AS Total_Duration_Minutes
FROM Show s
JOIN Episode e ON s.show_id = e.show_id
GROUP BY s.title
ORDER BY Total_Duration_Minutes DESC;

