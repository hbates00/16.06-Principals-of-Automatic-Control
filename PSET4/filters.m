lowpass = tf(10, [1 10]);
highpass = tf([1, 0], [1 1]);

llow = lsim(lowpass, y, t)
lhigh = lsim(highpass, y, t)
both = lsim((lowpass * highpass), y, t)


figure;

subplot(3, 1, 1);
plot(t, llow);
title('Low-Pass Filter');

subplot(3, 1, 2);   
plot(t, lhigh);
title('High-Pass Filter');

subplot(3, 1, 3);
plot(t, both);
title('Both Filters');