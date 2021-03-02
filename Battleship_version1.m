% things remaining in this L1 functionality level
% 1) telling them which ships they were able to hit or sink - DONE
% 2) showing the actual image to the player of a grid
% 3) the grid should be different colors depending on if it was a
% hit/miss/sink - DONE

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


%% One player version of the game
% the code within this next for loop allows the computer to randomly
% generate the positions of the ship on the game board matrix, named board.
% turned all the code in the previous for loop into a function
%   called shipplacer. we should be able to replace this wiht a call to
%   that function. that function can also be used for two player versions.

board = shipplacer(shiplist, shiplength);
%this is where the game actually starts. 
%the user is prompted to enter a number of guesses. 

totalrounds = input('How many guesses do you want to have? (Must be 17 or more)');

% if totalrounds < 17
%     disp('invalid number of guesses, please try again')
%     totalrounds = input('How many guesses do you want to have? (Must be 17 or more)');
% end

[board, playerguesses] = playerguess(board, totalrounds);

disp('You used up all your turns! Try again next time!')
%% The code in this section is for level 2 functionality.

%This code allows the player to play the game by typing input coordinates.
disp('Start by placing your ships on the 10 by 10 grid');
disp('All ships are placed to the right and down from the input coordinate.');

ships = [" Carrier", " Battleship", " Cruiser", " Submarine", " Destroyer"];
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];

[playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength);
board = shipplacer(shiplist, shiplength);