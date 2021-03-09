# CLPS0950Project
Group Project for CLPS 0950 Battleship

Battleship Project
CLPS 0950
Sam, Maya, and Grace

For our project, we coded a game of Battleship with three levels. 

There are two different places to play the game. 
GUI version: For the easy level of the game, the computer randomly places five ships on a 10x10 board. The user then aims at various coordinates on the board using the sliders along the x-axis and y-axis to see if they hit, missed, or sunk a ship. In this version of gameplay, the user has 30 shots to try to sink all five ships. The easy level can be accessed in the file “BattleshipBoard.m”. 

Command window version: The easy, medium, and hard levels of the game can be played in the command window. The easy version is the same as the GUI, but with the user entering the coordinates to fire at. In the medium and hard versions, the user places their own ships on the board and plays against the computer. A display window shows where the computer has aimed and where the user has aimed. In the hard version of the game, the computer is more methodical in guessing where the user has placed their ships. The computer keeps track of where it has successfully hit a target and aims at one of the adjacent squares. The game ends when either the computer sinks all of the user’s ships or the user sinks all of the computer’s ships. The code for these levels can be accessed by running the file “Battleship_version1.m”.

Link to video tutorial: 

Link to Work log document: https://docs.google.com/document/d/1w997U1PIv6SsHYQlf4a5lZWh-fyV1k1iM8q4dBbL-4E/edit?usp=sharing 

Work Log + Drivers of the Relevant Sections - We organized this by each function and included who coded it, who debugged it, and how many hours it took for each process. At the bottom, we explained what we did in the 12 hours and who the drivers/observers were. 
File Name 
Coder + Hours + Date
Debugger(s) + Hours + Date
Notes

File: BattleshipBoard.m
Coder + Hours + Date: Grace, March 1st (3 hours),
March 2nd (4 hours), March 4th (2 hours)
Debugger(s) + Hours + Date: Grace, March 1st (1 hour), March 2nd (2 hours)
Notes: I researched the GUI toolbox by watching tutorials online and looking up examples of code. I also worked a lot with Lakshmi to understand how the various variables in the GUI function work and are updated.

File: Battleship_version1.m
Coder + Hours + Date: Maya, March 1st-March 8th, 0 hours
Sam - March 1st (2 hours) 
Debugger(s) + Hours + Date: Maya, March 1st-March 8th, 0 hours
Notes: I (Maya) built any time for code I had to write here into the relevant functions below in the debugging component, since that’s how I tested functions.

File: GUI_playerguess.m
Coder + Hours + Date: Grace, March 5th (2 hours)
Sam, March 6th (3 hours) 
Debugger(s) + Hours + Date: Grace March 5th (2 hours)
Sam March 6th - March 8th - (3 hours) 
Notes: When I (Grace) started integrating the gameplay code with the GUI board, I had to edit some of the code so that it would be compatible with the GUI variables.

File: computereasyguess
Coder + Hours + Date: Maya, 3/1-3/3, 4 hours
Debugger(s) + Hours + Date: Maya, 3/1-3/3, 1 hour
Sam 3/1 - 1 hour 

File: computerhardguess
Coder + Hours + Date: Maya, March 2nd, 2.5 hours
Debugger(s) + Hours + Date: Maya, 0.5 hours, March 3rd

File: computesteps
Coder + Hours + Date: Maya, March 2nd-3rd, 2 hours
Debugger(s) + Hours + Date: Maya, March 3rd, 2 hours
Notes: +1 hour of pseudocode time/coming up with an efficient solution

File: hitoutcome
Coder + Hours + Date: Maya, 0.25 hours, March 2nd
Debugger(s) + Hours + Date: Maya, 0 hours

File: playerguess
Coder + Hours + Date: Maya, 2 hours, March 1st
Debugger(s) + Hours + Date: Maya, 30 minutes
Notes: Shipplacer, playershipplacer, and playerguess were all initially part of the script, so not sure the exact breakdown between them (total 5 hours coding and 1 hour debugging)

File: playershipplacer
Coder + Hours + Date: Maya, 1 hour, March 1st
Debugger(s) + Hours + Date: Maya, 0 hours
Notes: Shipplacer, playershipplacer, and playerguess were all initially part of the script, so not sure the exact breakdown between them (total 5 hours coding and 1 hour debugging)

File: shipplacer
Coder + Hours + Date: Maya, 2 hours, March 1st
Debugger(s) + Hours + Date: Maya, 30 minutes
Notes: Shipplacer, playershipplacer, and playerguess were all initially part of the script, so not sure the exact breakdown between them (total 5 hours coding and 1 hour debugging)

File: shipposnfunction
Coder + Hours + Date: Maya, 0.25 hours, March 1st
Debugger(s) + Hours + Date: Maya, 0 hours
Notes: Just had to copy some of the code that was initially part of playershipplacer + make it into a separate function

Other work: 
1) Grace: Project idea brainstorm, created the GitHub Repository, wrote ReadMe file, and filmed video tutorial (2 hours)
2) Sam/Grace/Maya: Drafting project proposal based on the group brainstorm (1 hour)

All Group Meetings
1) 3/1/21, 5-7 pm EST: Met on GatherTown for 2 hours to organize project + divide up tasks + begin working. 
Driver/observer - n/a
2) 3/4/21, 4-5 pm EST: Met on GatherTown to work on incorporation of the code running from the command window with the GUI version of the game. 
Driver - Grace
Observer - Sam/Maya
3) 3/5/21: 10-11am EST: Met on GatherTown with Professor Serre + Lakshmi to work on incorporation of the code running from the command window with the GUI version of the game. 
Driver - Grace
Observer - Sam/Maya
4) 3/6/31: 3-6:30 pm EST: Met on GatherTown to continue working on the easy GUI version of the game and make sure the board was showing up correctly. 
Driver - Grace and Sam
Observer - Maya
6) 3/8/21: 10-11 am EST: Met on GatherTown with Professor Serre + Lakshmi to continue working on the easy GUI version of the game and make sure the board was showing up correctly. 
Driver - Grace and Sam
Observer - Maya
7) 3/8/21: 6-9 pm EST: Met on GatherTown to finalize the GUI and command window versions of the game, add in the relevant text, comment out code, etc.
Driver - Grace (for adding the new text boxes), Sam (finalizing color changes + debugging), Maya (debugging command window version of the game in the main file and computesteps. 
Observer - Sam/Maya, Grace/Maya, Sam/Grace
8) 3/9/21: 12-12:30pm EST
No driver/observer because we were not coding
Wrapping up project, working on ReadMe and talking about the video
