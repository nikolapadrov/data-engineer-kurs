-- 1. ZADATAK
-- Dodati kolonu empty_seats (kapacitet stadiona - poseta)
-- i prikažite 5 utakmica sa najviše praznih mesta.
-- Šta je zajedničko za prve tri? (Isti stadion)

SELECT
    match_id, home_team, away_team,  
    stadium_name, stadium_capacity, attendance,
    (stadium_capacity - attendance) AS empty_seats
FROM bootcamp.northern_star.matches_flat
ORDER BY empty_seats DESC
LIMIT 5;

---------------------------------------------------------------------------------------

-- 2. ZADATAK
-- Koliko različitih sudija je sudilo domaće utakmice
-- kluba Riverton Athletic?

SELECT
    COUNT(DISTINCT referee_name) AS broj_razlicitih_sudija
FROM bootcamp.northern_star.matches_flat
WHERE home_team = 'Riverton Athletic';

---------------------------------------------------------------------------------------

-- 3. ZADATAK
-- U koliko utakmica je gost vodio na poluvremenu
-- a domaćin pobedio na kraju?

SELECT
    COUNT(*) AS from_2_to_1
FROM bootcamp.northern_star.matches_flat
WHERE (home_goals_ht < away_goals_ht)
    AND (home_goals > away_goals);

---------------------------------------------------------------------------------------

-- 4. ZADATAK
-- U kojoj utakmici je palo najviše golova u drugom poluvremenu?
-- Ko je igrao, rezultat na poluvremenu i rezultata na kraju?

SELECT
    home_team, away_team,
    home_goals_ht, away_goals_ht,
    home_goals, away_goals,
    (home_goals - home_goals_ht) + (away_goals - away_goals_ht) AS second_half_goals
FROM bootcamp.northern_star.matches_flat
ORDER BY second_half_goals DESC
LIMIT 1;

---------------------------------------------------------------------------------------

-- 5. ZADATAK
-- Koliko utakmica sezone 2023/24 je odigrano po snegu ili magli?

SELECT 
    COUNT(*) AS games_in_fog_or_snow
FROM bootcamp.northern_star.matches_flat
WHERE season = '2023/24'
    AND weather IN ('snow', 'fog');

---------------------------------------------------------------------------------------

-- 6. ZADATAK
-- Prikažite sve utakmice gradskog derbija između Northport United i Northport City
-- bez obzira na to ko je domaćin, sortirane po datumu. Ko je pobedio u kom meču?

SELECT
    match_id, kickoff_ts, home_team, 
    away_team, home_goals, away_goals
FROM bootcamp.northern_star.matches_flat
WHERE (home_team = 'Northport United' AND away_team = 'Northport City')
    OR (home_team = 'Northport City' AND away_team = 'Northport United')
ORDER BY kickoff_ts;

---------------------------------------------------------------------------------------

-- 7. ZADATAK
-- Prikažite prve 3 utakmice sezone 2024/25 po vremenu početka.
-- Da li možete biti sigurni koja je druga, a koja treća?
-- Kako biste to obezbedili? (jedino match_id, mada i te utakmice počinju u isto vreme)

SELECT *
FROM bootcamp.northern_star.matches_flat
WHERE season = '2024/25'
ORDER BY kickoff_ts, match_id
LIMIT 3;

---------------------------------------------------------------------------------------

-- 8. ZADATAK
-- Prikažite sve utakmice u kojima je prvi gol dao Sean O'Neill. 
-- Koliko ih je? 
-- Poseban odgovor na ovo pitanje bi trebao COUNT(*) u SELECT-u pa bi dobili broj 2.

SELECT
    match_id, kickoff_ts, home_team, away_team, 
    home_goals, away_goals, first_goal_scorer
FROM bootcamp.northern_star.matches_flat
WHERE first_goal_scorer = 'Sean O\'Neill';