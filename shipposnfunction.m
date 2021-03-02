function [xpos, ypos, direction] = shipposnfunction()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
xpos = input('What row do you want to start the ship (1-10)?');
xpos = round(xpos);
ypos = input('What column do you want to start the ship? (1-10)?');
ypos = round(ypos);
direction = input('Horizontally or Vertically? (input "H" or "V")');

if xpos < 1 | xpos > 10
    disp('Invalid X, try again');
    xpos = input('What x coordinate do you want to hit (1-10)?');
end
if ypos < 1 | ypos > 10
    disp('Invalid Y, try again');
    ypos = input('What y coordinate do you want to hit (1-10)?');
end
end