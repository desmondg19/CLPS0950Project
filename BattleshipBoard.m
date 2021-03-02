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

% Last Modified by GUIDE v2.5 01-Mar-2021 21:24:07

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
handles.gamestate=zeros(100);
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

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('Level: easy');

end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Level: medium');
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Level: hard');
end
