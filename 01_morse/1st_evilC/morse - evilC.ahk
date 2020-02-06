#SingleInstance force
TestInput := [".- ..- - --- .... --- - -.- . -.--"
	, ".... . .-.. .--. . .-. ... / .- .-. . / .- .-- . ... --- -- ."
	, ".--- .- -. ..- .- .-. -.-- / - .-- . -. - -.-- / - .-- . -. - -.--"]

for i, morse in TestInput {
	out .= "Input: " morse "`nOutput: " Translate(morse) "`n`n"
}
msgbox % out
return

Translate(morse){
	static Lookup := BuildLookup(".- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..")
	Loop, Parse, morse, % A_Space
	{
		if (!Lookup.HasKey(A_LoopField)){
			msgbox % "Unknown morse: '" A_LoopField "'"
			return
		}
		out .= Lookup[A_LoopField]
	}
	return out
}

BuildLookup(morse){
	Lookup := {"/": " "}
	code := Asc("A")
	Loop, Parse, morse, % A_Space
	{
		Lookup[A_LoopField] := Chr(code)
		code++
	}
	return Lookup
}