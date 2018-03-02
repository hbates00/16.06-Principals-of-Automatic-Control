function save_figure( fig, base_name )
%SAVE_FIGURE Summary of this function goes here
%   Detailed explanation goes here

saveas(fig, base_name);
fig.PaperOrientation = 'portrait';
print(fig, base_name, '-dpng', '-r300');
fig.PaperOrientation = 'landscape';

end

