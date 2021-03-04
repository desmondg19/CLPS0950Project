function [playerboard, winner, comp_sink_count] = computesteps(playerboard, winner, comp_sink_count)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global playergrid;
global nextsteps;
global count_nextsteps;

disp(nextsteps);
disp(count_nextsteps);

if count_nextsteps ~= 0
    validguess = false;
    while validguess == false
        x_guess = nextsteps(1);
        disp(x_guess);
        y_guess = nextsteps(2);
        disp(y_guess);
        cur_val = playerboard(x_guess, y_guess);

        if cur_val == 1
            nextsteps = nextsteps(3:end);
            count_nextsteps = count_nextsteps-1;
        else
            validguess = true;
        end
    end
    
    if length(nextsteps) == 2
        nextsteps = []
        count_nextsteps = 0;
    else
        nextsteps = nextsteps(3:end);
        count_nextsteps = count_nextsteps-1;
    end
    
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
                    [nextsteps, count_nextsteps] = computerhardguess(playerboard, x_guess, y_guess)
                    break;
                end
            end
            if is_sink == false
                break;
            end
        end
        if is_sink
            disp(strcat('computer sunk the', ' ', ship, '!'));
            comp_sink_count = comp_sink_count + 1;
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
else
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
                    [nextsteps, count_nextsteps] = computerhardguess(playerboard, x_guess, y_guess)
                    break;
                end
            end
            if is_sink == false
                break;
            end
        end
        if is_sink
            disp(strcat('computer sunk the', ' ', ship, '!'));
            comp_sink_count = comp_sink_count + 1;
            nextsteps = [];
            count_nextsteps = 0;
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