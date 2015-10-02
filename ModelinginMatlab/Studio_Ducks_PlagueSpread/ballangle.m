function res=optimal_angle(velocity)
angles=20:70;
for i=1:length(angles)
    angle=angles(i);
    ranges(i)=range(velocity,angle);
end
plot(angles,ranges);
[m,i]=max(ranges);
best_angle=angles(i);
res=best_angle;
end

function res=range(velocity,angle)
theta=angle*pi/180;
vx=velocity*cos(theta);
vy=velocity*sin(theta);

options=odeset('Events',@events);
[T,M]=ode45(@slope, [0,100], [0,1,vx,vy], options);
X=M(:,1);
Y=M(:,2);
plot(X,Y)
res=X(end);
end

function [value,isterminal,direction]=events(t,W)
value=W(2);
isterminal=1;
direction=-1;
end

function res=slope(t,W)
R=W(1:2);
V=W(3:4);
dRdt=V;
dVdt=acceleration(t,R,V);
res=[dRdt; dVdt];
end

function res=acceleration (t,R,V)
Ag=[0;-9.8];
mass=.145;
Ad=drag_force(V)/mass;
res=Ag+Ad;
end

function Fd=drag_force(V)
C=.3;
rho=1.066;
A=.0042;
v=norm(V);
Fd=-1/2*C*rho*A*v*V;
end
