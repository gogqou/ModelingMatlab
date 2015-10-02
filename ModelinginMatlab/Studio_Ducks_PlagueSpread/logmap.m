x(1)=.5
for r=2.4:.2:4
for i=1:50
    x(i+1)=r*x(i)*(1-x(i))
    plot3 (i,x,r)
   
end
end