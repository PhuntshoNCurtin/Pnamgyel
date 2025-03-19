
% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: Extraction of corner points from Checkerboard

% Step 1: Load a single image (specify the image file path)
image = imread('/Users/phuntshonamgyel/Desktop/checkerboardimages/images/367_BML_F00840_Q02.jpg');

% Step 2: Detect checkerboard points
[imagePoints, boardSize] = detectCheckerboardPoints(image, 'HighDistortion', true);

% Step 3: Mark the points with red circles and label them
image1 = insertText(image,imagePoints(:,:,1), 1:size(imagePoints, 1));
image1 = insertMarker(image1, imagePoints, 'o', 'MarkerColor', 'red', 'Size', 5);

% Step 4: Display the detected points on the image
imshow(image1);

% Step 5: Save the coordinates to a text file with PointID, x, y
filename = 'image_points_Auto.txt'; 
fileID = fopen(filename, 'w');

for i = 1:size(imagePoints, 1)
    % Write PointID, x, y
    fprintf(fileID, '%d %.2f %.2f\n', i, imagePoints(i, 1), imagePoints(i, 2));
end