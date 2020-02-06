Global morseDictionary := {".-": "A", "-...": "B", "-.-.": "C", "-..": "D", ".": "E", "..-.": "F", "--.": "G", "....": "H", "..": "I", ".---": "J", "-.-": "K", ".-..": "L", "--": "M", "-.": "N", "---": "O", ".--.": "P", "--.-": "Q", ".-.": "R", "...": "S", "-": "T", "..-": "U", "...-": "V", ".--": "W", "-..-": "X", "-.--": "Y", "--..": "Z", "/": " "}

MsgBox % decodeMorse(".- ..- - --- .... --- - -.- . -.--")
MsgBox % decodeMorse(".... . .-.. .--. . .-. ... / .- .-. . / .- .-- . ... --- -- .")
MsgBox % decodeMorse(".--- .- -. ..- .- .-. -.-- / - .-- . -. - -.-- / - .-- . -. - -.--")
ExitApp

decodeMorse(morseCode) {
	morsels := StrSplit(Trim(morseCode), " ")
	result := ""
	for index, morsel in morsels {
		if (morsel = "")
			continue
		result .= morseDictionary.HasKey(morsel) ? morseDictionary[morsel] : "?"
	}
	return result
}
