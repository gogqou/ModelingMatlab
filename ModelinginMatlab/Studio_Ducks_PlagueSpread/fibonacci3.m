F(1)=1
F(2)=1
for i=3:100
    F(i)=F(i-1) + F(i-2)
end
plot (F)
