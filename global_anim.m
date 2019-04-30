clc
clear 
config_param

%% Balance Control
[K,As,Bs,Cs,Ds]  = LQR_balance(param);
sim('acrobot_simulation_v3.slx')
Animasyon_kod(Aci,tout)


plot(tout,Aci.signals.values)
grid
str = {'$$ \theta_1 $$','$$ \theta_2 $$', '$$ \dot{\theta}_1 $$','$$ \dot{\theta}_2 $$'};
legend(str, 'Interpreter','latex', 'Location','NE')