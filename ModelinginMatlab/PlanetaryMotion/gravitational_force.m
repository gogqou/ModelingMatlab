function res=Force_planet(M,m,P1,P2)
R=[(P1(1)-P2(1)) P1(2)-P2(2)]
r=norm(R)
res=gravitational_force(M,m,r)


function res=gravitational_force(m1,m2,r)
G=6.67*10^-11 %universal gravitational constant

res=-G*(m1*m2)/(r^2)
end
