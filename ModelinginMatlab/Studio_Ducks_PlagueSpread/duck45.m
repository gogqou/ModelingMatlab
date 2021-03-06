function res=duck(beta)
   options=odeset('events', @events);
    function[value,isterminal,direction]=events(t,X)
        value=X(1);
        isterminal=1;
        direction=-1;
    end
[T,H]=ode45(@slope, [0,15], [0,10], options);
plot(T,H);
function res=slope(t,X)
h=X(1);
v=X(2);
dhdt=v;
dvdt=acceleration(t,h,v);
res=[dhdt; dvdt];
end
function res=acceleration(t,p,v)
g=-9.8;
m=1.256;
a=g+beta*v^2/m;
res=a;
end
end