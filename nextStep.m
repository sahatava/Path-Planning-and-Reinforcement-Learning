function [y1,y2] = nextStep(currentStep1, currentStep2, action, a)
if a == 2 
r = rand;
% if decided action is up
if (r <= 0.6) && (action == 1) 
    y1 = currentStep1-1;
    y2 = currentStep2 ;
elseif (0.6 < r) && (r <= 0.7) && (action == 1) 
    y1 = currentStep1;
    y2 = currentStep2;
elseif (0.7 < r) && (r <= 0.8) && (action == 1) 
    y1 = currentStep1+1;
    y2 = currentStep2;
elseif (0.8 < r) && (r <= 0.9) && (action == 1)
    y1 = currentStep1;
    y2 = currentStep2+1;
elseif (0.9 < r) && (r <= 1) && (action == 1) 
    y1 = currentStep1;
    y2 = currentStep2-1;
end
% if decided action is right
if (r <= 0.6) && (action == 2) 
    y1 = currentStep1;
    y2 = currentStep2+1;
elseif (0.6 < r) && (r <= 0.7) && (action == 2) 
    y1 = currentStep1;
    y2 = currentStep2;
elseif (0.7 < r) && (r <= 0.8) && (action == 2) 
    y1 = currentStep1+1;
    y2 = currentStep2;
elseif (0.8 < r) && (r <= 0.9) && (action == 2)
    y1 = currentStep1-1;
    y2 = currentStep2;
elseif (0.9 < r) && (r <= 1) && (action == 2) 
    y1 = currentStep1;
    y2 = currentStep2-1;
end
% if decided action is down
if (r <= 0.6) && (action == 3) 
    y1 = currentStep1+1;
    y2 = currentStep2 ;
elseif (0.6 < r) && (r <= 0.7) && (action == 3) 
    y1 = currentStep1;
    y2 = currentStep2;
elseif (0.7 < r) && (r <= 0.8) && (action == 3) 
    y1 = currentStep1-1;
    y2 = currentStep2;
elseif (0.8 < r) && (r <= 0.9) && (action == 3)
    y1 = currentStep1;
    y2 = currentStep2+1;
elseif (0.9 < r) && (r <= 1) && (action == 3) 
    y1 = currentStep1;
    y2 = currentStep2-1;
end
% if decided action is left
if (r <= 0.6) && (action == 4) 
    y1 = currentStep1;
    y2 = currentStep2-1;
elseif (0.6 < r) &&  (r <= 0.7) && (action == 4) 
    y1 = currentStep1;
    y2 = currentStep2;
elseif (0.7 < r) &&  (r <= 0.8) && (action == 4) 
    y1 = currentStep1+1;
    y2 = currentStep2;
elseif (0.8 < r) && (r <= 0.9) && (action == 4)
    y1 = currentStep1;
    y2 = currentStep2+1;
elseif (0.9 < r) && (r <= 1) && (action == 4) 
    y1 = currentStep1-1;
    y2 = currentStep2;
end
end

 

if  (action == 1) 
    y1 = currentStep1-1;
    y2 = currentStep2 ;
elseif  (action == 2) 
    y1 = currentStep1;
    y2 = currentStep2+1;
elseif   (action == 3) 
    y1 = currentStep1+1;
    y2 = currentStep2;
elseif  (action == 4)
    y1 = currentStep1;
    y2 = currentStep2-1;
 
end
 
end