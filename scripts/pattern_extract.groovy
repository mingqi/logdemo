import java.util.regex.Matcher
import java.util.regex.Pattern

_value = _source.message

//_value = "RemoteClientBase._request(),DaoDaoTourismService,2 <main>"
//regexp = "RemoteClientBase[.]_request[(][)],(\\w+),"

p = Pattern.compile(pattern)
m = p.matcher(_value)
if(m.find() && m.groupCount() > 0){
	value = m.group('value')
	if(value.isLong()){
		return value.toLong()
	} else if(value.isFloat()){
		return value.toFloat()
	}else{
		return value
	}
}else{
	return null
}
