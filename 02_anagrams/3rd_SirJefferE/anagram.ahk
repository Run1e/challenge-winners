FileRead, wordList, words.txt
Loop {
InputBox, input, Anagram Solver, Please enter an anagram:,, 250, 125
if (errorLevel)
    ExitApp
StringLower, input, input
anagrams := ""
RegExMatch(wordList, "m)^[" input "]{" StrLen(input) "}$(?CcheckMatch)")
if (anagrams)
    msgbox,4, Anagrams found!, Found anagrams:%anagrams%. Try again?
else
    msgbox,4, Anagrams not found!, No anagrams found. Try again?
IfMsgBox, No
    ExitApp
}
 
sortString(string)
{
loop, parse, string
    sortString .= A_Loopfield "|"
Sort, sortString, D|
Return %sortString%
}

checkMatch(match)
{
    global
    if (match != input and sortString(match) = sortString(input))
        anagrams .= " " match
    Return 1
}