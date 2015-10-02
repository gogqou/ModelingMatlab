function skater(v0, h);
    g=9.8;
    v=sqrt(v0-2*g*h);
    L=4;
    th=asin(2*h/L);
    W=[0, th, v, 0];
    options=odeset('Events', @events);
    [T, M]=ode45(@slope, [0,50], W, options);
    t=T(:)
    X=M(:,1);
    Y=M(:,2);
    plot(t,Y)
    hold on
    plot(t,X)
end
    function[value,isterminal,direction]=events(t,W);
    L=4 ;  
    value=-abs(W(1))+L/2;
        isterminal=1;
        direction=-1;
    end

    

function res=slope(t,W)
    
    r=W(1);
    theta=W(2);
    rd=W(3);
    thetad=W(4);
    drdt=rd;
    dthetadt=thetad;
    a=accel(r, theta, rd, thetad);
    drddt=a(1);
    dthetaddt=a(2);
    
    res= [drdt;dthetadt; drddt; dthetaddt];
end
    

function res=accel(r, theta, rd, thetad);
    Ibeam=50;
    m=70;
    g=9.8;
    rdd=r*thetad^2-g*sin(theta);
    thetadd=(g*cos(theta)+2*rd*thetad)/(Ibeam/(m*r)-r);
    res=[rdd; thetadd];
end