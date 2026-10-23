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

-- 4. Zadatak

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

-- 7. Zadatak

SELECT
  p.first_name,
  p.last_name,
  count(me.related_player_id) as goals_assists
FROM players p
 JOIN match_events me ON p.player_id = me.related_player_id
 JOIN matches m ON me.match_id = m.match_id
WHERE me.related_player_id IS NOT NULL
  AND me.event_type = 'goal'
  AND m.season = '2024/25'
GROUP BY p.first_name, p.last_name
ORDER BY goals_assists DESC
LIMIT 5;

------------------------------------------------------------------------------

-- 8. Zadatak

SELECT
  p.first_name,
  p.last_name,
  t.team_name,
  sum(pms.minutes_played) as total_minutes
FROM player_match_stats as pms
 JOIN players p ON pms.player_id = p.player_id
 JOIN teams t ON pms.team_id = t.team_id
 JOIN matches m ON pms.match_id = m.match_id
WHERE m.season = '2024/25'
GROUP BY p.first_name, p.last_name, t.team_name
ORDER BY total_minutes DESC
LIMIT 3;

------------------------------------------------------------------------------

-- 9. Zadatak

SELECT
    m.season,
    t.team_name,
    count(me.event_type) as total_exclusion
FROM matches m
 JOIN match_events me ON m.match_id = me.match_id
 JOIN teams t ON me.team_id = t.team_id
WHERE me.event_type IN ('red_card', 'second_yellow')
GROUP BY m.season, t.team_name
HAVING total_exclusion >= 1
ORDER BY total_exclusion DESC;

------------------------------------------------------------------------------