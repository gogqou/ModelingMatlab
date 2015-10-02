for i=1:52
a(i)=150
b(i)=150
a(i + 1)= a(i)-.05*a(i)+.03*b(i)
b(i + 1)= b(i)+.05*a(i)-.03*b(i)
a(i)=a(i+1)
b(i)=b(i+1)
end
