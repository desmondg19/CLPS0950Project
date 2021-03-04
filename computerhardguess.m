function [nextsteps, count_nextsteps] = computerhardguess(playerboard, x_start, y_start)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global nextsteps
global count_nextsteps

point_complete = false;

while point_complete == false
    for i = (y_start+1):10
        outcome = hitoutcome(playerboard, x_start, i);
        disp(outcome);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = x_start;
            nextsteps(length(nextsteps)+1) = i;
        else
            break;
        end
    end
    for i = (y_start-1):-1:1
        outcome = hitoutcome(playerboard, x_start, i);
        disp(outcome);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = x_start;
            nextsteps(length(nextsteps)+1) = i;
        else
            break;
        end
    end
    for i = (x_start+1):10
        outcome = hitoutcome(playerboard, i, y_start);
        disp(outcome);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = i;
            nextsteps(length(nextsteps)+1) = y_start;
        else
            break;
        end
    end
    for i = (x_start-1):-1:1
        outcome = hitoutcome(playerboard, i, y_start);
        disp(outcome);
        if outcome == 'hit'
            count_nextsteps = count_nextsteps + 1;
            nextsteps(length(nextsteps)+1) = i;
            nextsteps(length(nextsteps)+1) = y_start;
        else
            break;
        end
    end
    disp(count_nextsteps);
    point_complete = true;
end