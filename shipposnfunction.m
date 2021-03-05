function [xpos, ypos, direction] = shipposnfunction()
%SHIPPOSNFUNCTION This function is called in the playershipplacer function,
%and it is used to make sure the player places the ship in a valid starting
%and ending location. 
%   it takes in no inputs, because the necessary information is generated
%   by the function using "input", and outputs an x-position and y-position
%   to start the ship at, and a direction in which the ship is to be placed
%   (to the right or down).

xpos = input('What row do you want to start the ship (1-10)?');
xpos = round(xpos);
ypos = input('What column do you want to start the ship? (1-10)?');
ypos = round(ypos);
direction = input('Horizontally (to the right) or Vertically (down)? (input "H" or "V")');

if xpos < 1 | xpos > 10
    disp('Invalid X, try again');
    xpos = input('What x coordinate do you want to hit (1-10)?');
end
if ypos < 1 | ypos > 10
    disp('Invalid Y, try again');
    ypos = input('What y coordinate do you want to hit (1-10)?');
end
end