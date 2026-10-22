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

-- 3. Zadatak

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

-- 4. zadatak

SELECT
    DATE(m.kickoff_ts) AS match_date,
    ht.team_name AS home_team,
    at.team_name AS away_team,
    m.attendance AS attendance_check
FROM bootcamp.northern_star.matches AS m
INNER JOIN bootcamp.northern_star.teams AS ht
    ON m.home_team_id = ht.team_id
INNER JOIN bootcamp.northern_star.teams AS at
    ON m.away_team_id = at.team_id
WHERE m.attendance IS NULL
ORDER BY match_date;

------------------------------------------------------------------------------

-- 5. Zadatak

SELECT
    s.stadium_id,
    s.stadium_name,
    m.match_id,
    m.kickoff_ts,
    m.match_report
FROM bootcamp.northern_star.stadiums AS s
LEFT JOIN bootcamp.northern_star.matches AS m
    ON  s.stadium_id = m.stadium_id
    AND m.season = '2024/25'
WHERE m.match_id IS NULL;

------------------------------------------------------------------------------

-- 6. Zadatak

SELECT
    t.team_name,
    COUNT(*) AS yellow_cards
FROM bootcamp.northern_star.match_events AS e
INNER JOIN bootcamp.northern_star.matches AS m
    ON e.match_id = m.match_id
INNER JOIN bootcamp.northern_star.teams AS t
    ON e.team_id = t.team_id
WHERE m.season = '2024/25'
  AND e.event_type IN ('yellow_card', 'second_yellow')
GROUP BY t.team_id, t.team_name
ORDER BY yellow_cards DESC, t.team_name;

------------------------------------------------------------------------------