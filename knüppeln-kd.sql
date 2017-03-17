-- output: champ | kills | deaths | selection
select
	kd.key champ,
	sum(json_extract(kd.value, '$[0]')) kills,
	sum(json_extract(kd.value, '$[1]')) deaths,
	sum(sel.value) selection
from
	games g,
	json_each(g.statistics, '$.Statistics_ChampKillsDeaths') kd,
	json_each(g.statistics, '$.Statistics_ChampSelection') sel
where
	sel.key = kd.key
group by champ
