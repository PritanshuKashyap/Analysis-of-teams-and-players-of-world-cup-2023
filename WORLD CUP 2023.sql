
CREATE DATABASE WorldCup2023;
USE WorldCup2023;      
  
CREATE TABLE Teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    country_code VARCHAR(5),
    captain VARCHAR(50),
    coach VARCHAR(50),
    matches_played INT,
    wins INT,
    losses INT,
    ties INT,
    points INT,
    net_run_rate FLOAT
);

CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50),
    team_id INT,
    role VARCHAR(30),
    matches INT,
    runs INT,
    wickets INT,
    average FLOAT,
    strike_rate FLOAT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    stadium_name VARCHAR(100),
    city VARCHAR(50),
    capacity INT
);

CREATE TABLE Matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    team1_id INT,
    team2_id INT,
    venue_id INT,
    match_date DATE,
    stage VARCHAR(50),
    winner_id INT,
    man_of_the_match VARCHAR(50),
    team1_score VARCHAR(20),
    team2_score VARCHAR(20),
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    FOREIGN KEY (winner_id) REFERENCES Teams(team_id)
);

CREATE TABLE Awards (
    award_id INT AUTO_INCREMENT PRIMARY KEY,
    award_name VARCHAR(100),
    player_name VARCHAR(50),
    team_name VARCHAR(50),
    performance VARCHAR(200)
);

-- Teams Data
INSERT INTO Teams (team_name, country_code, captain, coach, matches_played, wins, losses, ties, points, net_run_rate) VALUES
('India', 'IND', 'Rohit Sharma', 'Rahul Dravid', 11, 10, 1, 0, 20, +2.57),
('Australia', 'AUS', 'Pat Cummins', 'Andrew McDonald', 11, 8, 3, 0, 16, +0.84),
('New Zealand', 'NZ', 'Kane Williamson', 'Gary Stead', 10, 6, 4, 0, 12, +0.74),
('South Africa', 'SA', 'Temba Bavuma', 'Rob Walter', 10, 7, 3, 0, 14, +1.38),
('Pakistan', 'PAK', 'Babar Azam', 'Grant Bradburn', 9, 4, 5, 0, 8, -0.19),
('England', 'ENG', 'Jos Buttler', 'Matthew Mott', 9, 3, 6, 0, 6, -0.53),
('Bangladesh', 'BAN', 'Shakib Al Hasan', 'Chandika Hathurusingha', 9, 2, 7, 0, 4, -1.18),
('Afghanistan', 'AFG', 'Hashmatullah Shahidi', 'Jonathan Trott', 9, 4, 5, 0, 8, -0.33),
('Sri Lanka', 'SL', 'Kusal Mendis', 'Chris Silverwood', 9, 2, 7, 0, 4, -1.11),
('Netherlands', 'NED', 'Scott Edwards', 'Ryan Cook', 9, 2, 7, 0, 4, -1.18);

-- Venues Data
INSERT INTO Venues (stadium_name, city, capacity) VALUES
('Narendra Modi Stadium', 'Ahmedabad', 132000),
('Wankhede Stadium', 'Mumbai', 33000),
('Eden Gardens', 'Kolkata', 68000),
('Arun Jaitley Stadium', 'Delhi', 40000),
('M. Chinnaswamy Stadium', 'Bengaluru', 40000),
('MA Chidambaram Stadium', 'Chennai', 50000);

-- Matches Data
INSERT INTO Matches (team1_id, team2_id, venue_id, match_date, stage, winner_id, man_of_the_match, team1_score, team2_score) VALUES
(1, 2, 1, '2023-11-19', 'Final', 2, 'Travis Head', '240/10', '241/4'),
(1, 3, 2, '2023-11-15', 'Semi Final 1', 1, 'Virat Kohli', '397/4', '327/10'),
(2, 4, 3, '2023-11-16', 'Semi Final 2', 2, 'Mitchell Starc', '212/7', '168/10');

-- Players Data 
INSERT INTO Players (player_name, team_id, role, matches, runs, wickets, average, strike_rate) VALUES
('Virat Kohli', 1, 'Batsman', 11, 765, 0, 95.6, 90.3),
('Rohit Sharma', 1, 'Batsman', 11, 597, 0, 54.2, 107.8),
('Shreyas Iyer', 1, 'Batsman', 11, 530, 0, 58.9, 113.5),
('Jasprit Bumrah', 1, 'Bowler', 11, 35, 20, 10.2, 80.0),
('Pat Cummins', 2, 'Bowler', 11, 120, 15, 18.4, 89.6),
('Travis Head', 2, 'Batsman', 9, 329, 1, 45.6, 102.5),
('David Warner', 2, 'Batsman', 11, 535, 0, 48.6, 108.9),
('Mitchell Starc', 2, 'Bowler', 10, 55, 16, 12.5, 75.0),
('Kane Williamson', 3, 'Batsman', 8, 362, 0, 60.3, 98.2),
('Rachin Ravindra', 3, 'All-Rounder', 10, 578, 5, 64.2, 105.3);

