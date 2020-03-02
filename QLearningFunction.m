function [ Qtable] = QLearningFunction( name )

model = xlsread(name)

% initial Q tables for up, right, down, left
Q1 = zeros(size(model)); %up
Q2 = zeros(size(model)); %right
Q3 = zeros(size(model)); %down
Q4 = zeros(size(model)); %left
Qtable = zeros(size(model));
% parameters for updating Q
gamma = 0.8;
alpha = 0.9;
epsilon = 0.9;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%updating Q%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 10000; % number of the episodes to update the Q
for i = 1:K
    
%%%%%%%%%%%%%%%%% 0ne episode %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = 1 ; % number of the steps in each iteration 

% for each episode select a random start point
currentState = [randi([1 10],1,1) randi([1 10],1,1)]; 
if model( currentState(1) , currentState(2) ) == -1
    currentState = [2 2];
end

while s <= 150 % 150 is the max number of steps in each episode
s = s+1;
if model( currentState(1) , currentState(2) ) == 100 % agent has reached to the goal
    break
end 
% update all the four Qs in the current state 
a = currentState(1);
b = currentState(2);

% select action based on the epsilon policy to find the next state 
r = rand;
r2 = rand;
QState = [Q1(a,b); Q2(a,b); Q3(a,b); Q4(a,b)];
action = nextAction(epsilon, QState, r, r2);

if action == 1
% update Q1
[NS1,NS2]  = nextStep(a,b, 1, 1);
QNS = [Q1(NS1,NS2) ; Q2(NS1,NS2) ; Q3(NS1,NS2) ; Q4(NS1,NS2) ];
Q1(a,b) = Q1(a,b) + alpha*( model(NS1,NS2) + gamma* (max(QNS)) - Q1(a,b));
elseif action == 2
% update Q2
[NS1,NS2]  = nextStep(a,b, 2, 1);
QNS = [Q1(NS1,NS2) ; Q2(NS1,NS2) ; Q3(NS1,NS2) ; Q4(NS1,NS2) ];
Q2(a,b) = Q2(a,b) + alpha*( model(NS1,NS2) + gamma* (max(QNS)) - Q2(a,b));
elseif action == 3
% update Q3
[NS1,NS2] = nextStep(a,b, 3, 1);
QNS = [Q1(NS1,NS2) ; Q2(NS1,NS2) ; Q3(NS1,NS2) ; Q4(NS1,NS2) ];
Q3(a,b) = Q3(a,b) + alpha*( model(NS1,NS2) + gamma* (max(QNS)) - Q3(a,b));
elseif action == 4
% update Q4 
[NS1,NS2]  = nextStep(a,b, 4, 1);
QNS = [Q1(NS1,NS2) ; Q2(NS1,NS2) ; Q3(NS1,NS2) ; Q4(NS1,NS2) ];
Q4(a,b) = Q4(a,b) + alpha*( model(NS1,NS2) + gamma* (max(QNS)) - Q4(a,b));
end

Qtable(a,b) = max([Q1(a,b),Q2(a,b),Q3(a,b),Q4(a,b)]);

% update the next position of the agent
if model(NS1,NS2)~= -1
currentState = [NS1, NS2];
end

end % end of one episode
end % end of the 1000 episodes of training 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for x= 0:9
    for y = 0:9
        
        rectangle('Position',[x y 1 1],'FaceColor',[.5 .5 .5],'EdgeColor',[.192,.192,.192] )
        if model(9-y+1,x+1) == 0
        rectangle('Position',[x y 1 1],'FaceColor',[1 1 1],'EdgeColor',[.192,.192,.192] )
        t = text(x+.5,y+.9, num2str(round(Q1(9-y+1,x+1))))
        t.FontSize = 7;                     
        t.FontWeight = 'bold';
        t = text(x+.7,y+.5, num2str(round(Q2(9-y+1,x+1))))
        t.FontSize = 7;                     
        t.FontWeight = 'bold';
        t = text(x+.5,y+.1, num2str(round(Q3(9-y+1,x+1))))
        t.FontSize = 7;                      
        t.FontWeight = 'bold';
        t = text(x+.1,y+.5, num2str(round(Q4(9-y+1,x+1))))
        t.FontSize = 7;                      
        t.FontWeight = 'bold';
        end
        if model(9-y+1,x+1) == -1
        rectangle('Position',[x y 1 1],'FaceColor',[139/255,69/255,19/255] ,'EdgeColor',[.192,.192,.192])
        end
    end
    rectangle('Position',[8 1 1 1],'FaceColor','r' ,'EdgeColor',[.192,.192,.192])
    t = text(8.1, 1.5, 'Goal')
    t.FontSize = 10;                     % make the text larger
    t.FontWeight = 'bold';
   
end

 
end

