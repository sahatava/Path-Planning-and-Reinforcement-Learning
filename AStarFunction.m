function [ output_args ] = AStarFunction( name )
 
model = xlsread(name)

start = [2 2];
goal = [9 9];

g = zeros(size(model));
for i =1 : 10
    for j = 1:10
  g(i,j) = pdist([[i,j] ; goal],'euclidean');  
    end
end

h = 1000 * ones(size(model));
f = zeros(size(model));
parent = zeros(size(model));
info = model; %10 if close set, 5 if openset, -1 if blocked, 0 normal, 100 goal


h(start(1), start(2)) = 0;
f(start(1), start(2)) = 0 + g(start(1), start(2));
openSetF = f(start(1), start(2));
openSetIndex1= start(1);
openSetIndex2= start(2);
 

a = find(openSetF == min(openSetF(:)),1, 'first'); % find the min in openSet
current = [openSetIndex1(a) , openSetIndex2(a)];

%count = 0

while model(current(1), current(2)) ~= 100
    
%count = count +1
f(current(1), current(2)) = g(current(1), current(2)) + h(current(1), current(2));
info(current(1), current(2)) = 10; % set it as a closeSet
openSetF (a ) = 10000000000; % to not be found again 
hNew= h(current(1), current(2)) + 1;


neighborUp  = current + [-1 , 0] ;
if (info(neighborUp(1), neighborUp(2)) ~= -1) && (info(neighborUp(1), neighborUp(2)) ~= 10) % if it is not blocked or closedSet
 
    % calculate the h and the f
    if hNew < h(neighborUp(1), neighborUp(2))
        h(neighborUp(1), neighborUp(2)) = hNew;
        parent(neighborUp(1), neighborUp(2)) = 3; % parent state is down 
        f(neighborUp(1), neighborUp(2)) = hNew + g(neighborUp(1), neighborUp(2));
        
    end  
    info(neighborUp(1), neighborUp(2)) = 5; % set as openSet
    openSetF = [openSetF ;f(neighborUp(1), neighborUp(2)) ];
    openSetIndex1 = [openSetIndex1 ; neighborUp(1)] ;
    openSetIndex2 = [openSetIndex2 ; neighborUp(2)] ;
end    

neighborRight  = current + [0 , +1] ;
if (info(neighborRight(1), neighborRight(2)) ~= -1) && (info(neighborRight(1), neighborRight(2)) ~= 10) % if it is not blocked or closedSet
        
    % calculate the h and the f
    if hNew < h(neighborRight(1), neighborRight(2))
        h(neighborRight(1), neighborRight(2)) = hNew;
        parent(neighborRight(1), neighborRight(2)) = 4; % parent state is down
        f(neighborRight(1), neighborRight(2)) = hNew + g(neighborRight(1), neighborRight(2));
        
    end  
    info(neighborRight(1), neighborRight(2)) = 5; % set as openSet
    openSetF = [openSetF ;f(neighborRight(1), neighborRight(2)) ];
    openSetIndex1 = [openSetIndex1 ; neighborRight(1)] ;
    openSetIndex2 = [openSetIndex2 ; neighborRight(2)] ;
end 

neighborDown  = current + [+1 , 0] ;
if (info(neighborDown(1), neighborDown(2)) ~= -1) && (info(neighborDown(1), neighborDown(2)) ~= 10) % if it is not blocked or closedSet
    
    % calculate the h and the f
    if hNew < h(neighborDown(1), neighborDown(2))
        h(neighborDown(1), neighborDown(2)) = hNew;
        parent(neighborDown(1), neighborDown(2)) = 1; % parent state is down 
        f(neighborDown(1), neighborDown(2)) = hNew + g(neighborDown(1), neighborDown(2));
         
    end 
    info(neighborDown(1), neighborDown(2)) = 5; % set as openSet
    openSetF = [openSetF ;f(neighborDown(1), neighborDown(2)) ];
    openSetIndex1 = [openSetIndex1 ; neighborDown(1)] ;
    openSetIndex2 = [openSetIndex2 ; neighborDown(2)] ;
end 

