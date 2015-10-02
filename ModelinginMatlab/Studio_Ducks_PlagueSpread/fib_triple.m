function res=fib_triple(n)
a=0
F=fibonacci_seq(n+3);
for i=1:n
    if Istriple(F(i)*F(i+3),2*F(i+1)*F(i+2),(F(i+1))^2+(F(i+2))^2);
        a(i)=1;
    else a(i)=0;
    end
    if sum(a)==n
        res=1;
    else res=0;
    end
   end
end

