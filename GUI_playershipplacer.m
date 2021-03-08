function [handles] = GUI_playershipplacer(handles)
%PLAYERSHIPPLACER This function prompts the user to place the 5 ships of
%interest on the board. It then allows them to visualize where they've
%placed the ships. 

%   This function takes in a list of ship full names, shiplist (which is
%   the ascii for a 1 letter abbreviation of the ship names to be used in a
%   matrix later), and a list with the lengths of each ships. The function
%   will output playerboard, which is a matrix with the information about
%   which ships were placed where. It will also output playergrid, which is
%   an image of where all the ships have been placed. 

playerboard = zeros(10);
sqr = ones(10, 10);
playergrid = cat(3, sqr, sqr, sqr);

for i = 1:length(ships)
    placed = false;
    while placed == false;
        disp(strcat('You are placing the', ships(i), '.'));
        disp(strcat('It is', {' '}, num2str(shiplength(i)), ' units in length.'))
        
        [xpos, ypos, direction] = shipposnfunction();
        
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





% playerboard = zeros(10)
% for i = 1:length(shiplist)
%     placed = false;
%     size = shiplength(i);
%  if i == 1
%      disp('You are placing the Carrier. It occupies 5 spaces')
%  elseif i == 2
%      disp('You are placing the Battleship. It occupies 4 spaces')
%  elseif i == 3
%      disp('You are placing the Cruiser. It occupies 3 spaces')
%  elseif i == 4
%      disp('You are placing the Submarine. It occupies 3 spaces')
%  elseif i== 5
%      disp('You are placing the Destroyer. It occupies 2 spaces')
%  end
%  
% direction = input('Horizontally or Vertically? (input "H" or "V")');
% xpos = input('What row do you want to start the ship (1-10)?');
% xpos = round(xpos);
% if direction == H && xpos + size >= 10
%     disp('You cannot place that ship here. Try again.');
%     xpos = input('What row do you want to start the ship (1-10)?');
% end
% ypos = input('What column do you want to start the ship? (1-10)?');
% if direction == V && ypos + size >= 10
%      disp('You cannot place that ship here. Try again.');
%      ypos = input('What column do you want to start the ship? (1-10)?');
% 
% end
% ypos = round(ypos);
% 
% if xpos < 1 | xpos > 10
%     disp('Invalid X, try again');
%     xpos = input('What x coordinate do you want to hit (1-10)?');
% end
% if ypos < 1 | ypos > 10
%     disp('Invalid Y, try again');
%     ypos = input('What y coordinate do you want to hit (1-10)?');
% end
% playerboard(xpos, ypos) = 1