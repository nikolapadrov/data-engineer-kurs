-- 1. Prosečan broj datih golova u poslednjih pet utakmica, uz izričit okvir prozora. 
--    Koja je najveća vrednost? Računajte samo kada prozor zaista ima pet utakmica.

with pokretni as (
    select
        match_id,
        kickoff_ts,
        avg(home_goals + away_goals) over (
            order by kickoff_ts, match_id
            rows between 4 preceding and current row
        ) as prosek_5,
        count(*) over (
            order by kickoff_ts, match_id
            rows between 4 preceding and current row
        ) as utakmica_u_prozoru
    from bootcamp.northern_star.matches
    where status = 'played'
)
select match_id, cast(kickoff_ts as date) as datum, prosek_5
from pokretni
where utakmica_u_prozoru = 5
order by prosek_5 desc
limit 1;

------------------------------------------------------------------------------------------------

-- 2. Tekući zbir datih golova svakog kluba u sezoni 2024/25:
--    ko je prvi stigao do 50 golova i kada?

with golovi_kluba as (
    select home_team_id as team_id, kickoff_ts, home_goals as golovi
    from matches
    where season = '2024/25'
        and status = 'played'

    union all

    select away_team_id, kickoff_ts, away_goals
    from matches
    where season = '2024/25'
        and status = 'played'
),  -- svi golovi kluba
zbir as (
    select
        team_id,
        kickoff_ts,
        golovi,
        sum(golovi) over (
            partition by team_id
            order by kickoff_ts
            rows between unbounded preceding and current row
        ) as ukupno_do_sad
    from golovi_kluba
),
prvi_put_50 as (
    select
        team_id,
        kickoff_ts,
        ukupno_do_sad,
        row_number() over (partition by team_id order by kickoff_ts) as redni_broj
    from zbir
    where ukupno_do_sad >= 50
)
select
    t.team_name,
    p.kickoff_ts,
    p.ukupno_do_sad
from prvi_put_50 as p
join teams as t on p.team_id = t.team_id
where p.redni_broj = 1
order by p.kickoff_ts
limit 1;

-- Kingsbridge City, 2025-01-18 (posle te utakmice ima 51 gol)

------------------------------------------------------------------------------------------------

-- 3. Za svaku domaću utakmicu izračunajte promenu posećenosti u odnosu na prethodnu
--    domaću utakmicu istog kluba u istoj sezoni. Gde je najveći pad i zašto?

with posete as (
    select
        m.match_id,
        t.team_name,
        m.season,
        kickoff_ts as date,
        s.stadium_name,
        m.attendance as poseta,
        lag(m.attendance) over (
            partition by m.home_team_id, m.season
            order by m.kickoff_ts
        ) as prethodna_poseta
    from matches as m
    join teams as t on m.home_team_id = t.team_id
    join stadiums as s on m.stadium_id = s.stadium_id
    where m.status = 'played'
)
select *, poseta - prethodna_poseta as promena
from posete
where poseta - prethodna_poseta is not null
order by promena
limit 5;

-- odigrana utakmica mach_id 1220 bez publike 