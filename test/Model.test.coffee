require 'should'

{Model} = require '../src/Model'

Model.createModel "place",
  idFormat: [{ word: "geohash" }, { sep: "-" }, { word: "date" }]
  
  fields:
    geohash: Model.fieldType.Geohash
    date:    Model.fieldType.Date
    name:    Model.fieldType.String
    notes:   Model.fieldType.String

describe 'Model', ->
  placeDoc = ->
    _id:   "place:c29mkp92y2wf-20160816"
    _rev:  "1-A6157A5EA545C99B00FF904EEF05FD9F"
    name:  "Mt Baker"
    notes: "On a ridge near the summit."
  
  placeData = ->
    _rev:    "1-A6157A5EA545C99B00FF904EEF05FD9F"
    type:    "place"
    geohash: "c29mkp92y2wf"
    date:    "20160816"
    name:    "Mt Baker"
    notes:   "On a ridge near the summit."
  
  it 'converts a place fromDoc to data', ->
    Model.fromDoc(placeDoc()).should.eql placeData()
  
  it 'converts a place from data toDoc', ->
    Model.toDoc(placeData()).should.eql placeDoc()
  
  it 'fromDoc does not mutate the argument', ->
    arg = placeDoc()
    Model.fromDoc(arg)
    arg.should.eql placeDoc()
  
  it 'toDoc does not mutate the argument', ->
    arg = placeData()
    Model.toDoc(arg)
    arg.should.eql placeData()
