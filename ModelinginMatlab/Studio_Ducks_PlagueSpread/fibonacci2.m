F(1)=1
F(2)=2
for i=3:n
    F(i)=(Fi-1)+F(i-2)
end
ans = F(n)