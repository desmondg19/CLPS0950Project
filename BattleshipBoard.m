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
%

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
%BattleshipBoard_OpeningFcn initializes several attributes to the handles
%variable

set(handles.text2, 'String', "Let's Play Battleship!");
set(handles.rounds_left, 'String', '30');
set(handles.ships_sunk, 'String', '0');
handles.tracker = zeros(10);
% Choose default command line output for BattleshipBoard

handles.output = hObject;

%This initializes the gameboard that is visible to the user throughout
%gameplay
handles.grid=uint8(zeros(10, 10, 3)+128); 
handles.coordx=1;
handles.coordy=1;

%This initializes the ship types, names, and lengths and lengths
handles.shiplist = [char("C"), char("B"), char("R"), char("S"), char("D")];
handles.shiplength = [5, 4, 3, 3, 2];
handles.ships= [" Carrier", " Battleship", " Cruiser", " Submarine", " Destroyer"];

%This code sets the sliders to move by increments of 1 from 1-10
numSteps=10; 

set(handles.slider2xaxis, 'Min', 1); 
set(handles.slider2xaxis, 'Max', numSteps); 
set(handles.slider2xaxis, 'Value', 1); 
set(handles.slider2xaxis, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);

set(handles.slideryaxis, 'Min', -10); 
set(handles.slideryaxis, 'Max', -1); 
set(handles.slideryaxis, 'Value', -1); 
set(handles.slideryaxis, 'SliderStep', [1/(numSteps-1) , 1/(numSteps-1) ]);

imshow(handles.grid,'Parent', handles.axes1);

% Update handles structure
guidata(hObject, handles);



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
%When users press the green start button, the ships will be randomly placed on the board. The location of the ships are not visible to the user.
handles.board = shipplacer(handles.shiplist, handles.shiplength);
handles.totalrounds = 30;
handles.sink_count = 0;
handles.winner = false;
handles.current_rounds = 1;
guidata(hObject, handles);
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over easy_button.
function easy_button_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to easy_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end




% --- Executes on button press in Fire.
function Fire_Callback(hObject, eventdata, handles)
%When the red fire button is pressed, the coordinates that the user has
%selected are compared to the coordinates of the ship locations. If the
%user successfully hits a ship, the square will turn yellow. If the user
%sinks a ship, the squares will turn green. If the user misses, the square
%will turn red. Everytime the fire button is pressed, the number of shots
%they have left will decrease by 1. After all 30 shots have been fired,
%they will not be able to aim at new coordinates.
if handles.current_rounds<=30
  handles=GUI_playerguess(handles); 
  guidata(hObject, handles); 
  if handles.current_rounds==31 && handles.sink_count~=5
    set(handles.text2, 'String', 'You Lose :(');
  end
end

end



function showtarget(hObject, eventdata, handles)
%The showtarget function creates a matrix that displays the current game
%state (the user's hits, sinks, and misses), and highlights the square that
%they are currently aiming at with the sliders.

 grid=uint8(zeros(10,10,3));
 grid(handles.coordy, handles.coordx, :)=255;
 %The following code clears the current properties displayed on the axes
 %and shows the game state and the current location of the sliders
 cla(handles.axes1); %clears properties of axes
 imshow(handles.grid ,'Parent', handles.axes1); 
 hold on 
 h=imshow(grid ,'Parent', handles.axes1); %show the slider location
 set(h,'AlphaData', .1); 
 
grid=uint8(zeros(10,10,3) + .03 );
grid(handles.coordy, handles.coordx, :)=255; 
 
cla(handles.axes1)
 h=imshow(handles.grid ,'Parent', handles.axes1);
 h=imshow(grid ,'Parent', handles.axes1);
 
 set(h,'AlphaData', .05);


end
 

% --- Executes on slider movement.
function handles=slideryaxis_Callback(hObject, eventdata, handles)
%This function controls the slider along the y-axis

yaxisvalue=get(hObject,'Value')
handles.coordy=abs(yaxisvalue);
showtarget(hObject, eventdata, handles)
guidata(hObject, handles);


end

% --- Executes during object creation, after setting all properties.
function slideryaxis_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end


% --- Executes on slider movement.
function handles=slider2xaxis_Callback(hObject, eventdata, handles)
%This function controls the slider along the x-axis
xaxisvalue=get(hObject,'Value')
handles.coordx=xaxisvalue;

showtarget(hObject, eventdata, handles)
guidata(hObject, handles);
 
end

% --- Executes during object creation, after setting all properties.
function slider2xaxis_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end
