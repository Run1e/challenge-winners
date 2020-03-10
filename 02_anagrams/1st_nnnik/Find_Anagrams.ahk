
SetBatchLines, -1 ;performance reasons


testDictionary := AnagramDictionary.loadFromFile("words.txt") ;load dictionary from file
Loop {
	InputBox, word, Anagram Finder, Input word you want to find the anagrams of
	if !word
		ExitApp
	s := "Anagrams for " . word ":`n"
	testResults := testDictionary.getAnagrams(word)
	for each, anagram in testResults {
		s .= anagram "`n"
	}
	Msgbox % RTrim(s)
}

class AnagramDictionary {
	
	entries := {}
	
	;add an entry to the dictionary
	addEntry(word) {
		if RegExMatch(word, "S)(*UCP)\s")
			throw exception("Word shouldn't contain whitespace", -1, "Word " word " shouldnt contain whitespace")
		keyWord := this.__generateKey(word)    ;generate lookup key
		if this.entries.hasKey(keyWord) {      ;if there are already entries for this type of anagram
			anagrams := this.entries[keyWord] ;use existing array
			for each, entry in anagrams       ;scan existing array for duplicates
				if (word = entry)
					throw exception("Word already added to dictionary", -1, "Word " word " already in dictionary")
		} else {                               ;if theres is no entries for this type of anagram generate new array
			anagrams := this.entries[keyWord] := []
		}
		anagrams.push(word)                    ;add word to the array
	}
	
	getAnagrams(word) {
		if RegExMatch(word, "S)(*UCP)\s")
			throw exception("Word shouldn't contain whitespace", -1, "Word " word " shouldnt contain whitespace")
		keyWord := this.__generateKey(word)    ;generate lookup key
		output := []                           ;create an array to store the output in
		if this.entries.hasKey(keyWord)        ;if there are any entries in the entries list
			for each, anagram in this.entries[keyWord] ;for each entry
				if (anagram != word)         ;if it isnt the word we are looking for
					output.push(anagram)    ;add the entry to the output section
		return output                          ;return results
	}
	
	;generates a key from a word that orders all of the characters in the Key
	;that key uniquely identifies all words that share the same letters regardless of order
	__generateKey(byref word) {
		characters := {}                                        ;array to store the characters in
		position := 1                                           ;starting at the beginning of the word
		while nextChar := chr(ord(SubStr(word, position, 2))) { ;take the first character (rather than the first code point which Loop, Parse or strSplit would do)
			position += StrLen(nextChar)                       ;increase the position we read the string from by the amount of codepoints that the character contains
			characters[nextChar] := characters.hasKey(nextChar) ? characters[nextChar] + 1 : 1 ;add character to the character array and use character as key
		 	                                                   ;if a character appears more than once increase the keyCounter
		}
		keyWord := ""                      ;the final output string
		for character, count in characters ;enumerate all the characters that we collected previously
			                              ;this is an implicitly sorted operation so the characters are sorted now
			keyWord .= character . count
		return keyWord
	}
	
	
	;loads a dictionary as a list of words from a file
	loadFromFile(fileName) {
		if !FileExist(fileName) {
			throw Exception("File not found", -1, "File " . fileName . " couldn't be found")
		}
		if !file := FileOpen(fileName, "r") {
			throw Exception("Couldn't open file for reading", -1, "File " . fileName . " couldn't be opened" )
		}
		text := file.read() ;empty file means empty dictionary... no error per se
		dictionary := new this()
		Loop, Parse, text, `n, `r
		{
			try {
				errorLine := exception(""), dictionary.addEntry(A_LoopField)
			} catch e {
				if (e.line = errorLine.line) && (e.file == errorLine.file) ;if dictionary blames this function
					throw exception("Error parsing file: " . e.Message, -1, "At Line " . A_Index . ": " e.Extra) ;propagate blame to caller
				else
					throw e ;unexpected error - handle normally
			}
		}
		return dictionary
	}
	
}