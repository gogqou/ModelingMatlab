%----------------Top Level Domain Program-------------------%
function trouble
%A computer simulation of Pop-o-matic Trouble

    %Greeting
    clc
    disp 'Welcome to Pop-o-Matic Trouble!'
    disp ' '
    
    %How many players?
        players=input('How many players?\n');
        disp ' '
            while players~=[2,3,4]
                disp 'Incorrect number of Players. Please try again.'
                disp ' '
                players=input('How many players?\n');
                disp ' '
            end
            
    %Strategy Selection
        strategy=cell(1,players);
        for i=1:players
            clc
            disp 'Strategies:'
            disp ' '
            disp '1) Back Pack'
            disp ' '
            disp '2) Random'
            disp ' '
            disp '3) One-at-a-time'
            disp ' '
            disp '4) Choice'
            disp ' '
            switch i
                case 1
                    strategy{1}=input('Player 1?\n');
                case 2
                    strategy{2}=input('Player 2?\n');
                case 3
                    strategy{3}=input('Player 3?\n');
                case 4
                    strategy{4}=input('Player 4?\n');
            end
            switch strategy{i}
                case 1
                    strategy{i}=@back;
                case 2
                    strategy{i}=@random;
                case 3
                    strategy{i}=@one;
                case 4
                    strategy{i}=@choice;
            end
        end
            
    %Game Set-up
        for i=1:players
            R(i,:)=[0,0,0,0]; %Relative Positions of Blue (Player 1), Green (Player 2), Yellow (Player 3), and Red Pieces (Player 4), respectively downward.
            A(i,:)=[0,0,0,0]; %Absolute Positions of Blue, Green, Yellow, and Red Pieces, respectively downward.
        end
        
    %Who starts the game?
        rand('state',sum(100*clock));  %Reset random number generator to a different state.
        number_to_beat=[0,1:players];  %Sets the highest roll at 0, rolled by all player.
        while length(number_to_beat)>2
            number_to_beat(1)=0;
            for i=number_to_beat(2:end)
                roll=ceil(6.*rand);  %Each player rolls once.
                if roll>number_to_beat(1)    %Tests for higher number than current record.
                    number_to_beat=[roll,i];
                elseif roll==number_to_beat(1)   %Tests for equal number to current record.
                    number_to_beat=...
                        [number_to_beat,i];
                end
            end
        end
        fp=number_to_beat(2);   %First player is number_to_beat(2).
        disp(['Player ' num2str(number_to_beat(2)) ' has won the roll and will go first.'])
        disp ' '
        pause(1)
        for i=1:players
            turn_order(i)=mod(i+fp+(players-2),players)+1;
        end
        
    %Turn Loop
    win=0;  %Denotes that no one has yet won.
    turn=1; %Denotes that no one has moved yet.
    while win==0    %Play until someone wins.
        
        %Who's turn is it?
        mover=turn_order...
            (mod(turn+players-1,...
            players)+1);
        
        %Turn consists of a pop...
        roll=ceil(6.*rand);
        
        %And a move.
        [R,A]=strategy{mover}(mover,R,A,roll);    %Calls piece selection function, which calls move function.
        
        %Did someone win?
        if sum(R(mover,:))==122
            win=mover;
        end
        
        %Do I get to go again?
        if roll~=6
            turn=turn+1;
        end
        
    end
    
    %Winner Announcement
    disp (['The Winner is Player ' num2str(win) '!'])
    
end









%---------------Test Program----------------%
function [result]=test(mover,R,roll,piece)
    
    result=1;    %Default result is true. I.e. that the piece can move.

    %Test for ability to leave start
    if R(mover,piece)==0 && roll~=6
        result=0;
        return
    end
    
    %Test for conflict with other pieces on team
    if R(mover,piece)==0 && roll == 6
        I=find(R(mover,:)==1+R(mover,piece));
    else
        I=find(R(mover,:)==roll+R(mover,piece));
    end
    if isempty(I)~=1
        result=0;
        return
    end
    
    %Test for end of the board overshoot
    if R(mover,piece)+roll>32
        result=0;
        return
    end
    
end









%-----------Move Program------------%
function [R,A]=move(mover,R,A,roll,piece)

    %Move Piece
     if R(mover,piece)==0 && roll==6
         R(mover,piece)=R(mover,piece)+1;    %Piece only moves one when leaving start
     else
         R(mover,piece)=R(mover,piece)+roll; %Piece moves amount rolled
     end
    
    %Calculate Absolute Position
        if R(mover,piece)==7*(5-mover)
            A(mover,piece)=28;
       elseif R(mover,piece)>28
            A(mover,piece)=R(mover,piece)+4*(mover-1);
        else
            A(mover,piece)=mod(R(mover,piece)+7*(mover-1),28);
        end
    
    %Check for other pieces
        I=find(A==A(mover,piece));
        for i=1:length(I)
            if I(i)~=sub2ind(size(A), mover, piece)
                A(I(i))=0;
                R(I(i))=0;
            end
        end
    
