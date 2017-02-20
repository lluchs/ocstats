-- output: champ | spells... | selection frequency
select
	spell.key champ,
	ifnull(sum(json_extract(spell.value, '$.SpellQ')),       0) SpellQ,
	ifnull(sum(json_extract(spell.value, '$.SpellE')),       0) SpellE,
	ifnull(sum(json_extract(spell.value, '$.SpellR')),       0) SpellR,
	ifnull(sum(json_extract(spell.value, '$.Sword')),        0) Sword,
	ifnull(sum(json_extract(spell.value, '$.SpecialSword')), 0) SpecialSword,
	ifnull(sum(json_extract(spell.value, '$.Block')),        0) Block,
	ifnull(sum(json_extract(spell.value, '$.DoubleJump')),   0) DoubleJump,
	sum(sel.value) selection
from
	games g,
	json_each(g.statistics, '$.Statistics_ChampSpellUsage') spell,
	json_each(g.statistics, '$.Statistics_ChampSelection') sel
where
	sel.key = spell.key
group by champ
