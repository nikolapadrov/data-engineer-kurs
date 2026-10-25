-- 1. Zadatak
-- Koliko redova ima spoj matches i player_match_stats za sezonu 2024/25? Objasnite.

select 
    count(*) as total
from matches m
join player_match_stats pms 
    on m.match_id = pms.match_id 
where season = '2024/25';

-- Upit vraća 15200 redova. 
-- Pre spajanja tabela: 
--     match = 761 red
--     player_match_stats = 30440 redova 
-- U player_match_stats imamo statistiku za svakog igraca po jednom meču, pa je to 20 istih match_id sa različitim player_id.
-- Tj. 761 X 20 = 30440 
-- Upit posle filtera po sezoni vraća 380 utakmica pomnozeno sa 40 igraca = 15200 redova.

------------------------------------------------------------------------------------------------------------------------------

-- 2. Zadatak 
-- Koliko puta je igrač u istoj sezoni igrao za dva različita kluba?

select * from matches;
select * from player_match_stats;

with player_clubs as (
select
    m.season as sezona,
    pms.player_id as igrac,
    count(distinct pms.team_id) as timovi
from player_match_stats pms
join matches m ON pms.match_id = m.match_id
group by season, player_id
having count(distinct pms.team_id) >= 2
)
select
    sezona,
    count(distinct igrac) as igraci
from player_clubs
group by sezona;    

------------------------------------------------------------------------------------------------------------------------------

-- 3. Zadatak 
-- Koliko utakmica ima više kartona od prosečne utakmice? 
-- Bez kartona računajte sa 0.

with match_cards as (
    select
        m.match_id,
        count(me.event_id) as total_cards
    from matches m
    left join match_events me on m.match_id = me.match_id
        and me.event_type in ('yellow_card', 'second_yellow', 'red_card')
    group by m.match_id
    order by total_cards desc
)
select
    count(*) as total_matches
from match_cards
where total_cards > (select avg(total_cards) from match_cards);

------------------------------------------------------------------------------------------------------------------------------

-- 4. Zadatak
-- Koliko igrača je odigralo više od 10 utakmica u sezoni 2024/25?

with active_player_maches AS (
select
    pms.player_id,
    count(*) as total_matches
from player_match_stats pms
join matches m on pms.match_id = m.match_id
where m.season = '2024/25'
    and pms.minutes_played > 0
group by pms.player_id
having total_matches > 10
order by total_matches desc
)
select
    count(*) as total_players
from active_player_maches;

------------------------------------------------------------------------------------------------------------------------------

-- 5. Zadatak
-- Prikažite sve klubove koji su igrali u sezoni 2024/25, bilo kao domaćini ili kao gosti. 
-- Koristite UNION, a zatim izmenite upit
-- tako da koristi UNION ALL. 
-- Objasnite razliku u broju redova koji dobijate.

select t.team_name as domaci_tim
from matches AS m
join teams AS t
    ON m.home_team_id = t.team_id
where m.season = '2024/25'

UNION

select t.team_name as gostujuci_tim
from matches AS m
join teams AS t
    ON m.away_team_id = t.team_id
where m.season = '2024/25';

--------------------------------------

select t.team_name as domaci_tim
from matches AS m
join teams AS t
    ON m.home_team_id = t.team_id
where m.season = '2024/25'

UNION ALL

select t.team_name as gostujuci_tim
from matches AS m
join teams AS t
    ON m.away_team_id = t.team_id
where m.season = '2024/25';


-- Union je spojio tabele i izbacio duplikate, 
-- Union all prikazuje sve 380 redova prvi upit + 380 redova drugi upit = 760 redova.

------------------------------------------------------------------------------------------------------------------------------