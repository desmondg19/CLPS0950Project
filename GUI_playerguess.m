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


%FIND IS_SINK VARIABLE

x_shot = abs(get(handles.slideryaxis, 'Value'));
y_shot = abs(get(handles.slider2xaxis, 'Value'));
%%global playergrid=get(handles.grid); %trying to initialize variable to store what the current board looks like


%determines the type of ship at that location. %can look into switch case
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
    if handles.tracker(x_shot, y_shot) ~= 1
    handles.grid(x_shot, y_shot, :) = [255, 0, 0];

    %imshow(handles.grid, 'Parent', handles.axes1);%x_shot and y_shot are position in matrix
     %hold on

    imshow(handles.grid, 'Parent', handles.axes1);%x_shot and y_shot are position in matrix
     hold on
     handles.tracker(x_shot,y_shot) = 1; 
     set(handles.text2, 'String', 'Miss!');
    end
  
    

else %only if there is a hit or sink
    
    is_sink = true; %where is
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
                if handles.tracker(x_shot, y_shot) ~=1
                handles.grid(x_shot, y_shot, :) = [255, 255, 0];

                %imshow(handles.grid, 'Parent', handles.axes1); %accessing axes

                 handles.tracker(x_shot, y_shot) = 1; 
                 set(handles.text2, 'String', 'Hit!');
                end
                
                imshow(handles.grid, 'Parent', handles.axes1);

                %hold on 
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
        
        handles.grid(x_shot, y_shot, :) = [0, 255, 0];

        %imshow(handles.grid, 'Parent', handles.axes1);

        handles.tracker(x_shot, y_shot) = 1;
        set(handles.text2, 'String', strcat('You Sunk the', ship, '!'));
          for i = 1:10
        for j = 1:10
            if handles.board(x_shot, y_shot) == handles.board(i,j)
                handles.grid(i, j, :) = [0, 255, 0];
                
                
            end
        end
          end
        imshow(handles.grid, 'Parent', handles.axes1);

        
        end
    if handles.sink_count == 5 %if the player has sunk 5 ships, they win.
   handles.grid(x_shot, y_shot, :) = [163, 94, 196]; 
   set(handles.text2, 'String', 'You Won!');
    for i = 1:10
        for j = 1:10 
            handles.grid(i,j, :) = [163, 94, 196];
        end
    end
    handles.winner = true;
    return;
    
end
end

set(handles.rounds_left, 'String', handles.totalrounds-handles.current_rounds);
handles.current_rounds = handles.current_rounds + 1;


%current_board=current_board+handles.grid;
end