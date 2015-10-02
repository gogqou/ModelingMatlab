function res=duck(v0, dt)
[T, V, H]=euler(v0, dt);
max(H)
max(T)
end

function [T, V, H]= euler(v0, dt)
  T(1)=0;
  V(1)=v0;
  H(1)=0;
  the_duck_has_landed=v0/4.9;
  x=round(the_duck_has_landed/dt);
 for i=2:x;
     T(i)=T(i-1)+dt;
     V(i)=acceleration*dt+V(i-1);
     H(i)=V(i-1)*dt+H(i-1);
 end

end

function res= acceleration
res=-9.8;
end