;;                load("d:\\skill\\rename.il")

procedure( addComp(sname @optional (count 1)) 
	prog( (maxIndex lit number startSymbol startIndex)
		axlSetFindFilter(?enabled '("noall" "components") ?onButtons '(all))

		rexCompile( "\\([a-zA-Z]+\\)\\([0-9]+\\)" )
		rexExecute( sname )
		startSymbol = upperCase(rexSubstitute("\\1"))
		startIndex = atoi( rexSubstitute("\\2") ) + 1
		
		axlAddSelectAll()
		
		maxIndex = startIndex
		foreach( x axlGetSelSet() 
			rexCompile( "\\([a-zA-Z]+\\)\\([0-9]+\\)" )
			rexExecute( x->name )
			lit = rexSubstitute("\\1")
			when( lit == startSymbol 
				number = atoi( rexSubstitute("\\2") )
				when( number > maxIndex
					maxIndex = number
				)	
			)
		)
		
		
		for( i startIndex maxIndex 
			;println(concat(concat(startSymbol maxIndex - i + startIndex) "-" concat(startSymbol maxIndex - i + startIndex + count)))
			unless( axlSelectByName( "COMPONENT" concat(startSymbol maxIndex - i + startIndex)) == nil
				axlRenameRefdes(concat(startSymbol maxIndex - i + startIndex) concat(startSymbol maxIndex - i + startIndex + count))
			)
		)
		
		axlClearSelSet()
		
		println(concat( "Components renamed: " startSymbol startIndex "-" startSymbol maxIndex))
	)
)

;;    load("d:\\skill\\rename.il")  deleteComp "C87" 

procedure( deleteComp(sname @optional (count 1)) )
	prog( (maxIndex count lit number startSymbol startIndex)
		when( axlSelectByName( "COMPONENT" sname ) == nil
			println(concat("Error! Component " sname " not found!"))
			return(nil)
		)
		
		axlClearSelSet()
		
		axlSetFindFilter(?enabled '("noall" "components") ?onButtons '(all))

		rexCompile( "\\([a-zA-Z]+\\)\\([0-9]+\\)" )
		rexExecute( sname )
		startSymbol = upperCase(rexSubstitute("\\1"))
		startIndex = atoi( rexSubstitute("\\2") ) + 1
		
		axlAddSelectAll()
		
		maxIndex = startIndex
		foreach( x axlGetSelSet() 
			rexCompile( "\\([a-zA-Z]+\\)\\([0-9]+\\)" )
			rexExecute( x->name )
			lit = rexSubstitute("\\1")
			when( lit == startSymbol 
				number = atoi( rexSubstitute("\\2") )
				when( number > maxIndex
					maxIndex = number
				)	
			)
		)
		
		for( i startIndex startIndex + count - 1
			axlRenameRefdes(concat(startSymbol i) concat("DELETED" i - 1))
		)
		
		for(i startIndex maxIndex 
			;println(concat(concat(startSymbol i) "-" concat( startSymbol i - 1 )))
			axlRenameRefdes(concat(startSymbol i) concat( startSymbol i - count ))
		)

		axlClearSelSet()
		
		;axlDeleteObject( axlSelectByName("COMPONENT" "TEMP123") )
		
		println(concat( "Components renamed: " startSymbol startIndex "-" startSymbol maxIndex))
	)
)
