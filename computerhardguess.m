function [nextsteps, count_nextsteps] = computerhardguess(playerboard, x_start, y_start)
%COMPUTERHARDGUESS This function will take in an x and y location as well
%as the matrix with the locations of the players ships. 
%   The function will output all adjacent spots that have a ship located at
%   that position. Those spots will be added to the list nextsteps, so that
%   the next guesses made by the computer will also be hits. It will also
%   output the total count of all next steps that remain. 

global nextsteps;
global count_nextsteps;
global playerboard;

point_complete = false;

while point_complete == false
    for i = (y_start+1):10 %checks to the right of x,y
        outcome = hitoutcome(playerboard, x_start, i);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = x_start;
            nextsteps(length(nextsteps)+1) = i;
        else
            break;
        end
    end
    for i = (y_start-1):-1:1 %checks to the left of x,y
        outcome = hitoutcome(playerboard, x_start, i);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = x_start;
            nextsteps(length(nextsteps)+1) = i;
        else
            break;
        end
    end
    for i = (x_start+1):10 %checks below x,y
        outcome = hitoutcome(playerboard, i, y_start);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = i;
            nextsteps(length(nextsteps)+1) = y_start;
        else
            break;
        end
    end
    for i = (x_start-1):-1:1 %checks above x,y
        outcome = hitoutcome(playerboard, i, y_start);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = i;
            nextsteps(length(nextsteps)+1) = y_start;
        else
            break;
        end
    end
    point_complete = true;
end