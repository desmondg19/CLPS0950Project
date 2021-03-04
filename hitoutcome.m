function [outcome] = hitoutcome(playerboard, x_guess, y_guess)

cur_val = playerboard(x_guess,y_guess);

if cur_val == 0
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

disp(outcome);
end
