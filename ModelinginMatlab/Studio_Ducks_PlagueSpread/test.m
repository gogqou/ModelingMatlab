function res=infection()
time=input('time period?\how long do you want to project for?\in days')
infected_A(1)=0
infected_B(1)=0
W=cities()
A=W(2)
B=W(4)
res=A
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
res=[pop_A ; interaction_A; pop_B; interaction_B]
end

function res=Messina()
pop=input('Population of Messina?\n') 
infected_p=input('percentage infected in Messina?\n')
infected_n=pop*infected_p 
res=infected_p/100
end