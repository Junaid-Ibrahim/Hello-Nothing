# CP means Current Project
now-this() {
	export CP=$(pwd)
}

targets-rb() {
	test $(pwd) = $CP/build/artifacts || cd $CP/build/artifacts
	cat $CP/../.if-targets.ninja > .f-targets.ninja
	: > .i-targets.ninja
	
	for i in $(find $CP/code/res -type f | grep values)
	do 
		o=$( echo $i | tr / _  | sed 's/.*_code_res_//;s/xml$/arsc.flat/' )
		i=$( echo $i | sed 's_.*code_$c_' )
		echo "build ${o} : flatten ${i}" >> .i-targets.ninja
		sed -i "4s+\$+ ${o}+" .f-targets.ninja 
	done
	
	for i in $(find $CP/code/res -type f | grep -v values)
	do 
		o=$( echo $i | tr / _  | sed 's/.*_code_res_//;s/$/.flat/' )
		i=$( echo $i | sed 's_.*code_$c_' )
		echo "build ${o} : flatten ${i}" >> .i-targets.ninja
		sed -i "4s+\$+ ${o}+" .f-targets.ninja 
	done
	printf '\n' >> .i-targets.ninja

	sed -i "4s+\$+ |+" .f-targets.ninja
	for i in $(find $CP/code/assets -type f)
	do 
		i=$( echo $i | sed 's_.*code_$c_' )
		sed -i "4s+\$+ ${i}+" .f-targets.ninja 
	done

	source $CP/.vars.ninja
	
	for i in $(find $CP/code/java/${n} -type f)
	do 
		o=$( echo $i | sed "s_.*/code/java/__;s_java\$__" )
		i=$( echo $i | sed 's_.*code_$c_' )
		echo "build ${o}class : i-class ${i}" >> .i-targets.ninja
		echo "build ${o%.}/classes.dex : i-dex ${o}class" >> .i-targets.ninja
		sed -i "2s+\$+ ${o%.}/classes.dex+" .f-targets.ninja 
	done
	printf '\n' >> .i-targets.ninja

	cat .i-targets.ninja .f-targets.ninja > .targets.ninja
	ninja-rb
}

ninja-rb() {
	test $(pwd) = $CP/build/artifacts || cd $CP/build/artifacts
	cat $CP/../.vars.ninja $CP/.vars.ninja $CP/../.rules.ninja .targets.ninja > build.ninja
	apk-rb
}

apk-rb() {
	test $(pwd) = $CP/build/artifacts || cd $CP/build/artifacts
	samu 
	cd - > /dev/null
	cp $CP/build/artifacts/${nn}.apk /storage/emulated/0/.
}
