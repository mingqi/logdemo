
pattern = ( pattern_str ) ->
  ESCAPE = ['\\','[',']','.', '^','$', '|', '?', '*', '+', '(', ')', '{', '}']

  escape = (str) ->
    for e in ESCAPE
      str = str.replace(e, "\\#{e}")

    return str
      
  parse = (statment) ->

    _p = /%(\w+)%/g

    _attrs = while _r = _p.exec statment
      _r[1] 

    return {

      attributes : _attrs

      toExtract :  (attribute) ->
        _r = escape(statment).replace("%#{attribute}%", "(?<value>\\w+)")
        _r.replace(_p, '\\w+') 

      toFilter : () ->
        escape(statment).replace(_p, '\\w+')
    }

  terms = []
  parses = []
  for statment in pattern_str.split('|')
    statment = statment.trim()
    if statment.indexOf('parse') == 0
      # this is attribute parse
      parses.push parse(statment.substring(5).trim())
    else
      terms = terms.concat statment.split(/\s+/)

  query = 
    'bool' :
      'must' : for term in terms 
        'multi_match' : 
          'query' : term
          'fields' : ['_all'] 
  
  return {

    query : query

    parses : parses

    applyFilter :  (attribute, value) ->
      pattern(pattern_str.replace("%#{attribute}%", value) )
  }
