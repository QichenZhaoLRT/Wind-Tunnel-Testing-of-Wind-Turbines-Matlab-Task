clear all
close all
clc
load("C:\Users\29453\OneDrive\桌面\ME Master\Hochschulpraktikum Wind tunnel testing of wind turbines\exercise\LookUpTable_G1_ws_26_27.mat")
%%
reynolds = Reynolds.RN; % list reynolds numbers 
data = Reynolds.LookUp{4}; % choose 90,000 reynolds
%% Task 1
radial_position = data.rm;
chord = data.cord;
R = 0.55;
close all
figure(1)
plot(radial_position/R, chord,'LineWidth',1.5)
xlabel('r/R [-]')
ylabel('Chord [m]')



%% Task 2

cp = data.Cp; % array 2D
ct = data.Cf; % array 2D
tsr = data.TSR;
pitch = data.Pitch;

[Cp_max, idx] = max(cp(:));

[row,col] = ind2sub(size(cp),idx);

lambda_opt = tsr(row);
theta_opt = pitch(col);

fprintf('Maximum Cp = %.4f\n',Cp_max)
fprintf('Optimal TSR = %.2f\n',lambda_opt)
fprintf('Optimal Pitch = %.2f deg\n',theta_opt)


figure

contourf(pitch,tsr,cp,20)

xlabel('Pitch Angle [deg]')
ylabel('TSR [-]')
title('Power Coefficient C_p')

colorbar



%% Task 5

RN = Reynolds.RN;

num_RN = length(RN);

Cp_max_all = zeros(num_RN,1);

for i = 1:num_RN

    data = Reynolds.LookUp{i};

    cp = data.Cp;

    Cp_max_all(i) = max(cp(:));

end

figure
plot(RN,Cp_max_all,'o-','LineWidth',1.5)

xlabel('Reynolds Number')
ylabel('Maximum C_p')
title('Maximum C_p vs Reynolds Number')

grid on

n=10
for i = 1:n

    fprintf('Re = %.0f, Cpmax = %.4f, lambda = %.2f, pitch = %.2f\n',...
        RN(i),...
        Cp_max_all(i),...
        lambda_opt_all(i),...
        theta_opt_all(i));

end


%% Task 6

radius = data.Alpha.SectionRadius;

N = length(radius);

alpha_dist = zeros(N,1);
axial_dist = zeros(N,1);

for k = 1:N

    alpha_dist(k) = data.Alpha.Airstation{k}(row,col);

    axial_dist(k) = data.Ax_bed(row,col,k);

end


figure

plot(radius/R,...
     alpha_dist,...
     'LineWidth',1.5)

xlabel('r/R [-]')
ylabel('Angle of Attack [deg]')

title('Angle of Attack Distribution')

grid on


figure

plot(radius/R,...
     axial_dist,...
     'LineWidth',1.5)

xlabel('r/R [-]')
ylabel('Axial Induction a [-]')

title('Axial Induction Distribution')

grid on


figure

subplot(2,1,1)

plot(radius/R,alpha_dist,'LineWidth',1.5)

xlabel('r/R [-]')
ylabel('\alpha [deg]')

title('Angle of Attack')
grid on

subplot(2,1,2)

plot(radius/R,axial_dist,'LineWidth',1.5)

xlabel('r/R [-]')
ylabel('a [-]')

title('Axial Induction')
grid on