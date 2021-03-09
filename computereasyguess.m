function [playerboard, playergrid, winner, comp_sink_count] = computereasyguess(playerboard, winner, comp_sink_count)
%COMPUTEREASYGUESS This function is called in the medium level, in a two
%player game where the computer is only guessing randomly.
%   This function takes in a playerboard (a matrix with a list of locations
%   where the players ships are), a winner (a boolean saying if a winner
%   has been declared yet), and comp_sink_count (the number of ships that
%   have previously been sunk by the computer. 
%   This function outputs playerboard, with the point the computer guessed
%   changing to have a value of 1 so that the computer can't guess it agai,
%   a playergrid (an image where the player can see where their ships are
%   as well as all the points the computer has guessed), if a winner has
%   been declared, and an updated comp_sink_count based on the changes made
%   this round. 

global playergrid;

%first section of code checks to make sure a guess is valid (we want to be
%sure that the computer is not repeating a number that it has previously
%guessed before)
valid_guess = false;
while valid_guess == false
    x_guess = randi(10);
    y_guess = randi(10);
    if playerboard(x_guess, y_guess) ~=1
        valid_guess = true;
        break;
    end
end

%this next section figures out the value of the matrix playerboard at the
%selected location and the type of ship present at that location. it also
%changes the value of the spot guessed to 1 so it will not be a valid
%location for the future. 
cur_val = playerboard(x_guess,y_guess);
disp(x_guess);
disp(y_guess);
playerboard(x_guess,y_guess) = 1;
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

%first section checks if the cur_val (point the computer is guessing at) is
%zero, in which case the computer missed. the color of that spot turns to
%red. 
if cur_val == 0
    disp('computer missed!');
    playergrid(x_guess, y_guess, :) = [1, 0, 0];
    subplot(1,2,2)
    imagesc(playergrid);
%next section checks for a hit, in which case the color changes to yellow. 
else
    is_sink = true;
    for i = 1:10
        for j = 1:10
            if playerboard(i,j) == cur_val
                disp(strcat('computer hit the', ' ', ship, '!'));
                is_sink = false;
                playergrid(x_guess, y_guess, :) = [1, 1, 0];
                subplot(1,2,2)
                imagesc(playergrid);
                break;
            end
        end
        if is_sink == false
            break;
        end
    end
%next section checks for a sink, in which case the color changes to green. 
    if is_sink
        disp(strcat('computer sunk the', ' ', ship, '!'));
        comp_sink_count = comp_sink_count + 1;
        playergrid(x_guess, y_guess, :) = [0, 1, 0];
        subplot(1,2,2)
        imagesc(playergrid);
    end
end

%this last if checks to see if a winner has been found after the results of
%this guess, which will happen either player sinks 5 ships. 
if comp_sink_count == 5
    disp('The Computer Wins!!')
    winner = true;
    return;
end
end

