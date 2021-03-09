function [playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength)
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

for i = 1:length(ships) % player places each ship 
    placed = false;
    while placed == false;
        disp(strcat('You are placing the', ships(i), '.')); % tells player which ship 
        disp(strcat('It is', {' '}, num2str(shiplength(i)), ' units in length.'))
        
        [xpos, ypos, direction] = shipposnfunction();
        
        size = shiplength(i);
        
        if lower(direction) == 'h' % checks validity of horizontal ship placement
            if ypos + size - 1 <= 10
                valid = 1;
                for j = 1:size
                    if playerboard(xpos, ypos+j-1) ~= 0
                        valid = 0;
                        disp('Not valid - overlapping ships'); % error message for player
                    end
                end
                if valid == 1 
                    for j = 1:size % places a valid ship 
                        playerboard(xpos, ypos - 1 + j) = shiplist(i);
                        playergrid(xpos, ypos - 1 + j, :) = [0, 0, 1];
                        imagesc(playergrid);
                    end
                    placed = true;
                end
            else
                disp('Not valid - too close to edge'); % displays error messafe
            end
        elseif lower(direction) == "v" % checks validity of vertical ship placement
            if xpos + size - 1 <= 10
                valid = 1;
                for j = 1:size
                    if playerboard(xpos+j-1, ypos) ~= 0
                        valid = 0;
                        disp('Not valid - overlapping ships'); % error message for player
                    end
                end
                if valid == 1 % places valid ship 
                    for j = 1:size
                        playerboard(xpos - 1 + j, ypos) = shiplist(i);
                        playergrid(xpos - 1 + j, ypos, :) = [0, 0, 1];
                        imagesc(playergrid);
                    end
                    placed = true;
                end
            else
                disp('Not valid - too close to edge'); % error message
            end
        else
            disp('Not valid - direction was not "H" or "V"'); % displayed if user does not pick a valid direction
        end
    end
end





