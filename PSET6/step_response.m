
g1 = tf([25], [1, 3, 25]);
g2 = tf([25, -25], [1, 3, 25]);
g3 = tf([25, -25], [1, 2, 22, -25]);
g4 = tf([25, 0, -25], [1, 2, 22, -25]);

x= linspace(0, 4, 10000);
f = heaviside(x);

subplot(2, 2, 1)
step(g1)
hold on
plot(x, f, 'Color', [.17 .17 .17])
title('G1 Response to Step Function')

subplot(2, 2, 2)
step(g2)
hold on
plot(x, f, 'Color', [.17 .17 .17])
title('G2 Response to Step Function')

subplot(2, 2, 3)
step(g3)
hold on
plot(x, f, 'Color', [.17 .17 .17])
title('G3 Response to Step Function')

subplot(2, 2, 4)
step(g4)
hold on
plot(x, f, 'Color', [.17 .17 .17])
title('G4 Response to Step Function')
