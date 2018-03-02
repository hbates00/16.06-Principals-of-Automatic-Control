
sys1 = tf([1 5.4229], [1 54.229])
sys2 = tf([10],[1 15 50 0])

sys = sys1*sys2

rlocus(sys)