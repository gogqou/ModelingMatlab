function res=duck(v,dt)
[T,V,H]=euler(v,dt);
h=max(H)
v=max(V)
t=max(T)

end
function [T,V,H]=euler(v,dt)
V(1)=v;
H(1)=0;
T(1)=0;
i=2;


while H(i-1)>=0
    T(i)=T(i-1)+dt;
    V(i)=V(i-1)+acceleration(V(i-1))*dt;
    H(i)=H(i-1)+V(i-1)*dt;
    if H(i)<0
        break
    end
    i=i+1;
end
plot(T,V);
hold on
plot (T,H);

end
function res=acceleration(v)
g=-9.8;
B=1000;
m=1.256;
a=g-(B*v^2)/m;
res=a;
end




