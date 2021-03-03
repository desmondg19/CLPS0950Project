function [playerboard, playergrid, winner, comp_sink_count] = computereasyguess(playerboard, winner, comp_sink_count)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global playergrid;

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
    append(
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
end

