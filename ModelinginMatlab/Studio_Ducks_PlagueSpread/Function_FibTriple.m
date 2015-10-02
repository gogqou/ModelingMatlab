function res = Function_FibTriple(n)
F(1)=1;
F(2)=2;
for i=3:n
    F(i)=F(i-1)+F(i-2);
    F(i+1)=F(i)+F(i-1);
    F(i+2)=F(i)+F(i+1);
    F(i+3)=F(i+1)+F(i+2);
    c=sqrt((F(i)*F(i+3))^2+(2*F(i+1)*F(i+2))^2);
    if c==(F(i+1))^2+(F(i+2))^2
        res=1
    else res=0
        if res==1
            [i F(i) F(i)*F(i+3) 2*F(i+1)*F(i+2) (F(i+1))^2+(F(i+2))^2]
        end
    end
end