-- Awards Data
INSERT INTO Awards (award_name, player_name, team_name, performance) VALUES
('Player of the Tournament', 'Virat Kohli', 'India', 'Scored 765 runs in 11 matches, 3 centuries'),
('Player of the Final', 'Travis Head', 'Australia', '137 runs vs India in Final'),
('Winning Captain', 'Pat Cummins', 'Australia', 'Led Australia to 6th title'),
('Best Bowler', 'Jasprit Bumrah', 'India', '20 wickets with 3.9 economy'),
('Emerging Player', 'Rachin Ravindra', 'New Zealand', '578 runs including 3 centuries');


-- QUERIES -- 

-- 1. Display all teams with their captains and total points
SELECT team_name, captain, points FROM Teams ORDER BY points DESC;

-- 2. List all players who scored more than 500 runs
SELECT player_name, runs FROM Players WHERE runs > 500 ORDER BY runs DESC;

-- 3. Find bowlers who took more than 15 wickets
SELECT player_name, wickets FROM Players WHERE wickets > 15;

-- 4. Show team with highest net run rate
SELECT team_name, net_run_rate FROM Teams ORDER BY net_run_rate DESC LIMIT 1;

-- 5. Display all matches played in Mumbai
SELECT m.match_id, t1.team_name AS Team1, t2.team_name AS Team2, v.city, m.match_date
FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id
JOIN Venues v ON m.venue_id = v.venue_id
WHERE v.city = 'Mumbai';

-- 6. Total runs scored by Indian players
SELECT SUM(runs) AS total_runs
FROM Players
WHERE team_id = (SELECT team_id FROM Teams WHERE team_name='India');

-- 7. List players with batting average above 60
SELECT player_name, average FROM Players WHERE average > 60;

-- 8. Find top 3 run scorers
SELECT player_name, runs FROM Players ORDER BY runs DESC LIMIT 3;

-- 9. Get all final match details
SELECT t1.team_name AS Team1, t2.team_name AS Team2, v.stadium_name, m.match_date, t3.team_name AS Winner
FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id
JOIN Teams t3 ON m.winner_id = t3.team_id
JOIN Venues v ON m.venue_id = v.venue_id
WHERE m.stage='Final';

-- 10. Show all award winners
SELECT award_name, player_name, team_name FROM Awards;

-- 11. Find players with both runs > 300 and wickets > 5
SELECT player_name, runs, wickets FROM Players WHERE runs > 300 AND wickets > 5;

-- 12. Count total matches per venue
SELECT v.city, COUNT(m.match_id) AS total_matches
FROM Venues v
LEFT JOIN Matches m ON v.venue_id = m.venue_id
GROUP BY v.city;

-- 13. Show top 5 teams by points
SELECT team_name, points FROM Teams ORDER BY points DESC LIMIT 5;

-- 14. Calculate total wickets by Australian players
SELECT SUM(wickets) AS total_wickets FROM Players WHERE team_id = 2;

-- 15. Display matches where India played
SELECT m.match_id, v.city, m.stage, m.match_date
FROM Matches m
JOIN Venues v ON m.venue_id = v.venue_id
WHERE m.team1_id = 1 OR m.team2_id = 1;

-- 16. Show top batsman from each team
SELECT team_name, player_name, runs
FROM Players p
JOIN Teams t ON p.team_id = t.team_id
WHERE (p.runs) IN (SELECT MAX(runs) FROM Players GROUP BY team_id);

-- 17. Find average runs per match for India
SELECT (SUM(runs)/SUM(matches)) AS avg_runs_per_match
FROM Players
WHERE team_id = 1;

-- 18. List all semifinal matches
SELECT stage, match_date, man_of_the_match
FROM Matches
WHERE stage LIKE '%Semi%';

-- 19. Show all venues with capacity greater than 50,000
SELECT stadium_name, city, capacity FROM Venues WHERE capacity > 50000;

-- 20. Get total number of centuries scored (runs > 100 per player)
SELECT COUNT(player_id) AS centuries_like FROM Players WHERE runs > 100;


