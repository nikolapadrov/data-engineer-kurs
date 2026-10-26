--------------------------------------------------
-- Dosije kluba: Kingsbridge City (Sezona 2024/25)
--------------------------------------------------

----- 1. Sezona u brojevima -----

WITH club AS (
    SELECT team_id 
    FROM teams 
    WHERE team_name = 'Kingsbridge City'
),
club_matches AS (
    SELECT m.match_id, m.kickoff_ts, m.stadium_id, m.attendance,
           'home'         AS venue,
           m.away_team_id AS protivnik_id,
           m.home_goals   AS dati_golovi,
           m.away_goals   AS primljeni_golovi
    FROM matches AS m
    JOIN club AS c ON m.home_team_id = c.team_id
    WHERE m.season = '2024/25' 
        AND m.status = 'played'

UNION ALL

    SELECT m.match_id, m.kickoff_ts, m.stadium_id, m.attendance,
           'away',
           m.home_team_id,
           m.away_goals,
           m.home_goals
    FROM matches AS m
    JOIN club AS c ON m.away_team_id = c.team_id
    WHERE m.season = '2024/25' 
        AND m.status = 'played'
),
results AS (
    SELECT *,
        CASE
            WHEN dati_golovi > primljeni_golovi THEN 'Pobeda'
            WHEN dati_golovi = primljeni_golovi THEN 'Nereseno'
            ELSE 'Izgubljena'
        END AS result,
        CASE 
            WHEN dati_golovi > primljeni_golovi THEN 3
            WHEN dati_golovi = primljeni_golovi THEN 1
            ELSE 0 
        END AS points
    FROM club_matches
)
SELECT
    COUNT(*) AS odigrane_utakmice,
    COUNT_IF(result = 'Pobeda') AS Pobede,
    COUNT_IF(result = 'Nereseno') AS Neresene,
    COUNT_IF(result = 'Izgubljena') AS Porazi,
    SUM(dati_golovi) AS Dati_golovi,
    SUM(primljeni_golovi) AS Primljeni_golovi,
    SUM(points) AS Osvojeni_bodovi
FROM results;