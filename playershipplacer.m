function [playerboard] = playershipplacer(xpos, ypos, direction)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

playerboard = zeros(10)
for i = 1:length(shiplist)
    placed = false;
    size = shiplength(i);
 if i == 1
     disp('You are placing the Carrier. It occupies 5 spaces')
 elseif i == 2
     disp('You are placing the Battleship. It occupies 4 spaces')
 elseif i == 3
     disp('You are placing the Cruiser. It occupies 3 spaces')
 elseif i == 4
     disp('You are placing the Submarine. It occupies 3 spaces')
 elseif i== 5
     disp('You are placing the Destroyer. It occupies 2 spaces')
 end
 
direction = input('Horizontally or Vertically? (input "H" or "V")');
xpos = input('What row do you want to start the ship (1-10)?');
xpos = round(xpos);
if direction == H && xpos + size >= 10
    disp('You cannot place that ship here. Try again.');
    xpos = input('What row do you want to start the ship (1-10)?');
end
ypos = input('What column do you want to start the ship? (1-10)?');
if direction == V && ypos + size >= 10
     disp('You cannot place that ship here. Try again.');
     ypos = input('What column do you want to start the ship? (1-10)?');
end
ypos = round(ypos);



if xpos < 1 | xpos > 10
    disp('Invalid X, try again');
    xpos = input('What x coordinate do you want to hit (1-10)?');
end
if ypos < 1 | ypos > 10
    disp('Invalid Y, try again');
    ypos = input('What y coordinate do you want to hit (1-10)?');
end
playerboard(xpos, ypos) = 1
end