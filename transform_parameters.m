% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: Transformation parameters




function imagePoints = transform_parameters(imagePoints, minIndex)
    if minIndex == 70
        for i=1:70
            imagePoints(71-i, 1) = i;
        end
%{
    elseif minIndex == 7
        c = 8;
        for i=1:70
            if mod(i, 7) == 1
                c = c+14;
            end    
            imagePoints(c-i, 1) = i;  
        end    
   
    elseif minIndex == 64
        c = 63;
        for i=1:70
            if mod(i, 7) == 1
                c = c-14;
            end    
            imagePoints(c+i, 1) = i;  
        end  
%}
        
    else
        disp('No tranfromation required. Already correct labels for this image')
    end
    
end    
