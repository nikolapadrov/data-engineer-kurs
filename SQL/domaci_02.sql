USE bootcamp.northern_star;

-- DOMACI 2.2
-- SQL fudbalske utakmice

---------------------------------------------------------------------------------------

-- 1. ZADATAK
-- Pronađite sve utakmice čiji naslov ('match_report') sadrži reč 'goal',
-- bez obzira na velika i mala slova.

SELECT *
FROM matches_flat
WHERE match_report ILIKE '%goal%';

---------------------------------------------------------------------------------------

-- 2. ZADATAK
-- Npraviti kolonu 'referee_name' tako da sadrži ime sudije ako postoji,
-- a tekst 'Unknown' ako nedostaje. Prikažite 20 utakmica.

SELECT
    COALESCE(referee_name, 'Unknown') AS referee_name
FROM matches_flat
LIMIT 20;

---------------------------------------------------------------------------------------

-- 3. ZADATAK 
-- Prikažite utakmice čiji je naslov duži od 40 znakova.
-- Prikažite naslov i broj znakova u njemu.

SELECT
    match_id, kickoff_ts, season,
    home_team, away_team,
    home_goals, away_goals, match_report,
    length(match_report) as char_num
FROM matches_flat
WHERE length(match_report) > 40;

---------------------------------------------------------------------------------------

-- 4. ZADATAK
-- Prikažite utakmice odigrane od 01. do 15. januara 2025,
-- uključujući oba datuma.

SELECT * 
FROM matches_flat
WHERE kickoff_ts >= '2025-01-01' 
    AND kickoff_ts < '2025-01-16'
ORDER BY kickoff_ts, match_id;

---------------------------------------------------------------------------------------

-- 5. ZADATAK
-- Prebrojte utakmice odigrane petkom.
-- Prikažite datum i dan u nedelji za svaku od njih.
-- Nijenda utakmica nije odigrana u petak tako da i upit sa COUNT(*) vraća 0.

SELECT
    match_id, kickoff_ts,
    date_format(kickoff_ts, 'yyyy-MM-dd') AS datum,
    date_format(kickoff_ts, 'EEEE') AS dan,
    dayofweek(kickoff_ts) AS day_num 
FROM matches_flat
WHERE dayofweek(kickoff_ts) = 6;

---------------------------------------------------------------------------------------

-- 6. ZADATAK
-- Koliko utakmica sezone '2024/25' je imalo između
-- 20.000 i 35.000 gledalaca, uključujući obe granice?

SELECT COUNT(*) AS attendance_from_20k_to_35k
FROM matches_flat
WHERE season = '2024/25'
    AND attendance BETWEEN 20000 AND 35000;

---------------------------------------------------------------------------------------

-- 7. ZADATAK
-- Pronađite strelce prvog gola čije ime počinje slovom 'A'
-- ili sadrži crticu. Prikažite samo različita imena.

SELECT
    DISTINCT first_goal_scorer
FROM matches_flat
WHERE (first_goal_scorer like 'A%')
    OR (first_goal_scorer like '%-%')
ORDER BY first_goal_scorer;

---------------------------------------------------------------------------------------

-- 8. ZADATAK
-- Prikažite utakmice sezone '2024/25' koje su
-- počele između 18:00 i 21:00, uključujući obe granice.
-- Prikažite vreme početka i nazive timova.

SELECT
    match_id, season, kickoff_ts, 
    date_format(kickoff_ts, 'HH:mm') AS sati_minuti,
    home_team, away_team, 
    home_goals, away_goals
FROM matches_flat
WHERE season = '2024/25'
    AND date_format(kickoff_ts, 'HH:mm') BETWEEN '18:00' AND '21:00';

---------------------------------------------------------------------------------------

-- 9. ZADATAK
-- Prebrojte utakmice odigrane u martu, aprilu ili maju
-- 2025 godine čiji naslov sadrži reč 'win', bez obzira na
-- veličinu slova.

SELECT COUNT(*) AS broj_utakmica
FROM matches_flat
WHERE year(kickoff_ts) = 2025 
    AND month(kickoff_ts) IN (3,4,5)
    AND match_report ILIKE '%win%';

---------------------------------------------------------------------------------------
