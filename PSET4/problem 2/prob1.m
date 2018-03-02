close all

load('sensor_output.mat')

H_lp = tf(10, [1 10]);    % low-pass
H_hp = tf([1 0], [1 1]);  % high-pass
H_mp = H_lp * H_hp;       % multi-pass

y_lp = lsim(H_lp, y, t);
y_hp = lsim(H_hp, y, t);
y_mp = lsim(H_mp, y, t);

y_filt = [y_lp y_hp y_mp];

%% Graph it!
saveName = 'out/y_filt';

fig = std_figure(1, 'Filtered Signal as Function of Time');

for i = 1:3
    
    subplot(3,1,i)
    
    hold on
    
    plot(t, y, 'y:', 'Color', [.75 .75 0], 'Linewidth', .25);
    plot(t, y_filt(:,i), 'Linewidth', 1);
    
    hold off
    
    std_axes(gca);
    
    xlim([0 60])
    ylim([-10 10])
    
    xlabel('t [s]');
    
    switch i
        case 1
            title('Low-pass Filter');
            ylabel('y_{lp}(t)');
            legend('Unfiltered', 'Filtered');
        case 2
            title('High-pass Filter');
            ylabel('y_{hp}(t)');
        case 3
            title('Multi-pass Filter');
            ylabel('y_{mp}(t)');
        otherwise
            error('Wat are u do')
    end
    
end

save_figure(fig, saveName);
