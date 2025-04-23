% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: Transform the points ID



function imagePoints = labels_Transformation(imagePoints, ImgInfo, j, imagepath)
    if ImgInfo.orientation(j) == 1
        % Find the index of the minimum value in the 3rd column (Y column)
        [~, minIndex] = min(imagePoints(:,3));
        fprintf('label for firstPoint is: %d\n', minIndex);
        if minIndex == 1 || minIndex == 70
            imagePoints = transform_parameters(imagePoints, minIndex);
        else
            imagePoints = NaN;
        end    

    elseif ImgInfo.orientation(j) == 2
        % Find the index of the maximum value in the 2nd column (X column)
        [~, maxIndex] = max(imagePoints(:,2));
        minIndex = maxIndex;
        fprintf('label for firstPoint is: %d\n', minIndex);
        if minIndex == 1 || minIndex == 70
            imagePoints = transform_parameters(imagePoints, minIndex);
        else
            imagePoints = NaN;
        end    
  

    elseif ImgInfo.orientation(j) == 3
        % Find the index of the maximum value in the 3rd column (Y column)
        [~, maxIndex] = max(imagePoints(:,3));
        minIndex = maxIndex;
        fprintf('label for firstPoint is: %d\n', minIndex);
        if minIndex == 1 || minIndex == 70
            imagePoints = transform_parameters(imagePoints, minIndex);
        else
            imagePoints = NaN;
        end    
 

    elseif ImgInfo.orientation(j) == 4
        % Find the index of the minimum value in the 2nd column (X column)
        [~, minIndex] = min(imagePoints(:,2));
        fprintf('label for firstPoint is: %d\n', minIndex);
        if minIndex == 1 || minIndex == 70
            imagePoints = transform_parameters(imagePoints, minIndex);
        else
            imagePoints = NaN;
        end    
         

    end

    if ~isnan(imagePoints)
        image = imread(imagepath);
        image1 = insertText(image, imagePoints(:,2:3,1), imagePoints(:,1));
        %image1 = insertMarker(image1, imagePoints, 'o', 'MarkerColor', 'red', 'Size', 5);
        % Step 5: Display the detected points on the image
        imshow(image1);
    end
    
end 

