-- Dodatni zadaci 2.2

----------------------------------------------------------------------------------------

-- Prebrojte utakmice za koje nisu
-- evidentirani ni sudija ni poseta.
SELECT COUNT(*)
FROM matches_flat
WHERE referee_name IS NULL
    AND attendance IS NULL;

----------------------------------------------------------------------------------------

-- Prikažite sve utakmice odigrane između 01. i 31. Marta 2025. godine,
-- uključujući oba datuma. Rezultate sortirajte po datumu odigravanja. 

SELECT * 
FROM matches_flat
WHERE kickoff_ts >= '2025-03-01'
    AND kickoff_ts < '2025-04-01'
ORDER BY kickoff_ts, match_id;

----------------------------------------------------------------------------------------

-- Koliko je utakmica odigrano u periodu od 20. decembra 2024.
-- do 10. januara 2025. godine uključujući oba datuma.

SELECT COUNT(*)
FROM matches_flat
WHERE DATE(kickoff_ts) BETWEEN '2024-12-20' AND '2025-01-10';

----------------------------------------------------------------------------------------

-- Napravite kolonu attendance_status koja prikazuje broj gledalaca
-- ako je poseta evidentirana, a tekst Unknown ako podatak o poseti nedostaje.
-- Prikažite datum utakmice, domaći tim, gostujući tim i novu kolonu.

SELECT
    kickoff_ts, home_team, away_team,
    coalesce(CAST(attendance as string), 'Unknown') AS attendance_status
FROM matches_flat;

----------------------------------------------------------------------------------------

-- Prikažite utakmice odigrane u periodu od 01. do 30. aprila 2025. godine
-- kod kojiH je postignuto između 2 i 4 gola ukupno, uključujuću obe granice.
-- Rezultat sortirajte po datumu.

SELECT
    match_id, kickoff_ts, status,
    home_team, away_team, home_goals, away_goals,
    (home_goals + away_goals) AS total_goals
FROM matches_flat
WHERE (DATE(kickoff_ts) BETWEEN '2025-04-01' AND '2025-04-30')
    AND (home_goals + away_goals) BETWEEN 2 and 4
ORDER BY kickoff_ts, match_id;

----------------------------------------------------------------------------------------

-- Pronađite utakmice kod kojih je rezultat na poluvremenu bio nerešen
-- ali je konačni rezultat bio različit. Prikažite datume, timove, rezultat na
-- poluvremenu i konačni rezultat.

SELECT
    DATE(kickoff_ts) AS match_day, home_team, away_team,
    concat(home_goals_ht, '-', away_goals_ht) AS halftime_result,
    concat(home_goals, '-', away_goals) AS fulltime_result
FROM matches_flat
WHERE home_goals_ht = away_goals_ht
    AND home_goals <> away_goals;

----------------------------------------------------------------------------------------