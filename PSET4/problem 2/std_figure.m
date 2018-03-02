function fig = std_figure( fig_num, title )
%STD_FIGURE Summary of this function goes here
%   Detailed explanation goes here

fig = figure(fig_num);

fig.PaperUnits = 'inches';
fig.PaperPosition = [.25 .25 10.5 8];
fig.PaperOrientation = 'landscape';
fig.Units = 'Pixels';
fig.InnerPosition = print_accurate(fig);

if( nargin == 2 )
    fig.Name = title;
end

fig.NumberTitle = 'off';

end

