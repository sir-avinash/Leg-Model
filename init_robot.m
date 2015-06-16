% init_leg

leg.I1 = 0.66;
leg.I2 = 0.33;
leg.I3  = 0.33;
leg.m1 = 2.25;
leg.m2 = 5.2;
leg.m3 = 15;
leg.l1max= 0.3;
leg.d2 = 0.15;
leg.l2 = 0.3;
leg.l3 = 0.2;

leg.spring.Ksp = 2e3;
leg.spring.Ksp2 = 5e5;
leg.spring.kmax = 0.28;
leg.spring.Kb = 1e3;
leg.spring.k0 = 0.25;
leg.damper.Kd = 1e3;

leg.l1min = leg.l1max - leg.spring.k0;
leg.g = 9.81;


