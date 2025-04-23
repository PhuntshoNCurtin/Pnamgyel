
% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: Circle detection on Checkerboard image



function [w_center, b_centers, img_l_pix, img_w_pix] = circleDetect(imagepath)

    % Load the image
    %imagepath = fullfile('images', '367_BMC_F01320_Q75.jpg');
    image = imread(imagepath);
    [img_w_pix, img_l_pix, ~] = size(image);
    
    % Convert to grayscale for better processing
    grayImage = rgb2gray(image);
    
    % Detect checkerboard corners
    [cornerPoints, boardSize] = detectCheckerboardPoints(grayImage);

    w_center = [0 0];
    b_centers = [0 0; 0 0];
    
    % If no checkerboard found, display an error and exit
    if isempty(cornerPoints)
        fprintf('Checkerboard not found for: %s\n',imagepath);
        return;
    end
    
    % Draw the boundary box around the checkerboard
    xMin = min(cornerPoints(:,1));
    xMax = max(cornerPoints(:,1));
    yMin = min(cornerPoints(:,2));
    yMax = max(cornerPoints(:,2));
    
    % Define the checkerboard bounding box [xmin, ymin, width, height]
    checkerboardBoundingBox = [xMin, yMin, (xMax - xMin), (yMax - yMin)];
    
    % Detect white circles (bright circles)
    [whiteCenters, whiteRadii] = imfindcircles(grayImage, [8 20], 'Sensitivity', 0.78, ...
                                               'Method', 'TwoStage', 'ObjectPolarity', 'bright', 'EdgeThreshold',0.2);
    %fprintf('white: %f, %f\n', whiteCenters');

    % Detect black circles (dark circles)
    [blackCenters, blackRadii] = imfindcircles(grayImage, [8 20], 'Sensitivity', 0.78, ...
                                               'Method', 'TwoStage', 'ObjectPolarity', 'dark','EdgeThreshold',0.2);
    %fprintf('black: %f, %f\n', blackCenters');
    % Combine the detections of white and black circles
    all_Centers = [whiteCenters; blackCenters];
    all_Radii = [whiteRadii; blackRadii];
    
    
    % Filter circles that fall inside the checkerboard boundary box
    validCircleIndices_w = [];
    validCircleIndices_b = [];
    
    for j = 1:2
        % Get the current set of centers and radii for either white or black circles
        if j == 1
            b_w_centers = whiteCenters;  % White circles centers
            b_w_radii = whiteRadii;      % White circles radii
        else
            b_w_centers = blackCenters;  % Black circles centers
            b_w_radii = blackRadii;      % Black circles radii
        end

        if isempty(b_w_centers) && j==1  % Avoid indexing errors
            fprintf('No white circles detected for:  %s\n',imagepath);
            continue; % continue to next iteration    
        end
        if isempty(b_w_centers) && j==2  % Avoid indexing errors
            fprintf('No black circles detected for:  %s\n',imagepath);
            continue; % continue to next iteration    
        end
    
        % Loop through each center and radius
        for i = 1:size(b_w_centers, 1)
            % Check if the circle's center is inside the bounding box
            if b_w_centers(i, 1) > xMin && b_w_centers(i, 1) < xMax && b_w_centers(i, 2) > yMin && b_w_centers(i, 2) < yMax
                % Check if the circle's radius fits within the bounding box
                if b_w_centers(i, 1) - b_w_radii(i) > xMin && b_w_centers(i, 1) + b_w_radii(i) < xMax && ...
                   b_w_centers(i, 2) - b_w_radii(i) > yMin && b_w_centers(i, 2) + b_w_radii(i) < yMax
                    % The circle fits inside the checkerboard
                    if j == 1
                        validCircleIndices_w(end+1) = i; %#ok<AGROW>
                    else   
                        validCircleIndices_b(end+1) = i;
                    end   
                end
            end
        end
    end       

% Display the valid white and black circles
%format long g
%disp([whiteCenters(validCircleIndices_w,:), whiteRadii(validCircleIndices_w)]);
%disp([blackCenters(validCircleIndices_b,:), blackRadii(validCircleIndices_b)]);
%disp (centers(:,:));
    if ~isempty(validCircleIndices_w) && length(validCircleIndices_b)>=2        
        stopWhileloop = 1;
        while stopWhileloop == 1
            for m=1:length(validCircleIndices_b)
                for n=m+1:length(validCircleIndices_b)
                    if sqrt((blackCenters(validCircleIndices_b(m),1) - blackCenters(validCircleIndices_b(n),1))^2 + (blackCenters(validCircleIndices_b(m),2) - blackCenters(validCircleIndices_b(n),2))^2)>50 && sqrt((blackCenters(validCircleIndices_b(m),1) - blackCenters(validCircleIndices_b(n),1))^2 + (blackCenters(validCircleIndices_b(m),2) - blackCenters(validCircleIndices_b(n),2))^2)<170
                        b_centers(1,:) = blackCenters(validCircleIndices_b(m),:);
                        b_centers(2,:) = blackCenters(validCircleIndices_b(n),:);
                        w_center = whiteCenters(validCircleIndices_w(1), :);
                        stopWhileloop = 0;
                    end
                end
            end 
            stopWhileloop = 0;
        end
    end
     
%disp (w_center
%disp (b_centers);
end



%{ 
Plot the image and draw bounding box and valid ellipses
figure;
imshow(img);
hold on;

Draw the bounding box
rectangle('Position', checkerboardBoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
Plot valid circles that fall within the checkerboard
viscircles(allCenters(validCircleIndices,:), allRadii(validCircleIndices), 'EdgeColor', 'b');
hold off;

title('Checkerboard boundary and detected black and white ellipses inside boundary');
%}

 

