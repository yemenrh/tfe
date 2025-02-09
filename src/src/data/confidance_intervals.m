%% IQL vs RIAL-10m recomp plus var msg
clear; close all; clc; 
width_var = 500; 
transparency = 0.2; 
factor = 0.5; 
startting_test = 8000; 
data_1 = xlsread("RIAL_2m_blue_down_30000eps.xlsx"); 
data_2 = xlsread("no_com.xlsx"); 
episodes_data_1 = data_1(1:1e4, 4);
episodes_data_2 = data_2(1:1e4, 4);


reward_1 = data_1(1:1e4, 3);
reward_2 = data_2(1:1e4, 3);

ncycles_1 = data_1((3e4+1):4e4, 3);
ncycles_2 = data_2((3e4+1):4e4, 3);

loss_1 = data_1((2e4+1):3e4, 3);
loss_2 = data_2((2e4+1):3e4, 3);


[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);

[variance_reward_1, mean_data_reward_1] = compute_variation_mean(reward_1, width_var);
[variance_reward_2, mean_data_reward_2] = compute_variation_mean(reward_2, width_var);


figure('Name','variation comutation')
hold on 
semilogy(episodes_data_1, mean_data_reward_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_reward_1 -  factor * variance_reward_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_reward_1 +  factor *variance_reward_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_reward_1 - factor* variance_reward_1); flip(mean_data_reward_1 + factor * variance_reward_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_reward_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_reward_2 -  factor * variance_reward_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_reward_2 +  factor *variance_reward_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_reward_2 -  factor * variance_reward_2); flip(mean_data_reward_2 + factor * variance_reward_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 3e5])
grid on 
grid minor
xlabel('épisodes','Interpreter','latex')
ylabel('la moyenne de r','Interpreter','latex')
title('Comparaison de la moyenne entre RIAL-2m et IQL','Interpreter','latex')
legend('La moyenne des récompenses RIAL-2m','','','La variation autour de la moyenne RIAL-2m ','La moyenne des récompenses pour IQL','','','La variation autour de la moyenne IQL ','location','southeast','Interpreter','latex')
print('IQL vs RIAL-2m variances','-dpng')

[h_reward,p_reward,ci,stats] = ttest2(reward_1(startting_test:end), reward_2(startting_test:end))
%% RIAL 2m vs RIAL 10 m 

clear; close all; clc; 
width_var = 500; 
transparency = 0.2; 
factor = 0.5; 
startting_test = 6e3; 

data_1 = xlsread("RIAL_2m_blue_down_30000eps.xlsx"); 
data_2 = xlsread("RIAL_10m_blue_up.xlsx"); 
episodes_data_1 = data_1(1:1e4, 4);
episodes_data_2 = data_2(1:1e4, 4);


reward_1 = data_1(1:1e4, 3);
reward_2 = data_2(1:1e4, 3);

ncycles_1 = data_1((3e4+1):4e4, 3);
ncycles_2 = data_2((3e4+1):4e4, 3);

loss_1 = data_1((2e4+1):3e4, 3);
loss_2 = data_2((2e4+1):3e4, 3);


[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);

[variance_reward_1, mean_data_reward_1] = compute_variation_mean(reward_1, width_var);
[variance_reward_2, mean_data_reward_2] = compute_variation_mean(reward_2, width_var);

[h_reward,p_reward,ci,stats] = ttest2(reward_1(startting_test:end), reward_2(startting_test:end))

figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_reward_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_reward_1 -  factor * variance_reward_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_reward_1 +  factor *variance_reward_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_reward_1 - factor* variance_reward_1); flip(mean_data_reward_1 + factor * variance_reward_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_reward_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_reward_2 -  factor * variance_reward_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_reward_2 +  factor *variance_reward_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_reward_2 -  factor * variance_reward_2); flip(mean_data_reward_2 + factor * variance_reward_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 3e5])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize  =15;
b = ylabel('la moyenne de r','Interpreter','latex'); b.FontSize = 15; 
title('Comparaison de la moyenne entre RIAL-2m et RIAL-10m','Interpreter','latex','FontSize',15)
legend('La moyenne des récompenses RIAL-2m','','','La variation autour de la moyenne RIAL-2m ','La moyenne des récompenses pour RIAL-10m','','','La variation autour de la moyenne RIAL-10m ','location','southeast','Interpreter','latex')
print('RIAm-10m vs RIAL-2m moyenne r','-dpng')

