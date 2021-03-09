function [playerboard, winner, comp_sink_count] = computesteps(playerboard, winner, comp_sink_count)
%COMPUTESTEPS This function parallels the computereasyguess function, but
%for the harder/smarter computer.
%   This function takes in a playerboard (a matrix with a list of locations
%   where the players ships are), a winner (a boolean saying if a winner
%   has been declared yet), and comp_sink_count (the number of ships that
%   have previously been sunk by the computer.
%   This function outputs playerboard, with the point the computer guessed
%   changing to have a value of 1 so that the computer can't guess it
%   again, if a winner has been declared, and the computer's sink count.

global playergrid;
global nextsteps;
global count_nextsteps;
global playerboard;

%the first part of this if/elese statement is used if there are any x,y
%points that should be checked in next_steps. the else clause will be used
%if no such points exist (after a previous miss or a previous sink)
if count_nextsteps ~= 0
    validguess = false;
    %checks to make sure the point being guessed has not been guessed
    %before.
    while validguess == false 
        x_guess = nextsteps(1);
        y_guess = nextsteps(2);
        cur_val = playerboard(x_guess, y_guess);
        
        if cur_val == 1
            nextsteps = nextsteps(3:end);
            count_nextsteps = count_nextsteps-1;
        else
            validguess = true;
        end
    end
    
    disp(x_guess);
    disp(y_guess);
    
    %this section will remove the new trial point from the overall list of
    %next steps for the next round of the computer's guesses.
    if length(nextsteps) == 2
        nextsteps = [];
        count_nextsteps = 0;
    else
        nextsteps = nextsteps(3:end);
        count_nextsteps = count_nextsteps-1;
    end
    
    %changes the value of the position to 1 so it is not valid for the
    %future and finds the type of ship (if any) at the guessed location. 
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
    
    %code here is basically idential to computer easy guess - has different
    %outcomes based on if the computer misses, hits, or sinks.
    if cur_val == 0 %misses
        disp('computer missed!');
        playergrid(x_guess, y_guess, :) = [1, 0, 0];
        subplot(1,2,2)
        imagesc(playergrid);
    else
        is_sink = true;
        for i = 1:10 %code below is for a hit + changes to green
            for j = 1:10
                if playerboard(i,j) == cur_val
                    disp(strcat('computer hit the', ' ', ship, '!'));
                    is_sink = false;
                    playergrid(x_guess, y_guess, :) = [0, 1, 0];
                    subplot(1,2,2)
                    imagesc(playergrid);
                    [nextsteps, count_nextsteps] = computerhardguess(playerboard, x_guess, y_guess);
                    break;
                end
            end
            if is_sink == false
                break;
            end
        end
        if is_sink %tests if there is a sink
            nextsteps = [];
            count_nextsteps = 0;
            comp_sink_count = comp_sink_count + 1;
            disp(strcat('computer sunk the', ' ', ship, '!'));
            playergrid(x_guess, y_guess, :) = [0, 1, 0];
            subplot(1,2,2)
            imagesc(playergrid);
        end
    end
    
    if comp_sink_count == 5 %computer wins if 5 guesses
        disp('The Computer Wins!!');
        winner = true;
        return;
    end
else %runs if there are no nextsteps for the computer to try. 
    %starts with a random point, but otherwise very similar to the code
    %under the if clause. 
    valid_guess = false;
    while valid_guess == false
        x_guess = randi(10);
        y_guess = randi(10);
        if playerboard(x_guess, y_guess) ~=1
            valid_guess = true;
            break;
        end
    end
    
    disp(x_guess);
    disp(y_guess);
    
    cur_val = playerboard(x_guess,y_guess);
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
    
    if cur_val == 0
        disp('computer missed!');
        playergrid(x_guess, y_guess, :) = [1, 0, 0];
        subplot(1,2,2)
        imagesc(playergrid);
    else
        is_sink = true;
        for i = 1:10
            for j = 1:10
                if playerboard(i,j) == cur_val
                    disp(strcat('computer hit the', ' ', ship, '!'));
                    is_sink = false;
                    playergrid(x_guess, y_guess, :) = [0, 1, 0];
                    subplot(1,2,2)
                    imagesc(playergrid);
                    [nextsteps, count_nextsteps] = computerhardguess(playerboard, x_guess, y_guess);
                    break;
                end
            end
            if is_sink == false
                break;
            end
        end
        if is_sink
            nextsteps = [];
            count_nextsteps = 0;
            comp_sink_count = comp_sink_count + 1;
            disp(strcat('computer sunk the', ' ', ship, '!'));
            playergrid(x_guess, y_guess, :) = [0, 1, 0];
            subplot(1,2,2)
            imagesc(playergrid);
        end
    end
    
    if comp_sink_count == 5
        disp('The Computer Wins!!')
        winner = true;
        return;
    end
end