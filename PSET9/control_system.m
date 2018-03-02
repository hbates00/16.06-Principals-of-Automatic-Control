K = 14.677;

G = tf(29, [1 10 29]);
Gc = tf([1 23.76],[1 237.6]);

controlSystemDesigner(G, Gc)