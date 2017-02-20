# Statistics from OC games!

GRAPHS := knüppeln-champs.svg knüppeln-kd.svg

all: $(GRAPHS)

statistics.sqlite:
	curl 'http://league.openclonk.org/statistics.sqlite' -o $@

%.svg: %.gpi %.sql statistics.sqlite
	gnuplot -d $<

# Deployment to gh-pages
gh-pages:
	git clone -b gh-pages `git remote get-url origin` gh-pages

deploy: gh-pages $(GRAPHS)
	cp $(GRAPHS) gh-pages
	git -C gh-pages add -A
	git -C gh-pages commit -m 'Update graphs'
	git -C gh-pages push origin gh-pages

clean:
	rm -f $(GRAPHS) statistics.sqlite

.PHONY: all, deploy, clean
