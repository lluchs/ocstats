# Statistics from OC games!

SHELL = /bin/bash

GRAPHS := knüppeln-champs.svg

statistics.sqlite:
	curl 'http://league.openclonk.org/statistics.sqlite' -o $@

knüppeln-champs.svg: statistics.sqlite knüppeln-champs.gpi knüppeln-champs.sql
	gnuplot -d knüppeln-champs.gpi

# Deployment to gh-pages
gh-pages:
	git clone -b gh-pages `git remote get-url origin` gh-pages

deploy: gh-pages $(GRAPHS)
	cp $(GRAPHS) gh-pages
	git -C gh-pages add -A
	git -C gh-pages commit -m 'Update graphs'
	git -C gh-pages push origin gh-pages

.PHONY: deploy
