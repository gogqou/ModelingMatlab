function res = duck(d) %finds depth at which duck will float in cm
r=10; %radius of duck in cm
p=.3; %density of duck in g/cm^3
f=4*(r^3)*p - 3*r*d^2+d^3;
res = f;
end
%use fzero(@function_duck, x) where x is an input value, to find d at which
%duck floats

%Guanqing Ou