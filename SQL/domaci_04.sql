-----------
-- JOINS --
-----------

-- 1. Zadatak

SELECT
    t.team_name,
    coalesce(s.stadium_name, 'unknown')
FROM teams AS t
LEFT JOIN stadiums AS s
    ON t.stadium_id = s.stadium_id
ORDER BY t.team_name;

------------------------------------------------------------------------------

-- 2. Zadatak

SELECT
    DISTINCT p.first_name, p.last_name, t.team_name
FROM player_match_stats AS pms
INNER JOIN matches AS m
    ON pms.match_id = m.match_id
INNER JOIN players AS p
    ON pms.player_id = p.player_id
INNER JOIN teams AS t
    ON pms.team_id = t.team_id
WHERE m.season = '2024/25';

------------------------------------------------------------------------------

--- 3. Zadatak

SELECT
    DATE(m.kickoff_ts)  AS match_date,
    s.stadium_name,
    m.attendance
FROM matches AS m
INNER JOIN stadiums AS s
    ON m.stadium_id = s.stadium_id
WHERE m.season = '2024/25'
ORDER BY m.kickoff_ts, m.match_id;

------------------------------------------------------------------------------