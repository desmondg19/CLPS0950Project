% things remaining in this L1 functionality level
% 1) telling them which ships they were able to hit or sink - DONE
% 2) showing the actual image to the player of a grid
% 3) the grid should be different colors depending on if it was a hit/miss/sink

function []= Battleship ();

disp('Welcome to Battleship');
difficulty= input ('Choose your difficulty: 1=easy, 2=medium, 3=hard');

%initializing the ships
shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
shiplength = [5, 4, 3, 3, 2];


[X,Y]=meshgrid(0:10);
mesh(X,Y)
view(2)



board=zeros(10);
for i = 1:length(shiplist)
    placed = false;
    size = shiplength(i);
    while placed == false
        x = randi(10);
        y = randi(10);
        direction = randi(2);
        
        if direction == 1
            if y + size - 1 <= 10
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
            if x + size - 1 <= 10
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



totalrounds = input('How many guesses do you want to have? (Must be 17 or more)');
currentrounds = 1;
sink_count = 0;

sqr = ones(10, 10);
img1 = cat(3, sqr, sqr, sqr);
imagesc(img1)
axis on;
hold on;

while currentrounds <= totalrounds
    x_shot = input('What row do you want to hit (1-10)?');
    x_shot = round(x_shot);
    y_shot = input('What column do you want to hit (1-10)?');
    y_shot = round(y_shot);
    
    if x_shot < 1 | x_shot > 10
        disp('Invalid X, try again');
        x_shot = input('What x coordinate do you want to hit (1-10)?');
    end
    if y_shot < 1 | y_shot > 10
        disp('Invalid Y, try again');
        y_shot = input('What y coordinate do you want to hit (1-10)?');
    end
    
    cur_val = board(x_shot,y_shot);
    type = char(cur_val);
    if type == 'C'
        ship = ' carrier';
    elseif type == 'D'
        ship = ' destroyer';
    elseif type == 'S'
        ship = ' submarine';
    elseif type == 'R'
        ship = ' cruiser';
    elseif type == 'B'
        ship = ' battleship';
    end
    
    if cur_val == 0
        disp('miss!');
        img1(x_shot, y_shot, :) = [1, 0, 0];
        imagesc(img1);
    else
        is_sink = true;
        board(x_shot, y_shot) = 0;
        for i = 1:10
            for j = 1:10
                if board(i,j) == cur_val
                    disp(strcat('you hit the', ' ', ship, '!'));
                    is_sink = false;
                    img1(x_shot, y_shot, :) = [0, 1, 0];
                    imagesc(img1);
                    break;
                end
            end
            if is_sink == false
                break;
            end
        end
        if is_sink
            disp(strcat('you sunk the', ' ', ship, '!'));
            sink_count = sink_count + 1;
        end
    end
    currentrounds = currentrounds + 1;
    if sink_count == 5
        disp('You Win!!')
        break;
    end
end
disp('You used up all your turns! Try again next time!')
