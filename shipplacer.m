function [board] = shipplacer(shiplist,shiplength)
%SHIPPLACER This function randomly places the ships on the matrix.
%   The inputs to this function are a list of ships (characters) and the
%   length of those ships. The output of the function is a matrix called
%   board. 

board=zeros(10);
for i = 1:length(shiplist)
    placed = false;
    size = shiplength(i);
    while placed == false
        x = randi(10); %picks a random starting x coordinate
        y = randi(10); %picks a random starting y coordinate
        direction = randi(2); %1 = horizontal placement; 2 = vertical
        
        if direction == 1
            if y + size - 1 <= 10   %checks to make sure that a vertical ship placement is valid 
                valid = 1;
                for j = 1:size
                    if board(x, y+j-1) ~= 0
                        valid = 0;
                    end
                end
                if valid == 1
                    for j = 1:size
                        board(x, y - 1 + j) = shiplist(i);
                    end
                    placed = true;
                end
            end
        else
            if x + size - 1 <= 10   % checks to make sure a horizontal ship placement is valid
                valid = 1;
                for j = 1:size
                    if board(x + j - 1, y) ~= 0
                        valid = 0;
                    end
                end
                if valid == 1
                    for j = 1:size
                        board(x - 1 + j, y) = shiplist(i);
                    end
                    placed = true;
                end
            end
        end
    end
end
end

