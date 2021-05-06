function [P_sa,P_BOL,k,A_sa] = find_SA(pe,pd,te,td,xe,xd,eff,I_d,theta,degradation,lifetime)

P_sa = (((pe*te)/xe)+((pd*td)/xd))/(td);
P_O = eff*1367; %lunar solar constant - W/m^2
P_BOL = P_O*I_d*cosd(theta);
k = eff*I_d*cosd(theta);
L_d = (1-degradation)^(lifetime);
P_EOL = P_BOL*L_d;
A_sa = P_sa/P_EOL; 

end