neighborLeft = current + [0 , -1] ;
if (info(neighborLeft(1), neighborLeft(2)) ~= -1) && (info(neighborLeft(1), neighborLeft(2)) ~= 10) % if it is not blocked or closedSet
   
    % calculate the h and the f
    if hNew < h(neighborLeft(1), neighborLeft(2))
        h(neighborLeft(1), neighborLeft(2)) = hNew;
        parent(neighborLeft(1), neighborLeft(2)) = 2; % parent state is down 
        f(neighborLeft(1), neighborLeft(2)) = hNew + g(neighborLeft(1), neighborLeft(2));
         
    end   
    info(neighborLeft(1), neighborLeft(2)) = 5; % set as openSet
    openSetF = [openSetF ;f(neighborLeft(1), neighborLeft(2)) ];
    openSetIndex1 = [openSetIndex1 ; neighborLeft(1)] ;
    openSetIndex2 = [openSetIndex2 ; neighborLeft(2)] ;
end 

 
a = find(openSetF == min(openSetF(:)),1, 'first'); % find the min in openSet
current = [openSetIndex1(a) , openSetIndex2(a)];

end

current = goal;
a = current(1);
b = current(2);
path = current;
while (a~=2) && (b~=2)
if parent(a,b) == 1 
    next1 = a -1;
    next2 = b;
elseif parent(a,b) == 2 
    next1 = a;
    next2 = b+1;
elseif parent(a,b) == 3
    next1 = a+1;
    next2 = b;
elseif parent(a,b) == 4
    next1 = a;
    next2 = b-1;
end
 
path = [path ; next1 next2];

a = next1;
b = next2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%visualize%%%%%%%%%%%%%%%%%%%%%%%%%
for x= 0:9
    for y = 0:9
        
        rectangle('Position',[x y 1 1],'FaceColor',[.5 .5 .5],'EdgeColor',[.192,.192,.192] )
        if model(9-y+1,x+1) == 0
            rectangle('Position',[x y 1 1],'FaceColor',[1 1 1],'EdgeColor',[.192,.192,.192] )
        end
        if info(9-y+1,x+1) == 5 % openSet
            rectangle('Position',[x y 1 1],'FaceColor','b','EdgeColor',[.192,.192,.192] )
            t = text(x+.05,y+.7, strcat('h=',num2str( h(9-y+1,x+1))) )
            t.FontSize = 7;                     
             
            t = text(x+.05,y+.3, strcat('g=',num2str( g(9-y+1,x+1))) )
            t.FontSize = 7;                     
             
        end
        if info(9-y+1,x+1) == 10 % closeSet
            rectangle('Position',[x y 1 1],'FaceColor','g','EdgeColor',[.192,.192,.192] )
             t = text(x+.05,y+.7, strcat('h=',num2str( h(9-y+1,x+1))) )
            t.FontSize = 7;                     
             
            t = text(x+.05,y+.3, strcat('g=',num2str( g(9-y+1,x+1))) )
            t.FontSize = 7;                     
             
        end
        
        if model(9-y+1,x+1) == -1
           rectangle('Position',[x y 1 1],'FaceColor',[139/255,69/255,19/255] ,'EdgeColor',[.192,.192,.192])
        end

    end
end
    rectangle('Position',[8 1 1 1],'FaceColor','r' ,'EdgeColor',[.192,.192,.192])
    t = text(8.1, 1.5, 'Goal')
    t.FontSize = 10;                     % make the text larger
    t.FontWeight = 'bold';

 
% construct the path
s = size(path);
point = path(s(1),:);
a= point(1);
b = point(2);
line([1+.5 b-1+.5],[8+.5 10-a+.5],'Color','r','LineWidth',4)
for i = 1:s(1)-1
    point = path(s(1)-i+1,:);
    a= point(1);
    b = point(2);
    current = [b-1, 10-a];
    point = path(s(1)-i,:);
    a= point(1);
    b = point(2);
    next = [b-1, 10-a];
    line([current(1)+.5 next(1)+.5],[current(2)+.5 next(2)+.5],'Color','r','LineWidth',4)
    pause(0.2)
end
end

