-- =====================================================================
-- Dosije kluba: Kingsbridge City (Sezona 2024/25)
-- =====================================================================

-- ==============================
-- 1. Sezona u brojevima 
-- ==============================
-- 2. Kod kuće i u gostima
-- ==============================

-- Domaci utakmice i rezultati --

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT
    COUNT(*) AS odigrane_utakmice,
    COUNT_IF(m.home_goals > m.away_goals) AS pobede,
    COUNT_IF(m.home_goals = m.away_goals) AS neresene,
    COUNT_IF(m.home_goals < m.away_goals) AS porazi,
    SUM(m.home_goals) AS dati_golovi,
    SUM(m.away_goals) AS primljeni_golovi,
    SUM(CASE WHEN m.home_goals > m.away_goals THEN 3
             WHEN m.home_goals = m.away_goals THEN 1
             ELSE 0 END) AS osvojeni_bodovi
FROM matches AS m
JOIN club AS c ON m.home_team_id = c.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played';


-- Gostujuce utakmice i rezultati --

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT
    COUNT(*) AS odigrane_utakmice,
    COUNT_IF(m.away_goals > m.home_goals) AS pobede,
    COUNT_IF(m.away_goals = m.home_goals) AS neresene,
    COUNT_IF(m.away_goals < m.home_goals) AS porazi,
    SUM(m.away_goals) AS dati_golovi,
    SUM(m.home_goals) AS primljeni_golovi,
    SUM(CASE WHEN m.away_goals > m.home_goals THEN 3
             WHEN m.away_goals = m.home_goals THEN 1
             ELSE 0 END) AS osvojeni_bodovi
FROM matches AS m
JOIN club AS c ON m.away_team_id = c.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played';


-- =====================================================================
-- 3. TRI NAJBOLJA STRELCA
-- =====================================================================

WITH club AS (
    SELECT team_id
    FROM bootcamp.northern_star.teams
    WHERE team_name = 'Kingsbridge City'
),
season_events AS (
    SELECT e.*
    FROM match_events AS e
    JOIN matches AS m ON e.match_id = m.match_id
    JOIN club AS c ON e.team_id = c.team_id
    WHERE m.season = '2024/25'
),
scorers AS (
    SELECT p.player_id, p.first_name, p.last_name, COUNT(*) AS goals
    FROM season_events AS e
    JOIN players AS p ON e.player_id = p.player_id
    WHERE e.event_type IN ('goal', 'penalty_goal')
    GROUP BY p.player_id, p.first_name, p.last_name
)
SELECT first_name, last_name, goals
FROM scorers
ORDER BY goals DESC, last_name
LIMIT 3;   

-- =====================================================================
-- 3. NAJBOLJI ASISTENT
-- =====================================================================

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
),
season_events AS (
    SELECT e.*
    FROM match_events AS e
    JOIN matches AS m ON e.match_id = m.match_id
    JOIN club AS c ON e.team_id = c.team_id
    WHERE m.season = '2024/25'
),
assisters AS (
    SELECT p.player_id, p.first_name, p.last_name, COUNT(*) AS assists
    FROM season_events AS e
    JOIN players AS p ON e.related_player_id = p.player_id
    WHERE e.event_type = 'goal'
    GROUP BY p.player_id, p.first_name, p.last_name
)
SELECT first_name, last_name, assists
FROM assisters
ORDER BY assists DESC
LIMIT 1;


-- =============================================================================
-- 4. DISCIPLINA: kartoni kluba po utakmici vs. prosek lige po timu po utakmici
-- =============================================================================

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT COUNT(*) AS kartoni_kluba
FROM match_events AS e
JOIN matches AS m ON e.match_id = m.match_id
JOIN club AS c ON e.team_id = c.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played'
    AND e.event_type IN ('yellow_card', 'second_yellow', 'red_card');

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT COUNT(*) AS utakmice_kluba
FROM matches AS m
JOIN club AS c ON m.home_team_id = c.team_id
               OR m.away_team_id = c.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played';

SELECT COUNT(*) AS kartoni_lige
FROM match_events AS e
JOIN matches AS m ON e.match_id = m.match_id
WHERE m.season = '2024/25'
    AND m.status = 'played'
    AND e.event_type IN ('yellow_card', 'second_yellow', 'red_card');

SELECT COUNT(*) AS utakmice_lige
FROM matches
WHERE season = '2024/25'
    AND status = 'played';

-- ============================================================================
-- 5. TRENERI: ko je vodio klub u sezoni i sa koliko bodova po utakmici
-- ============================================================================

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT 
    ms.manager_name, 
    ms.start_date, 
    ms.end_date
FROM manager_spells AS ms
JOIN club AS c ON ms.team_id = c.team_id
ORDER BY ms.start_date;

-- ============================================================================
-- 6. NAJVEĆA POBEDA I NAJTEŽI PORAZ
-- ============================================================================

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT
    CAST(m.kickoff_ts AS DATE) AS datum,
    t.team_name AS protivnik,
    m.home_goals AS dati_golovi,
    m.away_goals AS primljeni_golovi,
    m.home_goals - m.away_goals AS gol_razlika
FROM matches AS m
JOIN club AS c ON m.home_team_id = c.team_id
JOIN teams AS t ON m.away_team_id = t.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played'
ORDER BY gol_razlika DESC, datum;


WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT
    CAST(m.kickoff_ts AS DATE) AS datum,
    t.team_name AS protivnik,
    m.away_goals AS dati_golovi,
    m.home_goals AS primljeni_golovi,
    m.away_goals - m.home_goals AS gol_razlika
FROM matches AS m
JOIN club AS c ON m.away_team_id = c.team_id
JOIN teams AS t ON m.home_team_id = t.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played'
ORDER BY gol_razlika, datum;


-- ============================================================================
--  7. PUBLIKA: prosečna poseta, popunjenost na domaćim utakmicama
--     i koliko utakmica nema podatak o poseti
-- ============================================================================

WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT
    COUNT(*) AS domace_utakmice,
    ROUND(AVG(m.attendance)) AS prosecna_poseta,
    COUNT(*) - COUNT(m.attendance) AS bez_podatka_o_poseti
FROM matches AS m
JOIN club AS c ON m.home_team_id = c.team_id
WHERE m.season = '2024/25'
    AND m.status = 'played';



WITH club AS (
    SELECT team_id
    FROM teams
    WHERE team_name = 'Kingsbridge City'
)
SELECT
    s.stadium_name,
    s.capacity,
    COUNT(*) AS utakmica_na_stadionu,
    ROUND(AVG(m.attendance)) AS prosecna_poseta,
    ROUND(AVG(m.attendance) * 100.0 / s.capacity, 1) AS popunjenost
FROM matches AS m
JOIN club AS c ON m.home_team_id = c.team_id
JOIN stadiums AS s ON m.stadium_id = s.stadium_id
WHERE m.season = '2024/25'
    AND m.status = 'played'
GROUP BY s.stadium_name, s.capacity;