end









%----------Back Pack Strategy----------%
function [R,A] = back(mover,R,A,roll)
%Backmost Piece at a time

    R_temp=sort(R(mover,:),'descend'); %Sorts piece positions from greatest to least.
    
    %Choose a Piece
    check=0;    %Denotes that no piece has been approved
    gt=0;   %Denotes that no piece has been checked
    while check~=1
        %Determine Which Piece is Furthest Behind
        clear H;
        for i=1:length(R(mover,:))-gt   %Eliminates as many values as have been checked
            H(i)=R_temp(i);
        end
        switch H(end)   %Checks to see which piece was chosen, then assigns that piece
            case R(mover,4)
                piece=4;
            case R(mover,3)
                piece=3;
            case R(mover,2)
                piece=2;
            case R(mover,1)
                piece=1;
        end
    
        %Test Piece
        check=test(mover,R,roll,piece);
        gt=gt+1;    %Denotes that one more piece has been checked
        
        %If no piece works...
        if gt==4 && check~=1
            disp(['Player ' num2str(mover) ' was not able to move.'])
            disp ' '
            pause(1)
            return
        end
    end

    
    %Move that piece
    [R,A]=move(mover,R,A,roll,piece);
    
    %Display Move
    disp(['Player ' num2str(mover) ' just moved piece ' num2str(piece) ' to space ' num2str(A(mover,piece)) '.'])
    disp ' '
    pause(1)
    
end









%----------Random Strategy----------%
function [R,A] = random(mover,R,A,roll)

    %Choose Piece
    tests=zeros(1,length(R(:,1)));  %Stores a value for all pieces that have been checked
    check=0;    %Denotes that no piece has passed the test
    while check~=1
        tp=ceil(4.*rand);   %Test piece is random
        tests(tp)=tp;
        check=test(mover,R,roll,tp);
        if check==1
            piece=tp;
        end
        if sum(tests)==10 && check~=1
            disp (['Player ' num2str(mover) ' was not able to move.'])
            disp ' '
            pause(1)
            return
        end
    end

    %Move Piece
        [R,A]=move(mover,R,A,roll,piece);

    
    %Display Move
        disp(['Player ' num2str(mover) ' just moved piece ' num2str(piece) ' to space ' num2str(A(mover,piece)) '.'])
        disp ' '
        pause(1)
    
end









%----------One-at-a-time Strategy----------%
function [R,A]=one(mover,R,A,roll)

    %Choose Piece
        if test(mover,R,roll,1)==1
            piece=1;
        elseif test(mover,R,roll,2)==1
            piece=2;
        elseif test(mover,R,roll,3)==1
            piece=3;
        elseif test(mover,R,roll,4)==1
            piece=4;
        else
            disp (['Player ' num2str(mover) ' was not able to move.'])
            disp ' '
            pause(1)
            return
        end
    
    %Move Piece
        [R,A]=move(mover,R,A,roll,piece);
    
    %Display Move
        disp(['Player ' num2str(mover) ' just moved piece ' num2str(piece) ' to space ' num2str(A(mover,piece)) '.'])
        disp ' '
        pause(1)
    
end









%----------Choice Strategy----------%
function [R,A]=choice(mover,R,A,roll)

    %Inform the Player about their options
    disp (['Player ' num2str(mover) ','])
    disp(['You just rolled a ' num2str(roll) '.'])
    disp ' '
    if 1~=[test(mover,R,roll,1),test(mover,R,roll,2),test(mover,R,roll,3),test(mover,R,roll,4)] %If none of the pieces can move
        disp 'Sorry, none of your pieces could move. Your turn has been skipped.'
        disp ' '
        pause(2)
        return
    else
        disp('Your current positions are:')
        disp(['  Piece 1: ' num2str(A(mover,1))])
        disp(['  Piece 2: ' num2str(A(mover,2))])
        disp(['  Piece 3: ' num2str(A(mover,3))])
        disp(['  Piece 4: ' num2str(A(mover,4))])
        disp(['    (Your Finish is after space ' num2str((28-7*mod(5-mover,4))) '. The numbers begin again after space 28.)'])
        disp(['    (Your Finish spaces are ' num2str(32+4*(mover-1)) ', ' num2str(31+4*(mover-1)) ', ' ...
                num2str(30+4*(mover-1)) ', and ' num2str(29+4*(mover-1)) '.)'])
        disp ' '
        piece=input('Which piece would you like to move?\n');   %Ask for piece selection
        disp ' '
        while test(mover,R,roll,piece)~=1
            piece=input('Sorry, that piece cannot move. Please choose another piece.\n');
            disp ' '
        end
    end

    %Move the piece
        [R,A]=move(mover,R,A,roll,piece);
    
end