Express = require 'express'
Nedb = require 'nedb'
Fs = require 'fs'
RootPath = require 'app-root-path'

Config =
	modelserver:
		dbfile: "#{RootPath}/models.ndjson"
		port: 3002

db = new Nedb(
	filename: Config.modelserver.dbfile
)
app = new Express()
app.set('views', "#{RootPath}/views")
app.set('view engine', 'pug')
app.get '/zip/*', (req, res) ->
	console.log req.path
	rs = Fs.createReadStream RootPath + '/zip/' + req.params[0]
	rs.pipe res
app.get '/json', (req, res) ->
	db.find {}, (err, docs) ->
		res.header 'content-type', 'application/json'
		res.send JSON.stringify(docs, null, 2)
app.get '/', (req, res) ->
	db.find {}, (err, docs) ->
		res.render 'model-list', models: docs

console.log "Loading db from #{Config.modelserver.dbfile}"
db.loadDatabase ->
	console.log "Loaded db"
	console.log "Starting server"
	app.listen Config.modelserver.port, (err) ->
		console.log "Listening on port #{Config.modelserver.port}"
