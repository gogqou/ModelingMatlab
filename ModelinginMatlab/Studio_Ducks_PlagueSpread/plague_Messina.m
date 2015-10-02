function res=infection()
time=input('time period?\how long do you want to project for?\in days')
infected_A(1)=0;
%infected_B(1)=0;
W=cities();
interaction_A=W(2);
pop_A=W(1)
%interaction_B=W(4);
infection_source=Messina();
%dt=input('how long between every set of interactions?\n in days')
for i=1:time
     probability=ceil(100.*rand(1))
     if probability<=interaction_A*infection_source*100
         infected_A(i+1)= infected_A(i)+1
     else
         infected_A(i+1)=infected_A(i)
     end
     if infected_A(i+1)>=.55*pop_A
         break
     else
         1
     end
         
plot(i+1,infected_A(i+1))
hold on
end
end



function res=cities()%gives vector with city populations and interaction percentages of cities with original city
%A is vector for city 1
%B is vector for city 2
%A and B do not interact
%A and B only interface with Messina
pop_A=input('population of city A?\n')

interaction_A=input('percentage of people from city A that\n interact with the population of Messina?\n(in percentage notation, not decimal)\n')
%interaction is in actual percentage, not a decimal--so divide when using
%it
pop_B=input('population of city B? \n')
interaction_B=input('percentage of people from city B that\n interact with the population of Messina?\n(in percentage notation, not decimal)\n')
res=[pop_A ; interaction_A/100; pop_B; interaction_B/100];
end

function res=Messina()
pop=input('Population of Messina?\n') 
infected_p=input('percentage infected in Messina?\n')
infected_n=pop*infected_p; 
res=infected_p/100;
end