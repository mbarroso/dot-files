String st = "<html><head></head><body onload=\"pepeepe\"></body></html>"

def f = { s ->
	s.collect({c -> 
		if(c=="\"")
			return "\u005c\u005c\u005c\u0022"
		else
			return c
		}).join()
	}
println "'"+st.replaceAll(/"/,"\u005c\u005c\u005c\u0022")+"'"
println "\u005c\u005c\u005c\u0022"

println f(st).join()
