m = 2;
b = 1;
k = 0.5;

t_start = 0;
t_step = 0.5;
t_end = 70;

t = t_start:t_step:t_end;

G = tf(1, [m b k]);

f = heaviside(t-2) - heaviside(t-32);

response = lsim(G, f, t);

plot(t, response);
title('Open Loop Response')
ylabel('Amplitude')
xlabel('Time')


