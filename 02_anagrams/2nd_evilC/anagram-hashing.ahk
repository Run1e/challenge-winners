; Submission by: evilC
#SingleInstance force
Process, Priority, , R
dict := {}
SplashTextOn , , , Loading...
FileRead, wordList, words.txt
words := StrSplit(wordList, "`r`n")

; Build dictionary with key as hash of letters/counts used, and value of an array of matching words
/*
	Dictionary format:
	{
		a1e1p1r1s2: ["SPEARS", "SPARES", "ASPERS", "PARSES", "..."]
	}
*/
for i, word in words {
	hash := WordToHash(word)
	if (!dict.HasKey(hash)){
		dict[hash] := []
	}
	dict[hash].Push(word)
}
SplashTextOff
Process, Priority, , N

Gui, Add, Text, , Word to find:
Gui, Add, Edit, x+5 yp-2 w100 gWordChanged vNewWord
Gui, Add, Text, xm, Matches
Gui, Add, Text, x+10 yp w50 vMatchCount, (0)
Gui, Add, Edit, xm w200 R10 vMatches
Gui, Show,, Anagram Finder

return

GuiClose:
	ExitApp

WordChanged:
	Gui, Submit, NoHide
	str := ""
	; Find hash of submitted word
	hash := WordToHash(NewWord)
	; Is this hash in the dictionary?
	words := dict[hash]
	; Build results output
	max := words.Length()
	matchCount := 0
	Loop % max {
		if (words[A_Index] = NewWord)
			continue
		matchCount++
		str .= words[A_Index]
		if (A_Index != max)
			str .= "`n"
	}
	GuiControl, , Matches, % str
	GuiControl, , MatchCount, % "(" matchCount ")"
	return

WordToHash(word){
	arr := {}
	; Build array of letters used and the count of times they occur
	Loop, parse, word
	{
		if (!arr.HasKey(A_LoopField)){
			arr[A_LoopField] := 1
		} else {
			arr[A_LoopField]++
		}
	}
	; Build "hash" of letters (In alpha order), plus times used
	for letter, count in arr {
		str .= letter count
	}
	return str
}