function [outcome] = hitoutcome(playerboard, x_guess, y_guess)
%HITOUTCOME This function takes figures out the outcome of a location
%(hit/sink/miss).
%   This function takes in a playerboard (a matrix with a list of locations
%   where the players ships are), and an x and y location to try.
%   This function outputs a string ('hit', 'mis', or 'sin' depending on te
%   outcome of firing at that location. 

global playerboard;

cur_val = playerboard(x_guess,y_guess);

if cur_val == 0 | cur_val == 1
    outcome = 'mis';
else
    is_sink = true;
    for i = 1:10
        for j = 1:10
            if playerboard(i,j) == cur_val
                is_sink = false;
                outcome = 'hit';
                break;
            end
        end
        if is_sink == false
            break;
        end
    end
    if is_sink
        outcome = 'sin';
    end
end
end
