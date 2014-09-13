ESCAPE = ['[',']','.','\\', '^', '$', '|', '?', '*', '+', '(', ')', '{', '}']

parse = (pattern) ->
  # pattern is like: call db spend %dbtime%ms
  p = /%([^%]+)%/ 

  attrs = while m = p.exec(pattern) 
    m[1]

  if attrs.length == 0
    throw new Error("not found attributes in pattern")
   
  return {

    attributes : attrs

    toFilter : (attr) ->
      # ...
    
    toExtractor : (attr) ->
      # ...

    fill : (attr, value) ->
      # ...
     
  }
