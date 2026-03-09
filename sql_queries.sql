-- Database banana
CREATE DATABASE T20WorldCup1;
USE T20WorldCup1;

-- 1. Tournament Winners Table
CREATE TABLE tournament_winners (
    year INT PRIMARY KEY,
    winner VARCHAR(50),
    runner_up VARCHAR(50),
    player_of_series VARCHAR(50)
);

-- 2. Batting Stats Table
CREATE TABLE batting (
    match_id VARCHAR(50),
    tournament_year INT,
    inning INT,
    team VARCHAR(50),
    batter VARCHAR(50),
    runs INT,
    balls INT,
    fours INT,
    sixes INT,
    strike_rate DECIMAL(5,2),
    dismissal VARCHAR(100)
);

-- 3. Bowling Stats Table
CREATE TABLE bowling (
    match_id VARCHAR(50),
    tournament_year INT,
    inning INT,
    team VARCHAR(50),
    bowler VARCHAR(50),
    overs DECIMAL(3,1),
    maidens INT,
    runs INT,
    wickets INT,
    economy DECIMAL(4,2),
    dots INT
);

-- 4. Matches Detailed Table
CREATE TABLE matches (
    match_id VARCHAR(50) PRIMARY KEY,
    tournament_year INT,
    toss_winner VARCHAR(50),
    toss_decision VARCHAR(10),
    match_date DATE,
    ground VARCHAR(100),
    player_of_match VARCHAR(50),
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    winner VARCHAR(50),
    winning_score INT
);
SELECT batter, SUM(runs) AS total_runs
FROM batting
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 5;
SELECT m.player_of_match, m.winner, m.tournament_year, m.ground
FROM matches m
JOIN tournament_winners tw ON m.tournament_year = tw.year
WHERE m.winner = tw.winner;
SELECT team, SUM(sixes) AS total_sixes
FROM batting
GROUP BY team
ORDER BY total_sixes DESC
LIMIT 3;
SELECT bowler, SUM(runs) / SUM(overs) AS career_economy
FROM bowling
GROUP BY bowler
HAVING SUM(overs) >= 10
ORDER BY career_economy ASC
LIMIT 5;
SELECT 
    COUNT(*) AS total_matches,
    SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS toss_and_match_winners,
    (SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS win_percentage
FROM matches;
