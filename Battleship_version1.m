% %functions that are in this folder that are actually being used in this
% %version of the code
% 1) shipplacer - generated position of ships randomly on board
% 2) player guess - runs the code when the player wants to guess
% 3) playershipplacer - allows player to place their ships, and shipposn
%       function is used within this
% 4) computer easy guess - medium level computer guessing pattern (random)
% 5) computer hard guess - hard level computer guessing pattern (strategic)

%issues i'm coming across: 
% 1) errors if they do not input a coordinate 

disp('Welcome to Battleship');
valid_difficulty = false;
while valid_difficulty == false
    difficulty = input ('Choose your difficulty: 1=easy, 2=medium, 3=hard');
    if difficulty == 1 || difficulty == 2 || difficulty == 3
        valid_difficulty = true;
    else
        disp('This is not a valid difficulty. Please try again.');
    end
end

ships = [" Carrier", " Battleship", " Cruiser", " Submarine", " Destroyer"];
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];
sqr = ones(10, 10);

if difficulty == 1 %easy level: one player version
    %calls on shipplacer to generate a board, and asks the player to enter the
    %number of turns that they want to have at the game.
    board = shipplacer(shiplist, shiplength);
    valid_rounds = false;
    while valid_rounds == false
        totalrounds = input('How many guesses do you want to have? (17+)');
        if totalrounds >= 17
            valid_rounds = true;
            break;
        else
            disp('Invalid number of guesses');
        end
    end
    %generates an image of the player guesses + sets up guesser function
    global playerguesses
    playerguesses = cat(3, sqr, sqr, sqr);
    sink_count = 0;
    winner = false;
    current_rounds = 1;
    
    % while player is playing, allows guesses to be checked against the
    % computers randomly generated board.
    while current_rounds <= totalrounds
        [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count);
        imagesc(playerguesses)
    %subplot(1,2,2)
    %x = 1;
    % y = current_rounds;
    % %bar(x,y,'r')
    %title('Turns Used')
        current_rounds = current_rounds + 1;
    end
    
    disp('You used up all your turns! Try again next time!');

elseif difficulty == 2 %medium level: two player - computer in easyguess mode
    %This code allows the player to set up the game by typing input coordinates.
    %Then, it generates the computer's board.
    disp('Start by placing your ships on the 10 by 10 grid');
    disp('All ships are placed to the right and down from the input coordinate.');
    global playergrid
    [playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength);
    board = shipplacer(shiplist, shiplength);
    
    %computer and player take turns guessing spaces.
    global playerguesses
    playerguesses = cat(3, sqr, sqr, sqr);
    sink_count = 0;
    winner = false;
    comp_sink_count = 0;
    
    while winner == false
        [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count);
         subplot(1,2,1)
         imagesc(playerguesses);
        if winner == true
            break;
        end
        disp('Time for the computer to guess');
        [playerboard, playergrid, winner, comp_sink_count] = computereasyguess(playerboard, winner, comp_sink_count);
    end
    
else %% Hard: two player - computer in hardguess mode
    %This code allows the player to set up the game by typing input coordinates.
    %Then, it generates the computer's board.
    disp('Start by placing your ships on the 10 by 10 grid');
    disp('All ships are placed to the right and down from the input coordinate.');
    
    global playergrid
    [playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength);
    board = shipplacer(shiplist, shiplength);
    
    %computer and player take turns guessing spaces.
    global playerguesses
    global nextsteps
    global count_nextsteps
    global playerboard
    
    playerguesses = cat(3, sqr, sqr, sqr);
    sink_count = 0;
    winner = false;
    comp_sink_count = 0;
    nextsteps = [];
    count_nextsteps = 0;
    
    while winner == false
        [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count);
        subplot(1,2,1)
        imagesc(playerguesses);
        if winner == true
            break;
        end
        disp('Time for the computer to guess');
        [playerboard, winner, comp_sink_count] = computesteps(playerboard, winner, comp_sink_count);
    end
end