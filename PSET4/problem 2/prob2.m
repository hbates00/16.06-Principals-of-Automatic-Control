close all

m = 2;
b = 1;
k = .5;

G = tf(1, [m b k]);

t_start = 0;
t_res = .025;  % time resolution
t_end = 70;

t = t_start:t_res:t_end;

old_pref = sympref('HeavisideAtOrigin', 1);
f = heaviside(t-2) - heaviside(t-32);
sympref('HeavisideAtOrigin', old_pref);
clear old_pref

x = lsim(G, f, t);
[maxima, i_max] = findpeaks( x);
[minima, i_min] = findpeaks(-x);
minima = -minima;

extrema = [maxima; minima];
t_extrema = t([i_max; i_min]);
[t_extrema, i_extrema] = sort(t_extrema);
extrema = extrema(i_extrema);

%% Response Parameters
os = (extrema(1) - extrema(5)) / extrema(5);
zeta = sqrt(log(os)^2/(pi^2 + log(os)^2));
T_p = t_extrema(1);
omega_n = pi/(T_p*sqrt(1-zeta^2));
T_s = 4/(zeta*omega_n);
T_r = (1 + 1.1*zeta + 1.4*zeta^2)/omega_n;

fprintf('\n\n')
fprintf('=======================\n')
fprintf('i.)   OS =      %6.3f\n', round(os, 3))
fprintf('ii.)  zeta =    %6.3f\n', round(zeta, 3))
fprintf('iii.) T_p =     %6.3f\n', round(T_p, 3))
fprintf('iv.)  omega_n = %6.3f\n', round(omega_n, 3))
fprintf('v.)   T_s =     %6.3f\n', round(T_s, 3))
fprintf('vi.)  T_r =     %6.3f\n', round(T_r, 3))

%% Plot it!
fig = std_figure(1, 'Open-Loop Response of G(s)');

xt_off = 0;
yt_off = -.1;
y_stag = .2;

hold on
plot(t, x);
plot(t, f, 'g--', 'Color', [.5 .5 .5]);
scatter(t_extrema, extrema, 'x');

for i = 1:length(t_extrema)
    
    data_t = t_extrema(i);
    data_x = extrema(i);
    
    px = data_t + xt_off;
    py = data_x + yt_off + y_stag * mod(i, 2);
    
    text_str = ['('  num2str(data_t) ...
                ', ' num2str(round(data_x, 2)) ')'];
            
    text(px, py, text_str, 'HorizontalAlignment', 'right', 'Color', .75*[1 .5 0]);
    
end

hold off

std_axes(gca);

title('Open Loop Response of G(s)');
xlabel('Time [s]');
ylabel('System Response');

legend('x(t)', 'f(t) [N]');

save_figure(fig, 'out/ol_response');

