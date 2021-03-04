% %functions that are in this folder that are actually being used in this
% %version of the code
% 1) shipplacer - generated position of ships randomly on board
% 2) player guess - runs the code when the player wants to guess
% 3) playershipplacer - allows player to place their ships, and shipposn
%       function is used within this
% 4) computer easy guess - easy level computer guessing pattern (totally random)

function []= Battleship ();

disp('Welcome to Battleship');
difficulty = input ('Choose your difficulty: 1=easy, 2=medium, 3=hard');
if difficulty ~= 1 || difficulty ~= 2 || difficulty ~= 3
    disp('This is not a valid difficulty. Please try again.');
    difficulty = input ('Choose your difficulty: 1=easy, 2=medium, 3=hard');
end    
   
%initializing the ships and the ship lengths
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];


[X,Y]=meshgrid(0:10);
mesh(X,Y)
view(2)
%% ONE PLAYER - player guesses randomly generated board by computer

%game set up - creates a board, makes a player choose valid number of
%rounds for game play

board = shipplacer(shiplist, shiplength);
valid_rounds = false; 
while valid_rounds == false;
    totalrounds = input('How many guesses do you want to have? (17+)');
    if totalrounds > 17
        valid_rounds = true;
        break;
    else
        disp('Invalid number of guesses');
    end  
end

%generates an image of the player guesses + sets up guesser function
sqr = ones(10, 10);
playerguesses = cat(3, sqr, sqr, sqr);
sink_count = 0;
winner = false;
current_rounds = 1;

% while player is playing, allows guesses to be checked against the
% computers randomly generated board. 
while current_rounds <= totalrounds
    [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count);
    subplot(1,2,2)
    x = 1;
    y = current_rounds;
    bar(x,y,'r')
    title('Turns Used')
    current_rounds = current_rounds + 1;
end

disp('You used up all your turns! Try again next time!')
%% Two player game play - computer in easy level guessing

%This code allows the player to set up the game by typing input coordinates.
%Then, it generates the computer's board. 
disp('Start by placing your ships on the 10 by 10 grid');
disp('All ships are placed to the right and down from the input coordinate.');

ships = [" Carrier", " Battleship", " Cruiser", " Submarine", " Destroyer"];
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];

global playergrid
[playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength);
board = shipplacer(shiplist, shiplength); 

%computer and player take turns guessing spaces. 
sqr = ones(10, 10);
global playerguesses
playerguesses = cat(3, sqr, sqr, sqr);
sink_count = 0;
winner = false;
comp_sink_count = 0;

while winner == false
   [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count);
   if winner == true
       break;
   end
   disp('Time for the computer to guess');
   [playerboard, playergrid, winner, comp_sink_count] = computereasyguess(playerboard, winner, comp_sink_count);
end
%% two player - hard
disp('Start by placing your ships on the 10 by 10 grid');
disp('All ships are placed to the right and down from the input coordinate.');

ships = [" Carrier", " Battleship", " Cruiser", " Submarine", " Destroyer"];
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];

global playergrid
[playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength);
board = shipplacer(shiplist, shiplength); 

%computer and player take turns guessing spaces. 
sqr = ones(10, 10);
global playerguesses
global nextsteps
global count_nextsteps

playerguesses = cat(3, sqr, sqr, sqr);
sink_count = 0;
winner = false;
comp_sink_count = 0;
nextsteps = [];
count_nextsteps = 0;

while winner == false
   [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count);
   if winner == true
       break;
   end
   disp('Time for the computer to guess');
   [playerboard, winner, comp_sink_count] = computesteps(playerboard, winner, comp_sink_count);
end

