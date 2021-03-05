function [board, playerguesses, winner, sink_count] = playerguess(board, winner, sink_count)
%PLAYERGUESS This function allows the player to guess a particular location
%using inputs in MATLAB. It is used in the easy (1 player), medium (random
%computer guesses), and hard (smart guesses) versions of the game. 
%   The function takes in board, a matrix with the computer's ships on it,
%   a winner (a boolean saying if there is a winner or not), and sink_count
%   (the number of ships the player has sank). It outputs board, which is
%   an updated matrix, playerguesses (allows the player to visualize their
%   hits and misses), a winner (boolean that updates if a winner has been
%   reached), and a sink_count (the number of ships the player has sunk).

global playerguesses

x_shot = input('What row do you want to hit (1-10)?');
x_shot = round(x_shot);
y_shot = input('What column do you want to hit (1-10)?');
y_shot = round(y_shot);

%makes sure the player guess is in the valid range
if x_shot < 1 | x_shot > 10
    disp('Invalid X, try again');
    x_shot = input('What x coordinate do you want to hit (1-10)?');
end
if y_shot < 1 | y_shot > 10
    disp('Invalid Y, try again');
    y_shot = input('What y coordinate do you want to hit (1-10)?');
end

%determines the type of ship at that location.
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

%if there is a miss, tells the computer they have missed. 
if cur_val == 0
    disp('miss!');
    subplot(1,2,1)
    playerguesses(x_shot, y_shot, :) = [1, 0, 0];
    imagesc(playerguesses);
else %only if there is a hit or sink
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
    if is_sink %only if there is a sink -> will update the sink count.
        disp(strcat('you sunk the', ' ', ship, '!'));
        sink_count = sink_count + 1;
        playerguesses(x_shot, y_shot, :) = [0, 1, 0];
        subplot(1,2,1)
        imagesc(playerguesses);
    end
end
if sink_count == 5 %if the player has sunk 5 ships, they win.
    disp('You Win!!');
    winner = true;
    return;
end
end