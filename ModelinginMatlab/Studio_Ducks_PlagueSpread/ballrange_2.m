function res =ballrange(v,theta)
rho=1.3 %density of air, kg/m cubed
A=.0042 %cross sectional area of baseball, m squared
C=.3 %drag coefficient
m=.145 %mass in kg
g=9.8
vx=v*cos(theta)
vy=v*sin(theta)

options=odeset('events', @events);
    function[value,isterminal,direction]=events(t,H)
        value=H;
        isterminal=1;
        direction=-1;
    end
[T,H]=ode45(@slope,[0,20], v,theta,options)
plot(T,H)

    function res=slope(t,h,vy)
    dvdt=Fdrag(t,h,vy)/m+m*g
    dhdt=vy
    res=[dhdt,dvdt]
    end

    function res=Fdrag(t,h,v)
        rho=1.3 %density of air, kg/m cubed
        A=.0042 %cross sectional area of baseball, m squared
        C=.3 %drag coefficient
        res=-1/2*rho*A*C*v^2
    end
