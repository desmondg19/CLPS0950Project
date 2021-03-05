function varargout = BattleshipBoard(varargin)
% BATTLESHIPBOARD MATLAB code for BattleshipBoard.fig
%      BATTLESHIPBOARD, by itself, creates a new BATTLESHIPBOARD or raises the existing
%      singleton*.
%
%      H = BATTLESHIPBOARD returns the handle to a new BATTLESHIPBOARD or the handle to
%      the existing singleton*.
%
%      BATTLESHIPBOARD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATTLESHIPBOARD.M with the given input arguments.
%
%      BATTLESHIPBOARD('Property','Value',...) creates a new BATTLESHIPBOARD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BattleshipBoard_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BattleshipBoard_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BattleshipBoard

% Last Modified by GUIDE v2.5 02-Mar-2021 17:39:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BattleshipBoard_OpeningFcn, ...
                   'gui_OutputFcn',  @BattleshipBoard_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

end
% --- Executes just before BattleshipBoard is made visible.
function BattleshipBoard_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BattleshipBoard (see VARARGIN)

% Choose default command line output for BattleshipBoard
handles.output = hObject;
handles.grid=zeros(10, 10, 3);
handles.coordx=1;
handles.coordy=1;

%initializing the ships and the ship lengths
handles.shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
handles.shiplength = [5, 4, 3, 3, 2];

numSteps=10; %go ten steps, value 1, min 1

set(handles.slider2xaxis, 'Min', 1); 
set(handles.slider2xaxis, 'Max', numSteps); 
set(handles.slider2xaxis, 'Value', 1); 
set(handles.slider2xaxis, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);

set(handles.slideryaxis, 'Min', -10); 
set(handles.slideryaxis, 'Max', -1); 
set(handles.slideryaxis, 'Value', -1); 
set(handles.slideryaxis, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);

% Update handles structure
guidata(hObject, handles);

%computer places ships on board
function [board] = shipplacer(shiplist,shiplength)

end



end
% UIWAIT makes BattleshipBoard wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BattleshipBoard_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in easy_button.
function easy_button_Callback(hObject, eventdata, handles)
% hObject    handle to easy_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

board = handles.shipplacer(shiplist, shiplength);
valid_rounds = false; 
while valid_rounds == false;
    totalrounds = input('How many guesses do you want to have? (17+)');
    if totalrounds > 17
        valid_rounds = true;
        break;
    else
        disp('Invalid number of guesses');
    end  
end

sink_count = 0;
winner = false;
current_rounds = 1;

% while player is playing, allows guesses to be checked against the
% computers randomly generated board. 
while current_rounds <= totalrounds
    [board, winner, sink_count] = playerguess(board, winner, sink_count);
    subplot(1,2,2)
    x = 1;
    y = current_rounds;
    bar(x,y,'r')
    title('Turns Used')
    current_rounds = current_rounds + 1;
end

disp('You used up all your turns! Try again next time!')
guidata(hObject, handles);
disp('Level: easy');

end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over easy_button.
function easy_button_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to easy_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end


% --- Executes on button press in medium_button.
function medium_button_Callback(hObject, eventdata, handles)
% hObject    handle to medium_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Level: medium');

[playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength);
board = shipplacer(shiplist, shiplength); 

%computer and player take turns guessing spaces. 
sink_count = 0;
winner = false;
comp_sink_count = 0;

while winner == false
   [board, winner, sink_count] = playerguess(board, winner, sink_count);
   if winner == true
       break;
   end
   disp('Time for the computer to guess');
   [playerboard, playergrid, winner, comp_sink_count] = computereasyguess(playerboard, winner, comp_sink_count);

end

end


% --- Executes on button press in hard_button.
function hard_button_Callback(hObject, eventdata, handles)
% hObject    handle to hard_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Level: hard');

%User places ships on board
%function [playerboard, playergrid] = playershipplacer(ships, shiplist, shiplength)


end


% --- Executes on button press in Fire.
function Fire_Callback(hObject, eventdata, handles)
% hObject    handle to Fire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider2xaxis, 'Value', 1);
set(handles.slideryaxis, 'Value', -1);

handles=slider2xaxis_Callback(hObject, eventdata, handles);

handles=slideryaxis_Callback(hObject, eventdata, handles);
guidata(hObject, handles); %updates globally, because reset back to (1,1)
%updatematrix(hObject, eventdata, handles);
%x = input('Enter coordinate:\n');
%handles.grid(x) = 1;
%imshow(handles.grid,'Parent', handles.axes1);
%guidata(hObject, handles);

%Function for player inputing target
x_shot = handles.slider2xaxis;
y_shot = handles.slideryaxis;

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
    subplot(1,2,1)
    playerguesses(x_shot, y_shot, :) = [1, 0, 0]; %changes square to red
    imagesc(playerguesses);
else
    is_sink = true;
    board(x_shot, y_shot) = 0;
    for i = 1:10
        for j = 1:10
            if board(i,j) == cur_val
                disp(strcat('you hit the', ' ', ship, '!'));
                is_sink = false;
                playerguesses(x_shot, y_shot, :) = [1, 1, 0];
                subplot(1,2,1)
                imagesc(playerguesses);
                break;
            end
        end
        if is_sink == false
            break;
        end
    end
    if is_sink
        disp(strcat('you sunk the', ' ', ship, '!')); %decide to keep in or remove?
        sink_count = sink_count + 1;
        playerguesses(x_shot, y_shot, :) = [0, 1, 0]; %change to green
        subplot(1,2,1)
        imagesc(playerguesses);
    end
end
if sink_count == 5
    disp('You Win!!');
    winner = true;
    return;
end




end



function savematrix(hObject, eventdata, handles))
handles.grid=

%create matrix to highlight x and y axis coordinates
function showtarget(hObject, eventdata, handles)
grid=zeros(10);
grid(handles.coordy, handles.coordx)=1;
imshow(grid ,'Parent', handles.axes1);
end

% --- Executes on slider movement.
function handles=slideryaxis_Callback(hObject, eventdata, handles)
% hObject    handle to slideryaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yaxisvalue=get(hObject,'Value')
handles.coordy=abs(yaxisvalue);
guidata(hObject, handles);
showtarget(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function slideryaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slideryaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


% --- Executes on slider movement.
function handles=slider2xaxis_Callback(hObject, eventdata, handles)
% hObject    handle to slider2xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xaxisvalue=get(hObject,'Value')
handles.coordx=xaxisvalue;
guidata(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
showtarget(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function slider2xaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end
