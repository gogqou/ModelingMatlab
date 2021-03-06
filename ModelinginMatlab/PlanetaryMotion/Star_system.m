function res=orbit(t)
years=10;
[T,M]=ode45(@slope, [0,years*2*pi], [-1,0,1,0,4,0,0,.6,0,-.6,.2,0])
animate_func(T,M);
    function animate_func(T,M)
        X1=M(:,1);
        Y1=M(:,2);
        X2=M(:,3);
        Y2=M(:,4);
        X3=M(:,5);
        Y3=M(:,6);
        for i=1:length(T)-1
            %clf;
            hold on;
            axis([min([X1;X2]),max([X1; X2 ]), min([Y1; Y2]), max([Y1; Y2])]);
            plot(X1(i),Y1(i),'r.', 'MarkerSize',20);
            plot(X2(i), Y2(i),'b.', 'MarkerSize', 20);
            %plot(X3(i),Y3(i), 'y.', 'MarkerSize', 10);
            %hold off;
            drawnow;
            dt=T(i+1)-T(i);
            %speedup=3.0;
            %pause(dt/speedup);
        end

    end
end
    function res=slope(t,W)
        M1=1;
        M2=1;
        M3=.0001;
        P=W(1:6);
        V=W(7:12);
        dPdt=V;
        dVdt=acceleration(t,M1,M2,M3,P);
        res=[dPdt; dVdt];

    end

    function res=acceleration(t,M1,M2,M3,P)
        P1=P(1:2);
        P2=P(3:4);
        P3=P(5:6);
        A12=Gravitational_force(M1,M2,P1,P2)/M1;
        A21=-Gravitational_force(M1,M2,P1,P2)/M1;
        A31=Gravitational_force(M1,M3,P3,P1)/M3;
        A32=(Gravitational_force(M1,M3,P3,P2))/M3;
        A3=A31+A32;
        %A1=A12-A31;
        %A2=A21-A32;
        res=[A12 ; A21; A3];
    end


    function res=Gravitational_force(m1,m2,P1,P2)
        R=P1-P2; %distance vector
        r=norm(R);
        G=1; %universal gravitational constant

        res=-G*(m1*m2)/(r^2) * R/r;
    end
