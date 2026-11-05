-- 1. dim_player iz tabele players

create or replace table bootcamp.sandbox.dim_player as
select 
    player_id, 
    first_name, 
    last_name, 
    position, 
    nationality
from bootcamp.northern_star.players;
-- select count(*) from bootcamp.sandbox.fact_player_match;
-- 30400 redova (760 odigranih utakmica × 40 igrača)

----------------------------------------------------------------------------------------------------------------------

-- 2. dim_date (date_key) i fact_player_match tabela

create or replace table bootcamp.sandbox.fact_player_match as
select
    s.match_id,
    cast(date_format(m.kickoff_ts, 'yyyyMMdd') as int) as date_key,
    s.player_id,
    s.team_id,
    s.minutes_played,
    s.shots,
    s.passes,
    s.rating
from bootcamp.northern_star.player_match_stats as s
join bootcamp.northern_star.matches as m on s.match_id = m.match_id
where m.status = 'played';

select count(*) from bootcamp.sandbox.fact_player_match;
-- 30400 redova (760 odigranih utakmica × 40 igrača)

----------------------------------------------------------------------------------------------------------------------

-- 3. Prosečna ocena po poziciji igrača 2024/25

select
    p.position,
    round(avg(f.rating), 2) as prosecna_ocena
from bootcamp.sandbox.fact_player_match as f
join bootcamp.sandbox.dim_player as p on f.player_id = p.player_id
join bootcamp.sandbox.dim_date as d on f.date_key = d.date_key
where d.season = '2024/25'
group by p.position
order by prosecna_ocena desc;

-- FW 6.79 | MF 6.72 | DF 6.64 | GK 6.60

----------------------------------------------------------------------------------------------------------------------

-- 4. Dodavanje kolone u fact_player_match, setovanje na 0, upisivanje golova iz match_events('goals','penalty_goals')

alter table bootcamp.sandbox.fact_player_match add columns (goals int);

update bootcamp.sandbox.fact_player_match set goals = 0;

merge into bootcamp.sandbox.fact_player_match as f
using (
    select match_id, player_id, count(*) as golovi
    from bootcamp.northern_star.match_events
    where event_type in ('goal', 'penalty_goal')
    group by match_id, player_id
) as g
on f.match_id = g.match_id
   and f.player_id = g.player_id
when matched then
    update set f.goals = g.golovi;

-- select count(*), sum(goals) as total_goals from bootcamp.sandbox.fact_player_match;
-- 30400 | 2043   