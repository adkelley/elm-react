SOURCE  = ./

## install grunt modules
grunt:
	npm install --save grunt
	npm install --save grunt-contrib-clean
	npm install --save grunt-contrib-watch
	npm install --save grunt-elm


compile:
	elm-make Main.elm


## Save to github

deploy:
	git add .
	git commit -m $2
	git push origin master
