function result = print_accurate( ...
    figure, fig_margin, fig_offset )
%PRINT_ACCURATE Get inner figure dimensions that are print-accurate and use
%most availabe screen space.
%   Detailed explanation goes here

narginchk(1,inf);

if( nargin < 3 )
    fig_offset = [0 0];
end

if( nargin < 2 )
    fig_margin = 100;
end

% Get graphics root object
gr = groot;

% Screen and paper aspect ratios
winAR = gr.ScreenSize(3)/gr.ScreenSize(4);
figAR = figure.PaperPosition(3)/figure.PaperPosition(4);

% Width-restricted case
if( winAR < figAR )
    
    figHalfWidth = gr.ScreenSize(3)/2 - fig_margin;
    figHalfHeight = figHalfWidth / figAR;
    
% Height-restricted case
else
    
    figHalfHeight = gr.ScreenSize(4)/2 - fig_margin;
    figHalfWidth = figHalfHeight * figAR;
    
end
                           
figCenterX = gr.ScreenSize(3)/2 + fig_offset(1);
figCenterY = gr.ScreenSize(4)/2 + fig_offset(2);

left = figCenterX - figHalfWidth;
right = figCenterY - figHalfHeight;
width = 2*figHalfWidth;
height = 2*figHalfHeight;

result = [ left right width height ];

end

