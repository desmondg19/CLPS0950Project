function [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global playerguesses

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
    subplot(1,2,1)
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
                subplot(1,2,1)
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
        playerguesses(x_shot, y_shot, :) = [0, 1, 0];
        subplot(1,2,1)
        imagesc(playerguesses);
    end
end
if sink_count == 5
    disp('You Win!!');
    winner = true;
    return;
end
end