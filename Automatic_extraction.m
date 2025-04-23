% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: Extraction of corner points from Checkerboard

function [imagePoints, numPoints] = Automatic_extraction(imagepath)
    % Step 1: Load a single image (specify the image file path)
    image = imread(imagepath);
    
    % Step 2: Detect checkerboard points
    [imagePoints, boardSize] = detectCheckerboardPoints(image, 'HighDistortion', true);
    
    % Step 3: Check if checkerboard was detected
    if isempty(imagePoints)
        warning('No checkerboard detected in the image.');
        imshow(image);
        imagePoints = NaN;  % Assign NaN to indicate no detection
        numPoints = 0;
        return;
    end
    
    % Step 4: Remove invalid (NaN or Inf) points
    if any(isnan(imagePoints(:))) || any(isinf(imagePoints(:)))
        warning('Detected NaN or Inf values in imagePoints. Returning default values.');
        imagePoints = NaN;
        numPoints = 0;
        return;
    end
   
    % Step 5: Count the number of detected points
    numPoints = size(imagePoints, 1);
    if numPoints < 70 || numPoints > 70
        warning('Checkerboard points detected in the image: %d', numPoints);
        imagePoints = NaN;
        numPoints = 0;
        return;
    end
    
    
    % Step 6: Add a new first column with serial numbers (1 to numPoints)
    label_ID = (1:numPoints)';  % Create a column vector [1, 2, 3, ..., numPoints]
    imagePoints = [label_ID, imagePoints];  % Add it as the first column
    
  %{
    % Step 7: Mark the points with red circles and label them
    image1 = insertText(image, imagePoints(:,2:3), imagePoints(:,1));
    % image1 = insertMarker(image1, imagePoints(:,2:3), 'o', 'MarkerColor', 'red', 'Size', 5);
    
    % Step 8: Display the detected points on the image
    imshow(image1);
  %} 

    % Step 9: Save the coordinates to a text file with PointID, x, y
    points_File = 'image_points_Auto.txt'; 
    fileID = fopen(points_File, 'w');
    
    if fileID == -1
        error('Cannot open file for writing.');
    end
    
    for i = 1:numPoints
        % Write PointID, x, y
        fprintf(fileID, '%d %.2f %.2f\n', i, imagePoints(i, 2), imagePoints(i, 3));
    end
    
    fclose(fileID); % Close the file
end