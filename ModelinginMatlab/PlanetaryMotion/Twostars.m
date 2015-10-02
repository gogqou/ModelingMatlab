function res=orbit(t)
years=10;
[T,M]=ode45(@slope, [0,years*2*pi], [1, 0, -1,0,0,.6,0,-.6]);
animate_func(T,M);
    function animate_func(T,M)
        X1=M(:,1);
        Y1=M(:,2);
        X2=M(:,3);
        Y2=M(:,4);
        for i=1:length(T)-1
            clf;
            hold on;
            axis([min([X1;X2]),max([X1; X2]), min([Y1; Y2]), max([Y1; Y2])]);
            plot(X1(i),Y1(i),'r.', 'MarkerSize',50);
            plot(X2(i), Y2(i),'b.', 'MarkerSize', 50);
            hold off;
            drawnow;
            dt=T(i+1)-T(i);
            speedup=3.0;
            pause(dt/speedup);
        end

    end
end
    function res=slope(t,W)
        M1=1;
        M2=1;
        P=W(1:4);
        V=W(5:8);
        dPdt=V;
        dVdt=acceleration(t,M1,M2,P);
        res=[dPdt; dVdt];

    end

    function res=acceleration(t,M1,M2,P)
        P1=P(1:2);
        P2=P(3:4);
        A1=Force_planet(M1,M2,P1,P2)/M1;
        A2=-Force_planet(M1,M2,P1,P2)/M1;
        res=[A1 ; A2];
    end


    function res=Force_planet(m1,m2,P1,P2)
        R=P1-P2; %distance vector
        r=norm(R);
        G=1; %universal gravitational constant

        res=-G*(m1*m2)/(r^2) * R/r;
    end
