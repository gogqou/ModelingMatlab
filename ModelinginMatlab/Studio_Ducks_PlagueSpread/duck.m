function res = duck(d) %finds depth at which duck will float in cm
r=10; %radius of duck in cm
p(1)=0; %density of duck in g/cm^3
for i=1:100
    p(i+1)=p(i)+.005;
f=4*(r^3)*p(i) - 3*r*d^2+d^3;
end
res = f;
end
