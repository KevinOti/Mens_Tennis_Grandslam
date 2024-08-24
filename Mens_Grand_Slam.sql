-- The Mens tennis grand slam is huge and the same has the household names participate
-- The analysis will be purely to view how each has fared and who ranks top in terms of grand slams
-- The data has features such as years, Winner runner_up, Winner nationality, Tournament surface and 
-- Winner hand(Left or Right)
-- The process will involve loading the data which is CSV format and other analytical aspects of querying the data further


-- Loading the data

DROP TABLE mens_grandslam

CREATE TABLE mens_grandslam(
	year text,
	tournament text,
	winner text,
	runner_up text,
	winner_nationality text,
	winner_Atp_ranking text,
	runner_up_Atp_ranking text,
	winner_left_right_handed text,
	tournament_surface text,
	winner_prize integer
);


-- Importing data into SQL

COPY mens_grandslam (year, tournament, winner, runner_up, winner_nationality, winner_Atp_ranking, 
					 winner_left_right_handed, runner_up_atp_ranking,tournament_surface, winner_prize)
FROM 'C:\Users\KEVIN\Downloads\Dataset\Dataset\Mens_Tennis_Grand_Slam_Winner.csv'
WITH (FORMAT CSV, HEADER)

 -- Checking the top 5 rows to confirm the data was correctly loaded
 
SELECT *
FROM mens_grandslam
LIMIT 5

-- From the data o just view there are number of things that are already coming out top of mind they include
	-- Tournament - How many grand slams are held each year
	-- Winner - which player has the most wins and how do the other winner rank in the list of winners
	-- Runners up - What about them, is there a trend?
	-- Winner nationality - which nationality has produced more grand slam winners
	-- Surface - which surface is favourable to the winners
-- Analysis will tend to answer the above plus highlight other insights that come along the way
	--


-- Grand Slam analysis

-- How many times have the grandslams been held since inception

SELECT
distinct(tournament) AS grand_slam,
count(*) as number_of_times_held
FROM mens_grandslam
GROUP BY grand_slam
ORDER BY number_of_times_held DESC

-- All the competitions have been held atleast 73 times, we have for major grand slams 
-- Yearly all four competition are held

-- Winners standing
SELECT
	winner,
	winner_nationality,
	count(*) as number_of_wins
FROM mens_grandslam
GROUP BY winner, winner_nationality
ORDER BY number_of_wins DESC

-- Rafael Nadal and Novak Djokovic as of 2023 are tied in the number of grand_slams won by each, this excludes 3 grandslam held in later parts of 2023.
-- Rodger Federer Comes in second with 20 grandslams
-- Pete sampras is fourth with Roy Emerson coming in 5th

SELECT
	winner_nationality,
	count(*) as number_of_wins
FROM mens_grandslam
GROUP BY winner_nationality
ORDER BY number_of_wins DESC

-- Nationality wise the Americans are dominant followed through by Australia, Spain and Sweden

SELECT
	runner_up,
	count(*) as number_of_wins
FROM mens_grandslam
GROUP BY runner_up
ORDER BY number_of_wins DESC

-- Interesting to note that Roger Federer and Novak Djokovic have been runners up for atleast 11 times, Rafael Nadal has been a runner up atleast 8 times.

-- U.S Open
SELECT 
	winner,
	winner_nationality,
	count(*)
FROM mens_grandslam
WHERE tournament = 'U.S. Open'
GROUP BY winner, winner_nationality
ORDER BY count(*) DESC
LIMIT 5

-- Top 5 players with more wins in the US open
	-- Roger Federer 5 titles under his name with Nadal owning 4 titles
	
SELECT 
	winner,
	winner_nationality,
	count(*)
FROM mens_grandslam
WHERE tournament = 'Australian Open'
GROUP BY winner, winner_nationality
ORDER BY count(*) DESC
LIMIT 5

-- Top 5 players with more wins in the Australian open
	-- Novak Djokovic has 10 titles under his name with Roger holding off 6 medals

SELECT 
	winner,
	winner_nationality,
	count(*)
FROM mens_grandslam
WHERE tournament = 'Wimbledon'
GROUP BY winner, winner_nationality
ORDER BY count(*) DESC
LIMIT 5

-- Top 5 players with more wins in the Wimbledon
	-- Federer 8 titles under his with Novak holding 7 under his name

SELECT 
	winner,
	winner_nationality,
	count(*),
	tournament_surface
FROM mens_grandslam
WHERE tournament = 'French Open'
GROUP BY winner, winner_nationality, tournament_surface
ORDER BY count(*) DESC
LIMIT 5

-- Top 5 players with more wins in the french open
	-- Nadal has more wins under his name in the French open which is played on a clay surface hence the title 'King of clay'
	
select * from mens_grandslam "Australian Open"

-- Renaming columns that were wrongly named

ALTER TABLE mens_grandslam RENAME COLUMN runner_up_atp_ranking TO hand
ALTER TABLE mens_grandslam RENAME COLUMN winner_left_right_handed TO runner_up_ranking


-- Use subquery to find out if the winner is left or right handed
	 -- Interesting to note 83% of the players are right handed
SELECT
	hand,
	count(*) player_hand
FROM(
	SELECT 
		distinct winner,
		hand
	FROM mens_grandslam)
	GROUP BY hand


