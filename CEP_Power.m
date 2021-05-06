clc
clear all
close all

%% Intitial Comments
%{
AEM-360-001, Spring 2021
CEP Project - Team Voyager

From Space Mission Analysis and Design, 3rd edition (Wertz, Larson)
Table 11-34, p412
%}

%% Inputs - FireSat Example

%{
%power requirement and environment
pe = 110; %W
pd  = 110; %W
te = 35.3; %min
td = 63.5; %min
theta = 23.5; %deg %FIXME might not need
lifetime = 5; %years

%solar array
sa = ["FireSat"];
xe = [0.6];
xd = [0.8];
eff = [0.148];
I_d = [0.77];
degradation = [0.0375]; %degradation per year
mpa = [84, 84, 49]; %mg/cm^2 %not given for FireSat - using Z4-J input as test
mpa = mpa*0.01; %kg/m^2
%}

%% Inputs - Team Voyager

%power requirement and environment
pe = 2500; %W 
pd = 2500; %W
te = 15; %days
td = 15; %days
theta = 23.5; %deg
lifetime = 2; %years, manned

%solar array
sa = ["Z4-J","PV XTJ","IMM alpha","ZTJ","GJ 4G32C","TJ 3G30C - Advanced","TJ 3G30C - (80?m)","Silicon S 32","XTE-SF","UTJ","CTJ30","CTJ-LC","CTJ30 Thin"];
eff = [0.3,0.295,0.32,0.295,0.32,0.3,0.3,0.169,0.322,0.284,0.295,0.28,0.29];
I_d = 0.77*ones(1,length(sa));
xe = 0.6*ones(1,length(sa)); %assume it's direct tracking
xd = 0.8*ones(1,length(sa));
degradation = [0.005,0.005,0.005,0.005,0.005,0.005,0.005,0.0375,0.005,0.005,0.005,0.005,0.005]; %degradation per year
mpa = [84,84,49,84,58.98,88.65,50,32,84,84,89,89,50]; %mg/cm^2
mpa = mpa*0.01; %kg/m^2

%% Power Source

for i = 1:length(sa)
    [P_SA,P_BOL,k,A] = find_SA(pe,pd,te,td,xe(i),xd(i),eff(i),I_d(i),theta,degradation(i),lifetime);
    if i == 1
        fprintf("Power necessary to full charge the rover's batteries for 1 month: %0.0f W\n\n", P_SA);
    end 
    
    fprintf('For the %s solar array:\n',sa(i));
	fprintf("Solar array power output at BOL: %0.0f W/m^s\n", P_BOL);
    fprintf("Solar array size: %f m^2\n", A);
    m = mpa(i)*A;
    fprintf("Mass of solar cells: %f kg\n\n", m);
end 

fprintf('AEM 360 - CEP - Voyager script complete. --------------------------------------------------\n\n');