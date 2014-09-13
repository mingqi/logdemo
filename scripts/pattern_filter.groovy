import java.util.regex.Matcher
import java.util.regex.Pattern

_value = _source.message

//_value = "RemoteClientBase._request(),DaoDaoTourismService,2 <main>"
//regexp = "RemoteClientBase[.]_request[(][)],(\\w+),"

p = Pattern.compile(pattern)
m = p.matcher(_value)
return m.find()