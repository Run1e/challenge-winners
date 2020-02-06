tests := [".- ..- - --- .... --- - -.- . -.--"
, ".... . .-.. .--. . .-. ... / .- .-. . / .- .-- . ... --- -- ."
, ".--- .- -. ..- .- .-. -.-- / - .-- . -. - -.-- / - .-- . -. - -.--"]
For each, morseCode in tests
	Msgbox % Morse.decode(morseCode)

;class container boilerplate for potential encode operation
class Morse {
	
	static morseCharacters := { ".-": "A" ;add more letters if needed here
	, "-...": "B"
	, "-.-.": "C"
	, "-..": "D"
	, ".": "E"
	, "..-.": "F"
	, "--.": "G"
	, "....": "H"
	, "..": "I"
	, ".---": "J"
	, "-.-": "K"
	, ".-..": "L"
	, "--": "M"
	, "-.": "N"
	, "---": "O"
	, ".--.": "P"
	, "--.-": "Q"
	, ".-.": "R"
	, "...": "S"
	, "-": "T"
	, "..-": "U"
	, "...-": "V"
	, ".--": "W"
	, "-..-": "X"
	, "-.--": "Y"
	, "--..": "Z"
	, "/": " "} ;treat word seperator as the code for space
	
	decode(byref morseString) { ;byref for performance
		
		for each, character in strSplit(morseString, " ") ;alternatively use Loop, Parse for performance
			output .= this.morseCharacters[character] ;perform one key lookup per letter
		return output
	}
}