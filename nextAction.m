function [ y ] = nextAction( epsilon, QState, r, r2 )
 
  
 if r <= epsilon
    if (r2 <= 0.25)
        y = 1;
    elseif (0.25 < r2) && (r2 <= 0.5)
        y = 2;
    elseif (0.5 < r2) && (r2 <= 0.75)
        y = 3;
    elseif (0.75 < r2) && (r2 <= 1)
        y = 4;
    end
 
 elseif r > epsilon
    y =  find(QState == max(QState(:)),1, 'first');
 end
  
 
  
   
  
end
