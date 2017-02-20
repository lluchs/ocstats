-- output: name of champ | selection count
select
	json_each.key champ, sum(json_each.value)
from
	games g, json_each(g.statistics, '$.Statistics_ChampSelection')
group by champ
