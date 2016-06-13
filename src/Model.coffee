root = exports ? window

root.Model = Model =
  byType: {}
  fieldType: {}
  
  fromDoc: (doc) ->
    index = doc._id.indexOf(":")
    return if (index == -1)
    
    type = doc._id[0...index]
    rest = doc._id[(index + 1)..-1]
    
    result = @byType[type].fromDoc(Object.assign({}, doc, _id: rest))
    return if (!result)
    
    Object.assign(result, { type: type })
  
  toDoc: (data) ->
    doc = Object.assign({}, data)
    
    type  = doc.type
    model = @byType[doc.type]
    delete doc.type
    
    doc = model.toDoc(doc)
    doc._id = type + ":" + doc._id
    
    doc
  
  createModel: (type, def) ->
    model = Object.assign(def, @Proto)
    @byType[type] = model


Model.Proto =
  fromDoc: (doc) ->
    data = Object.assign({}, doc)
    id_data = @_parseId(data._id)
    delete data._id
    Object.assign(data, id_data)
  
  toDoc: (data) ->
    doc = Object.assign({}, data)
    doc._id = @_formId(doc)
    doc
  
  _parseId: (id) ->
    remaining = id
    data = {}
    
    for term in @idFormat
      if term.word
        word = remaining.match(/^\w+/)
        word = word && word[0]
        return if (!word)
        
        data[term.word] = word
        remaining = remaining[word.length..-1]
      else
      if term.sep
        return if (!remaining.startsWith(term.sep))
        
        remaining = remaining[term.sep.length..-1]
    
    data
  
  _formId: (data) ->
    buffer = ""
    
    for term in @idFormat
      if term.word
        buffer = buffer + data[term.word]
        delete data[term.word]
      else
      if term.sep
        buffer = buffer + term.sep
    
    buffer

Model.fieldType.String =
  coerce: (input) ->
    input = input.toString
    input = input[0..5]
    input

Model.fieldType.GeoHash = # TODO
  coerce: (input) -> input.toString

Model.fieldType.Date = # TODO
  coerce: (input) -> input.toString
