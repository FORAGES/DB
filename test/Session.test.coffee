require 'should'

{Session} = require '../src/Session'

describe 'Session instance', ->
  it 'should have a db', ->
    session = new Session
    session.db.should.be.ok