[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);
figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_ncycle_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_ncycle_1 -  factor * variance_ncycles_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_ncycle_1 +  factor *variance_ncycles_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_ncycle_1 - factor* variance_ncycles_1); flip(mean_data_ncycle_1 + factor * variance_ncycles_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_ncycle_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_ncycle_2 -  factor * variance_ncycles_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_ncycle_2 +  factor *variance_ncycles_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_ncycle_2 -  factor * variance_ncycles_2); flip(mean_data_ncycle_2 + factor * variance_ncycles_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 3e5])
grid on  
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize = 15; 
b = ylabel('la moyenne de r','Interpreter','latex'); b.FontSize = 15; 
title('Comparaison de la moyenne entre RIAL-2m et RIAL-10m','Interpreter','latex','FontSize',15)
legend('La moyenne des récompenses RIAL-2m','','','La variation autour de la moyenne RIAL-2m ','La moyenne des récompenses pour RIAL-10m','','','La variation autour de la moyenne RIAL-10m ','location','northeast','Interpreter','latex')
print('RIAm-10m vs RIAL-2m n cycles','-dpng')
[h_ncycles,p_ncycles,ci,stats] = ttest2(ncycles_1(startting_test:end), ncycles_2(startting_test:end))
%% RIAL 2m vs RIAL 10 m 

clear; close all; clc; 
width_var = 500; 
transparency = 0.2; 
factor = 0.5; 
startting_test = 6e3; 

data_1 = xlsread("RIAL_Qvalues_blue_down.xlsx"); 
data_2 = xlsread("RIAL_10m_blue_up.xlsx"); 
episodes_data_1 = data_1(1:1e4, 4);
episodes_data_2 = data_2(1:1e4, 4);


reward_1 = data_1(1:1e4, 3);
reward_2 = data_2(1:1e4, 3);

ncycles_1 = data_1((3e4+1):4e4, 3);
ncycles_2 = data_2((3e4+1):4e4, 3);

loss_1 = data_1((2e4+1):3e4, 3);
loss_2 = data_2((2e4+1):3e4, 3);


[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);

[variance_reward_1, mean_data_reward_1] = compute_variation_mean(reward_1, width_var);
[variance_reward_2, mean_data_reward_2] = compute_variation_mean(reward_2, width_var);

[h_reward,p_reward,ci,stats] = ttest2(reward_1(startting_test:end), reward_2(startting_test:end))

figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_reward_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_reward_1 -  factor * variance_reward_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_reward_1 +  factor *variance_reward_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_reward_1 - factor* variance_reward_1); flip(mean_data_reward_1 + factor * variance_reward_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_reward_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_reward_2 -  factor * variance_reward_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_reward_2 +  factor *variance_reward_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_reward_2 -  factor * variance_reward_2); flip(mean_data_reward_2 + factor * variance_reward_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize = 15; 
b = ylabel('la moyenne de r','Interpreter','latex'); b.FontSize = 15; 
title('Comparaison de la moyenne entre RIAL-Qvalues et RIAL-10m','Interpreter','latex','FontSize',14)
legend('La moyenne des récompenses RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne des récompenses pour RIAL-10m','','','La variation autour de la moyenne RIAL-10m ','location','southeast','Interpreter','latex')
print('RIAL Qvalues vs RIAL-10m recompenses','-dpng')

[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);
figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_ncycle_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_ncycle_1 -  factor * variance_ncycles_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_ncycle_1 +  factor *variance_ncycles_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_ncycle_1 - factor* variance_ncycles_1); flip(mean_data_ncycle_1 + factor * variance_ncycles_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_ncycle_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_ncycle_2 -  factor * variance_ncycles_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_ncycle_2 +  factor *variance_ncycles_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_ncycle_2 -  factor * variance_ncycles_2); flip(mean_data_ncycle_2 + factor * variance_ncycles_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize= 15; 
b = ylabel('la moyenne de n-cycles','Interpreter','latex'); b.FontSize = 15; 
title('Comparaison de la moyenne entre RIAL-Qvalues et RIAL-10m','Interpreter','latex','FontSize',14)
legend('La moyenne des récompenses RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne des récompenses pour RIAL-10m','','','La variation autour de la moyenne RIAL-10m ','location','northeast','Interpreter','latex')
print('RIAL Qvalues vs RIAL-10m ncycles.png','-dpng')
[h_ncycles,p_ncycles,ci,stats] = ttest2(ncycles_1(startting_test:end), ncycles_2(startting_test:end))

%% RIAL Action vs RIAL 10m
clear; close all; clc; 
width_var = 500; 
transparency = 0.2; 
factor = 0.5; 
startting_test = 6e3; 

data_1 = xlsread("RIAL_Qvalues_blue_down.xlsx"); 
data_2 = xlsread("RIAL_Action_blue_up.xlsx"); 
episodes_data_1 = data_1(1:1e4, 4);
episodes_data_2 = data_2(1:1e4, 4);


reward_1 = data_1(1:1e4, 3);
reward_2 = data_2(1:1e4, 3);

ncycles_1 = data_1((3e4+1):4e4, 3);
ncycles_2 = data_2((3e4+1):4e4, 3);

loss_1 = data_1((2e4+1):3e4, 3);
loss_2 = data_2((2e4+1):3e4, 3);


[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);

[variance_reward_1, mean_data_reward_1] = compute_variation_mean(reward_1, width_var);
[variance_reward_2, mean_data_reward_2] = compute_variation_mean(reward_2, width_var);

[h_reward,p_reward,ci,stats] = ttest2(reward_1(startting_test:end), reward_2(startting_test:end))

figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_reward_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_reward_1 -  factor * variance_reward_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_reward_1 +  factor *variance_reward_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_reward_1 - factor* variance_reward_1); flip(mean_data_reward_1 + factor * variance_reward_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_reward_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_reward_2 -  factor * variance_reward_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_reward_2 +  factor *variance_reward_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_reward_2 -  factor * variance_reward_2); flip(mean_data_reward_2 + factor * variance_reward_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize = 15; 
b = ylabel('la moyenne de r','Interpreter','latex'); b.FontSize = 15; 
title({'Comparaison de la moyenne entre',' RIAL-Action et RIAL-Qvalues'},'Interpreter','latex','FontSize',15)
legend('La moyenne des récompenses RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne des récompenses pour RIAL-Action','','','La variation autour de la moyenne RIAL-Action','location','southeast','Interpreter','latex')
print('RIAL Action vs RIAL-Qvalues recompenses','-dpng')


figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_ncycle_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_ncycle_1 -  factor * variance_ncycles_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_ncycle_1 +  factor *variance_ncycles_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_ncycle_1 - factor* variance_ncycles_1); flip(mean_data_ncycle_1 + factor * variance_ncycles_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_ncycle_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_ncycle_2 -  factor * variance_ncycles_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_ncycle_2 +  factor *variance_ncycles_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_ncycle_2 -  factor * variance_ncycles_2); flip(mean_data_ncycle_2 + factor * variance_ncycles_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a =xlabel('épisodes','Interpreter','latex'); a.FontSize= 15; 
b = ylabel('la moyenne de n-cycles','Interpreter','latex'); b.FontSize = 15; 
title({'Comparaison de la moyenne entre ','RIAL-Qvalues et RIAL-Action'},'Interpreter','latex','FontSize',15)
legend('La moyenne de n-cycles RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne de n-cycles pour RIAL-Action','','','La variation autour de la moyenne RIAL-Action','location','northeast','Interpreter','latex')
print('RIAL Action vs RIAL-Qvalues n cycles','-dpng')
[h_ncycles,p_ncycles,ci,stats] = ttest2(ncycles_1(startting_test:end), ncycles_2(startting_test:end))
%% VDN vs RIAL-10
clear; close all; clc; 
width_var = 500; 
transparency = 0.2; 
factor = 0.5; 
startting_test = 6e3; 

data_1 = xlsread("RIAL_Qvalues_blue_down.xlsx"); 
data_2 = xlsread("VDN_test.xlsx"); 
episodes_data_1 = data_1(1:1e4, 4);
episodes_data_2 = data_2(1:1e4, 4);


reward_1 = data_1(1:1e4, 3);
reward_2 = data_2(1:1e4, 3);

ncycles_1 = data_1((3e4+1):4e4, 3);
ncycles_2 = data_2((3e4+1):4e4, 3);

loss_1 = data_1((2e4+1):3e4, 3);
loss_2 = data_2((2e4+1):3e4, 3);


[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);

[variance_reward_1, mean_data_reward_1] = compute_variation_mean(reward_1, width_var);
[variance_reward_2, mean_data_reward_2] = compute_variation_mean(reward_2, width_var);

[h_reward,p_reward,ci,stats] = ttest2(reward_1(startting_test:end), reward_2(startting_test:end))

figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_reward_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_reward_1 -  factor * variance_reward_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_reward_1 +  factor *variance_reward_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_reward_1 - factor* variance_reward_1); flip(mean_data_reward_1 + factor * variance_reward_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_reward_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_reward_2 -  factor * variance_reward_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_reward_2 +  factor *variance_reward_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_reward_2 -  factor * variance_reward_2); flip(mean_data_reward_2 + factor * variance_reward_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize = 15; 
b = ylabel('la moyenne de r','Interpreter','latex'); b.FontSize = 15; 
title({'Comparaison de la moyenne des recompenses ','entre VDN-NO-Com et RIAL-Qvalues'},'Interpreter','latex','FontSize',15)
legend('La moyenne des récompenses RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne des récompenses pour VDN-NO-Com','','','La variation autour de la moyenne VDN-NO-Com','location','southeast','Interpreter','latex')
print('VDN no com vs RIAL-Qvalues recompense','-dpng')


figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_ncycle_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_ncycle_1 -  factor * variance_ncycles_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_ncycle_1 +  factor *variance_ncycles_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_ncycle_1 - factor* variance_ncycles_1); flip(mean_data_ncycle_1 + factor * variance_ncycles_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_ncycle_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_ncycle_2 -  factor * variance_ncycles_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_ncycle_2 +  factor *variance_ncycles_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_ncycle_2 -  factor * variance_ncycles_2); flip(mean_data_ncycle_2 + factor * variance_ncycles_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize = 15; 
b = ylabel('la moyenne de n-cycles','Interpreter','latex'); b.FontSize = 15; 
title({'Comparaison de la moyenne du nombre de cycles','entre RIAL-Qvalues et VDN-NO-Com'},'Interpreter','latex','FontSize',15)
legend('La moyenne de n-cycles RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne de n-cycles pour VDN-NO-Com','','','La variation autour de la moyenne VDN-NO-Com','location','northeast','Interpreter','latex')
print('VDN no com vs RIAL-Qvalues n cycles','-dpng')
[h_ncycles,p_ncycles,ci,stats] = ttest2(ncycles_1(startting_test:end), ncycles_2(startting_test:end))
%% VDN vs VDN avec la communication
clear; close all; clc; 
width_var = 500; 
transparency = 0.2; 
factor = 0.5; 
startting_test = 6e3; 

data_1 = xlsread("VDN_True_Action_Com.xlsx"); 
data_2 = xlsread("VDN_test.xlsx"); 
episodes_data_1 = data_1(1:1e4, 4);
episodes_data_2 = data_2(1:1e4, 4);


reward_1 = data_1(1:1e4, 3);
reward_2 = data_2(1:1e4, 3);

ncycles_1 = data_1((3e4+1):4e4, 3);
ncycles_2 = data_2((3e4+1):4e4, 3);

loss_1 = data_1((2e4+1):3e4, 3);
loss_2 = data_2((2e4+1):3e4, 3);


[variance_ncycles_1, mean_data_ncycle_1] = compute_variation_mean(ncycles_1, width_var);
[variance_ncycles_2, mean_data_ncycle_2] = compute_variation_mean(ncycles_2, width_var);

[variance_reward_1, mean_data_reward_1] = compute_variation_mean(reward_1, width_var);
[variance_reward_2, mean_data_reward_2] = compute_variation_mean(reward_2, width_var);

[h_reward,p_reward,ci,stats] = ttest2(reward_1(startting_test:end), reward_2(startting_test:end))

figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_reward_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_reward_1 -  factor * variance_reward_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_reward_1 +  factor *variance_reward_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_reward_1 - factor* variance_reward_1); flip(mean_data_reward_1 + factor * variance_reward_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_reward_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_reward_2 -  factor * variance_reward_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_reward_2 +  factor *variance_reward_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_reward_2 -  factor * variance_reward_2); flip(mean_data_reward_2 + factor * variance_reward_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
xlabel('épisodes','Interpreter','latex')
ylabel('la moyenne de r','Interpreter','latex')
title({'Comparaison de la moyenne des recompenses ','entre VDN-NO-Com et RIAL-Qvalues'},'Interpreter','latex')
legend('La moyenne des récompenses RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne des récompenses pour VDN-NO-Com','','','La variation autour de la moyenne VDN-NO-Com','location','southeast','Interpreter','latex')
print('VDN no com vs RIAL-Qvalues recompense.png','-dpng')


figure('Name','recompense')
hold on 
semilogy(episodes_data_1, mean_data_ncycle_1, 'LineWidth',2) 
semilogy(episodes_data_1, mean_data_ncycle_1 -  factor * variance_ncycles_1 , 'r','LineWidth',1)
semilogy(episodes_data_1, mean_data_ncycle_1 +  factor *variance_ncycles_1 , 'r','LineWidth',1)

patch([episodes_data_1 ;flip(episodes_data_1)], [(mean_data_ncycle_1 - factor* variance_ncycles_1); flip(mean_data_ncycle_1 + factor * variance_ncycles_1)], ...
                        'r','FaceAlpha',transparency)

semilogy(episodes_data_2, mean_data_ncycle_2, 'LineWidth',2) 
semilogy(episodes_data_2, mean_data_ncycle_2 -  factor * variance_ncycles_2 , 'b','LineWidth',1)
semilogy(episodes_data_2, mean_data_ncycle_2 +  factor *variance_ncycles_2 , 'b','LineWidth',1)

patch([episodes_data_2 ;flip(episodes_data_2)], [(mean_data_ncycle_2 -  factor * variance_ncycles_2); flip(mean_data_ncycle_2 + factor * variance_ncycles_2)], ...
                        'b','FaceAlpha',transparency)
xlim([0, 285268])
grid on 
grid minor
a = xlabel('épisodes','Interpreter','latex'); a.FontSize = 15; 
ylabel('la moyenne de n-cycles','Interpreter','latex'); b.FontSize = 15; 
title({'Comparaison de la moyenne du nombre de cycles','entre RIAL-Qvalues et VDN-NO-Com'},'Interpreter','latex','FontSize',15)
legend('La moyenne des n-cycles RIAL-Qvalues','','','La variation autour de la moyenne RIAL-Qvalues ','La moyenne des n-cycles pour VDN-NO-Com','','','La variation autour de la moyenne VDN-NO-Com','location','northeast','Interpreter','latex')
print('VDN no com vs  n cycles','-dpng')
[h_ncycles,p_ncycles,ci,stats] = ttest2(ncycles_1(startting_test:end), ncycles_2(startting_test:end))