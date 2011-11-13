#!/bin/groovy
def start = System.currentTimeMillis()
def output = "ifconfig".execute().text
def i = 0
for(def p in (output =~ /\d+\.\d+\.\d+\.\d+/)){
	println "$p en ${i++}"
}
println System.currentTimeMillis()-start
