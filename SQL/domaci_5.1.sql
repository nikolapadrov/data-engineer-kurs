-- DENSE RANK --

SELECT
    p.first_name,
    p.last_name,
    COUNT(*) AS total_goals,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM match_events AS e
JOIN matches AS m ON e.match_id = m.match_id
JOIN players AS p ON e.player_id = p.player_id
WHERE m.season = '2024/25'
    AND e.event_type IN ('goal', 'penalty_goal')
GROUP BY p.player_id, p.first_name, p.last_name
ORDER BY rank, p.last_name;


-- ROW NUMBER --

WITH golovi AS (
    SELECT
        t.team_name,
        p.first_name,
        p.last_name,
        COUNT(*) AS total_goals
    FROM match_events AS e
    JOIN matches AS m ON e.match_id = m.match_id
    JOIN players AS p ON e.player_id = p.player_id
    JOIN teams AS t ON e.team_id = t.team_id
    WHERE m.season = '2024/25'
        AND e.event_type IN ('goal', 'penalty_goal')
    GROUP BY t.team_name, p.player_id, p.first_name, p.last_name
),
rangirani AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY team_name ORDER BY total_goals DESC) AS row__number
    FROM golovi
)
SELECT team_name, first_name, last_name, total_goals, row__number
FROM rangirani
WHERE row__number <= 3
ORDER BY team_name, row__number;


-- LAG -- 

WITH utakmice_kluba AS (
    SELECT
        t.team_name,
        m.kickoff_ts,
        CASE WHEN m.home_team_id = t.team_id THEN m.home_goals
             ELSE m.away_goals END AS dati_golovi
    FROM matches AS m
    JOIN teams AS t ON m.home_team_id = t.team_id
                    OR m.away_team_id = t.team_id
    WHERE m.season = '2024/25'
        AND m.status = 'played'
)
SELECT
    team_name,
    CAST(kickoff_ts AS DATE) AS datum,
    dati_golovi,
    LAG(dati_golovi) OVER (PARTITION BY team_name ORDER BY kickoff_ts) AS golovi_prethodna,
    dati_golovi
      - LAG(dati_golovi) OVER (PARTITION BY team_name ORDER BY kickoff_ts) AS razlika
FROM utakmice_kluba
ORDER BY team_name, kickoff_ts;

