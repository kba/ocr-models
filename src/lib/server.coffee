Express = require 'express'
Nedb = require 'nedb'
Fs = require 'fs'
RootPath = require 'app-root-path'

console.log filename: "#{RootPath}/models.ndjson"
db = new Nedb(
	filename: "#{RootPath}/models.ndjson"
)
app = new Express()
app.set('views', "#{RootPath}/views")
app.set('view engine', 'pug')
app.get '/zip/*', (req, res) ->
	rs = Fs.createReadStream RootPath + '/zip/' + req.params[0]
	rs.pipe res
app.get '/json', (req, res) ->
	db.find {}, (err, docs) ->
		res.header 'content-type', 'application/json'
		res.send JSON.stringify(docs, null, 2)
app.get '/', (req, res) ->
	db.find {}, (err, docs) ->
		res.render 'model-list', models: docs
db.loadDatabase ->
	app.listen 3002
