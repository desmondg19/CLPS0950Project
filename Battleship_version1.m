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
playerboard = playershipplacer(xpos, ypos, direction);
%this is where the game actually starts. 
%the user is prompted to enter a number of guesses. 

totalrounds = input('How many guesses do you want to have? (Must be 17 or more)');

% if totalrounds < 17
%     disp('invalid number of guesses, please try again')
%     totalrounds = input('How many guesses do you want to have? (Must be 17 or more)');
% end

currentrounds = 1;
sink_count = 0;

sqr = ones(10, 10);
playerguesses = cat(3, sqr, sqr, sqr);
imagesc(playerguesses)
axis on;
hold on;

while currentrounds <= totalrounds
    x_shot = input('What row do you want to hit (1-10)?');
    x_shot = round(x_shot);
    y_shot = input('What column do you want to hit (1-10)?');
    y_shot = round(y_shot);
    
    if x_shot < 1 | x_shot > 10
        disp('Invalid X, try again');
        x_shot = input('What x coordinate do you want to hit (1-10)?');
    end
    if y_shot < 1 | y_shot > 10
        disp('Invalid Y, try again');
        y_shot = input('What y coordinate do you want to hit (1-10)?');
    end
    
    cur_val = board(x_shot,y_shot);
    type = char(cur_val);
    if type == 'C'
        ship = ' carrier';
    elseif type == 'D'
        ship = ' destroyer';
    elseif type == 'S'
        ship = ' submarine';
    elseif type == 'R'
        ship = ' cruiser';
    elseif type == 'B'
        ship = ' battleship';
    end
    
    if cur_val == 0
        disp('miss!');
        playerguesses(x_shot, y_shot, :) = [1, 0, 0];
        imagesc(playerguesses);
    else
        is_sink = true;
        board(x_shot, y_shot) = 0;
        for i = 1:10
            for j = 1:10
                if board(i,j) == cur_val
                    disp(strcat('you hit the', ' ', ship, '!'));
                    is_sink = false;
                    playerguesses(x_shot, y_shot, :) = [0, 1, 0];
                    imagesc(playerguesses);
                    break;
                end
            end
            if is_sink == false
                break;
            end
        end
        if is_sink
            disp(strcat('you sunk the', ' ', ship, '!'));
            sink_count = sink_count + 1;
        end
    end
    currentrounds = currentrounds + 1;
    if sink_count == 5
        disp('You Win!!')
        break;
    end
end

disp('You used up all your turns! Try again next time!')
%% The code in this section is for level 2 functionality.

%This code allows the player to play the game by typing input coordinates.
disp('Start by placing your ships on the 10 by 10 grid');
disp('All ships are placed to the right and down from the input coordinate.');
sqr = ones(10, 10);
playergrid = cat(3, sqr, sqr, sqr);
imagesc(playergrid)

playerboard = zeros(10);

ships = [" Carrier", " Battleship", " Cruiser", " Submarine", " Destroyer"];
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];
for i = 1:length(ships)
    placed = false;
    while placed == false;
        disp(strcat('You are placing the', ships(i), '.'));
        disp(strcat('It is', {' '}, num2str(shiplength(i)), ' units in length.'))
        
        [xpos, ypos, direction] = playershipplacer()
        
        size = shiplength(i);
        
        if lower(direction) == 'h'
            if ypos + size - 1 <= 10
                valid = 1;
                for j = 1:size
                    if playerboard(xpos, ypos+j-1) ~= 0
                        valid = 0;
                        disp('Not valid - overlapping ships');
                    end
                end
                if valid == 1
                    for j = 1:size
                        playerboard(xpos, ypos - 1 + j) = shiplist(i);
                        playergrid(xpos, ypos - 1 + j, :) = [0, 0, 1];
                        imagesc(playergrid);
                    end
                    placed = true;
                end
            else
                disp('Not valid - too close to edge');
            end
        elseif lower(direction) == "v"
            if xpos + size - 1 <= 10
                valid = 1;
                for j = 1:size
                    if playerboard(xpos+j-1, ypos) ~= 0
                        valid = 0;
                        disp('Not valid - overlapping ships');
                    end
                end
                if valid == 1
                    for j = 1:size
                        playerboard(xpos - 1 + j, ypos) = shiplist(i);
                        playergrid(xpos - 1 + j, ypos, :) = [0, 0, 1];
                        imagesc(playergrid);
                    end
                    placed = true;
                end
            else
                disp('Not valid - too close to edge');
            end
        else
            disp('Not valid - direction was not "H" or "V"');
        end
    end
end

board = shipplacer(shiplist, shiplength);
