%computes the number of cars in albany and boston.  precondition: you
%must assign values to a and b.  postcondition: answers will be stored in a
%and b.

x=5
a(i+1)= a(i)-a(i)*(.05)+b(i)*(.03)
b(i+1)= b(i)-b(i)*(.03)+a(i)*(.05)
a(i)=round(a(i+1))
b(i)=round(b(i+1))