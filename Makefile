# Statistics from OC games!

SHELL = /bin/bash

SQLITE_INPUT = <(sqlite3 -separator " " statistics.sqlite $(SQL))

statistics.sqlite:
	curl 'http://league.openclonk.org/statistics.sqlite' -o $@

knüppeln-champs.svg : SQL = "select json_each.key champ, sum(json_each.value) from games g, json_each(g.statistics, '$$.Statistics_ChampSelection') group by champ;"
knüppeln-champs.svg: statistics.sqlite knüppeln-champs.gpi
	gnuplot -d knüppeln-champs.gpi 5< $(SQLITE_INPUT)
