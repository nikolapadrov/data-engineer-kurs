-------------------------
-- AGGREGATE FUNCTIONS --
-------------------------

-- 1. Zadatak

SELECT
    season,
    count(*) as total_matches, 
    count(home_goals + away_goals) as total_goals,
    round(avg(home_goals + away_goals),2) as avg_goals 
FROM bootcamp.northern_star.matches_flat
GROUP BY season;

-----------------------------------------------------------------------------------

-- 2. Zadatak

SELECT
    stadium_name,
    min(attendance) as min_attendance,
    max(attendance) as max_attendance,
    round(avg(attendance)) as avg_attendance,
    count(attendance) as games_with_attendance
FROM bootcamp.northern_star.matches_flat
GROUP BY stadium_name;

-----------------------------------------------------------------------------------

-- 3. Zadatak

SELECT
    referee_name,
    count(*) as total_matches,
    sum(home_yellow_cards + away_yellow_cards) as total_yellow_cards
FROM bootcamp.northern_star.matches_flat
GROUP BY referee_name
HAVING total_matches >= 10
    and total_yellow_cards >= 20
ORDER BY total_matches DESC;

-----------------------------------------------------------------------------------

-- 4. Zadatak

SELECT
    CASE
        WHEN home_goals + away_goals = 0 THEN 'Bez golova'
        WHEN home_goals + away_goals BETWEEN 1 AND 2 THEN 'Malo golova'
        WHEN home_goals + away_goals >= 3 THEN 'Mnogo golova'
        ELSE 'Nepoznato'
    END AS opseg_golova,
    count(*) as total_matches,
    max(home_goals + away_goals) as max_goals
FROM bootcamp.northern_star.matches_flat
GROUP BY opseg_golova
ORDER BY max_goals desc;

-----------------------------------------------------------------------------------

-- 5. Zadatak 

SELECT
    home_team,
    count(*) as home_matches,
    count_if(home_goals > away_goals) as home_wins,
    count_if(home_goals < away_goals) as home_losses
FROM bootcamp.northern_star.matches_flat
GROUP BY home_team
HAVING count(*) >= 10
ORDER BY home_matches desc;

-----------------------------------------------------------------------------------

-- 6. Zadatak

SELECT
    referee_name,
    count(*) as matches_total,
    count_if(home_red_cards > 0 OR away_red_cards > 0) as matches_with_red_cards,
    round(count_if(home_red_cards > 0 OR away_red_cards > 0) * 100 / count(*), 1) as red_card_percentage
FROM bootcamp.northern_star.matches_flat
GROUP BY referee_name
ORDER BY red_card_percentage desc;

-----------------------------------------------------------------------------------

-- 7. Zadatak

SELECT
   season,
   count(*) as total_matches,
   count_if(home_goals > away_goals) as home_wins,
   count_if(home_goals = away_goals) as draws,
   count_if(home_goals < away_goals) as away_wins,
   round(count_if(home_goals = away_goals) * 100 / count(*), 2) as draw_percentage
FROM bootcamp.northern_star.matches_flat
WHERE status = 'played'
GROUP BY season;

-----------------------------------------------------------------------------------