File f = new File("down.sh")
for(i in 1..25){
	println "bajando $i... en ${args[0]}"
	f.append("wget ${args[0]}${i}.jpg\n")
}
