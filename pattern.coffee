ESCAPE = ['[',']','.','\\', '^', '$', '|', '?', '*', '+', '(', ')', '{', '}']

attribute = () ->

  return {

    name : "xxx"

    toBucket :  () ->


    toMetrics : () ->
      # ...
    
  }

parse = (pattern) ->
  ## pattern is "key_search | search"

  querys = []
  parses = []
  for statment in pattern.split('|')
    statment = statment.trim()
    if statment.indexOf('parse') == 0
      # this is attribute parse
      parses.push parse(statment)
    else
      querys.push statment

  # attrs = while m = p.exec(pattern) 
  #   m[1]
  
  return {

    query : {
      match : "" 
    }

    filter : {
      and : {

      }
    }

    parse : [

    ]
  }

  return {

    attributes : attrs

    toFilter : (attr) ->
      # ...
    
    toExtractor : (attr) ->
      # ...

    fill : (attr, value) ->
      # ...
     
  }
