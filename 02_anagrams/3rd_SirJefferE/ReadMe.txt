Input: Inputbox.
Output: Msgbox.

This solution uses Regular Expression Callouts to run the checkMatch(match) function on every potential match in the word list. A potential match is a word that is the same length as the user input, and is comprised of characters contained within it. Note that "marble" and "barrel" are considered potential matches, so additional comparison is required within the checkMatch() function.

checkMatch() compares the potential match with the user input to ensue that they're not the same word, and then sorts the strings alphabetically using sortString() to test if they contain the same number of each character. Any matches are added to the "anagrams" string. The function returns 1 ("not a match") to RegExMatch regardless of outcome, as we've already done everything we need to do with the potential match, and we want to continue searching without having to loop RegExMatch.

~SirJefferE