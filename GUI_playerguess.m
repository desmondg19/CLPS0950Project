function [handles] = GUI_playerguess(handles)
%PLAYERGUESS This function allows the player to guess a particular location
%using inputs in MATLAB. It is used in the easy (1 player), medium (random
%computer guesses), and hard (smart guesses) versions of the game. 
%   The function takes in board, a matrix with the computer's ships on it,
%   a winner (a boolean saying if there is a winner or not), and sink_count
%   (the number of ships the player has sank). It outputs board, which is
%   an updated matrix, playerguesses (allows the player to visualize their
%   hits and misses), a winner (boolean that updates if a winner has been
%   reached), and a sink_count (the number of ships the player has sunk).



x_shot = abs(get(handles.slideryaxis, 'Value'));
y_shot = abs(get(handles.slider2xaxis, 'Value'));


%determines the type of ship at that location. 
cur_val = handles.board(x_shot,y_shot);
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
    if handles.tracker(x_shot, y_shot) ~= 1 % makes sure this is the first shot at this location
    handles.grid(x_shot, y_shot, :) = [255, 0, 0]; % changes square to red
    imshow(handles.grid, 'Parent', handles.axes1);%x_shot and y_shot are position in matrix
     hold on
     handles.tracker(x_shot,y_shot) = 1; % stores that this coordinate has been hit
     set(handles.text2, 'String', 'Miss!'); % informs the player they missed
    end
  
    
else %only if there is a hit or sink
    
    is_sink = true; 
    % changes the value of each ship to assist in changing the color once
    % they have been sunk 
    if type == 'C'
    handles.board(x_shot, y_shot) = 2; 
    elseif type == 'D'
    handles.board(x_shot, y_shot) = 3;
    elseif type == 'S'
    handles.board(x_shot, y_shot) = 4;
    elseif type == 'R'
    handles.board(x_shot, y_shot) = 5;
    elseif type == 'B'
    handles.board(x_shot, y_shot) = 6;
   end 
    for i = 1:10
        for j = 1:10
            if handles.board(i,j) == cur_val
                is_sink = false;
                if handles.tracker(x_shot, y_shot) ~=1 % checks this hasn't been hit before
                handles.grid(x_shot, y_shot, :) = [255, 255, 0]; %changes square color to yellow
                 handles.tracker(x_shot, y_shot) = 1; % registers this spot as hit
                 set(handles.text2, 'String', 'Hit!'); 
                end
                
                imshow(handles.grid, 'Parent', handles.axes1);
                break;
            end
        end
        if is_sink == false
            break;
        end
    end
        if is_sink %only if there is a sink -> will update the sink count.
        handles.sink_count = handles.sink_count + 1; 
        set(handles.ships_sunk, 'String', handles.sink_count);
        
        handles.grid(x_shot, y_shot, :) = [0, 255, 0]; % changes color of square to green
        handles.tracker(x_shot, y_shot) = 1; % registers that this coordinate has been hit
        set(handles.text2, 'String', strcat('You Sunk the', ship, '!'));  
          for i = 1:10
        for j = 1:10
            if handles.board(x_shot, y_shot) == handles.board(i,j)
                handles.grid(i, j, :) = [0, 255, 0]; % makes all other coordinates for that ship green
                
                
            end
        end
          end
        imshow(handles.grid, 'Parent', handles.axes1);
        
        end
    if handles.sink_count == 5 %if the player has sunk 5 ships, they win.
   handles.grid(x_shot, y_shot, :) = [163, 94, 196]; % makes this square purple
   set(handles.text2, 'String', 'You Won!'); 
    for i = 1:10
        for j = 1:10 
            handles.grid(i,j, :) = [163, 94, 196]; % changes the rest of the board to purple
        end
    end
    handles.winner = true;
    return;
    
end
end
set(handles.rounds_left, 'String', handles.totalrounds-handles.current_rounds); 
handles.current_rounds = handles.current_rounds + 1;


end