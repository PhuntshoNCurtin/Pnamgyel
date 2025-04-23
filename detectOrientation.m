
% Name: Phuntsho Namgyel
% Student ID: 21557163ImgInfo.angle(j))
% Title: function to compute checkerboard orientation


function ImgInfo = detectOrientation(ImgInfo, j)
    % difference of column and row for two black dots
    deltaCol = ImgInfo.b1_dot_X(j) - ImgInfo.b2_dot_X(j);
    deltaRow = ImgInfo.b1_dot_Y(j) - ImgInfo.b2_dot_Y(j);

    % finding portrait or landscape format  
    if abs(deltaCol) < abs(deltaRow)  % Portrait format
        if ImgInfo.W_dot_X(j) < ImgInfo.b1_dot_X(j) && ImgInfo.W_dot_X(j) < ImgInfo.b2_dot_X(j)            
            % Swapping the b1 and b2 coordinates
            if ImgInfo.b2_dot_Y(j) > ImgInfo.b1_dot_Y(j)
                ImgInfo = Swapping_b1_b2(ImgInfo, j);
            end

            % Identifying orientation of checkerboard (1,2,3 and 4 are the ID number of orientation)
            dX = ImgInfo.b2_dot_X(j) - ImgInfo.b1_dot_X(j);
            dY = ImgInfo.b2_dot_Y(j) - ImgInfo.b1_dot_Y(j);
            if dX>=0 && dY<=0
                ImgInfo.orientation(j) = 1;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY))); 
                ImgInfo.angle(j) = round(theta_deg, 2);
            else
                ImgInfo.orientation(j) = 4;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(dX/dY)); 
                ImgInfo.angle(j) = round(360-theta_deg, 2);
            end 

        else
            % Swapping the b1 and b2 coordinates
            if ImgInfo.b2_dot_Y(j) < ImgInfo.b1_dot_Y(j)
                ImgInfo = Swapping_b1_b2(ImgInfo, j);
            end

            % Identifying orientation of checkerboard (1,2,3 and 4 are the ID number of orientation)
            dX = ImgInfo.b2_dot_X(j) - ImgInfo.b1_dot_X(j);
            dY = ImgInfo.b2_dot_Y(j) - ImgInfo.b1_dot_Y(j);
            if dX>=0 && dY>=0
                ImgInfo.orientation(j) = 2;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY)));
                ImgInfo.angle(j) = round(180-theta_deg, 2);
            else
                ImgInfo.orientation(j) = 3;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY))); 
                ImgInfo.angle(j) = round(180+theta_deg, 2);
            end 
        end 
    
    else
        if ImgInfo.W_dot_Y(j) < ImgInfo.b1_dot_Y(j) && ImgInfo.W_dot_Y(j) < ImgInfo.b2_dot_Y(j)            
            % Swapping the b1 and b2 coordinates
            if ImgInfo.b2_dot_X(j) < ImgInfo.b1_dot_X(j)
                ImgInfo = Swapping_b1_b2(ImgInfo, j);
            end

            % Identifying orientation of checkerboard (1,2,3 and 4 are the ID number of orientation)
            dX = ImgInfo.b2_dot_X(j) - ImgInfo.b1_dot_X(j);
            dY = ImgInfo.b2_dot_Y(j) - ImgInfo.b1_dot_Y(j);
            if dX>=0 && dY>=0
                ImgInfo.orientation(j) = 2;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY)));
                ImgInfo.angle(j) = round(180-theta_deg, 2);
            else
                ImgInfo.orientation(j) = 1;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY))); 
                ImgInfo.angle(j) = round(theta_deg, 2);
            end 

        else
            % Swapping the b1 and b2 coordinates
            if ImgInfo.b2_dot_X(j) > ImgInfo.b1_dot_X(j)
                ImgInfo = Swapping_b1_b2(ImgInfo, j);
            end

            % Identifying orientation of checkerboard (1,2,3 and 4 are the ID number of orientation)
            dX = ImgInfo.b2_dot_X(j) - ImgInfo.b1_dot_X(j);
            dY = ImgInfo.b2_dot_Y(j) - ImgInfo.b1_dot_Y(j);
            if dX<=0 && dY<=0
                ImgInfo.orientation(j) = 4;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY)));
                ImgInfo.angle(j) = round(360-theta_deg, 2);
            else
                ImgInfo.orientation(j) = 3;
                % Computation of orientation angle
                theta_deg = rad2deg(atan(abs(dX/dY))); 
                ImgInfo.angle(j) = round(180+theta_deg, 2);
            end 
        end 
    end
end    



            
            

            
