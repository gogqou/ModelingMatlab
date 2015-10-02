P(1)=50
J(1)=0
S(1)=0
A(1)=5
for n=2:50
plot (n,P(n-1), 'g-')
hold on
plot (n,A(n-1), 'r-')
plot (n,S(n-1),'k-')
plot (n,J(n-1),'b-')
J(n)=round(.33*A(n-1))
S(n)=round(.18*J(n-1))
A(n)=(round(.71*S(n-1))+round(A(n-1)*.94))
P(n)=A(n)+S(n)+J(n);
end
P(n), A(n), S(n), J(n)


