root = exports ? window

PouchDB =      require 'pouchdb'
PouchDB.plugin require 'pouchdb-authentication'

root.Session = class Session
  constructor: ->
    @db = new PouchDB 'forages', skipSetup: true
