function res=orbit(t)
[T,M]=ode45(@slope, [0,200000000], [1.5*10^11, 0, 0,30000])
X=M(:,1);
Y=M(:,2);
plot(X,Y)
end

function res=slope(t,W)
M1=2*10^30;
M2=10^27;
P2=W(1:2);
V=W(3:4);


dP2dt=V;
dVdt=acceleration(t, M1,M2,P2);
res=[dP2dt; dVdt];

end

function res=acceleration(t,M1,M2,P2)
res=Force_planet(M1,M2,P2)/M2;
end


function res=Force_planet(m1,m2,P2)
R=P2; %distance vector
r=norm(R);
G=6.67*10^-11; %universal gravitational constant

res=-G*(m1*m2)/(r^2) * R/r;
end
