
% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: Extraction of reference Points from Checkerboard

% Read the image (replace with your checkerboard image)
img = imread(fullfile('images', '367_BML_F00840_Q01.jpg'));

% Display the image
figure;
imshow(img);
title('Select 6 Corner Points (Click to Zoom, Press Enter to Confirm Each Selection)');

% Initialize points storage
points = zeros(6, 3); % 3rd column for point ID

% Loop to pick 6 points with zoom functionality
for i = 1:6
    h = zoom; % Enable zoom
    h.Direction = 'in'; % Zoom in by default
    zoom on;
    disp(['Select point ' num2str(i) ' and press Enter to zoom']);
    
    % Wait for user to zoom and select a point
    pause;
    zoom off; % Disable zoom to select the point
    
    % Select a point
    [x, y] = ginput(1);
    
    % Prompt the user for point ID
    prompt = ['Enter ID for point ' num2str(i) ': '];
    point_id = input(prompt);
    
    % Store selected point with ID
    points(i, :) = [point_id, x, y];
    
    % Display a marker on the selected point
    hold on;
    plot(x, y, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    
    % Ask if user is satisfied with the selection
    answer = questdlg('Are you satisfied with this point?', ...
        'Confirmation', ...
        'Yes', 'No', 'Yes');
    
    if strcmp(answer, 'No')
        i = i - 1; % Repeat this iteration
    end
    
    % Zoom back to full image for next point selection
    imshow(img); 
end

% Display the coordinates in the command window
for i = 1:6
    fprintf('Point ID %d: (X, Y) = (%.2f, %.2f)\n', points(i, 1), points(i, 2), points(i, 3));
end

% Save the coordinates to a text file without additional formatting
fileID = fopen('image_points_manual.txt', 'w');
for i = 1:6
    fprintf(fileID, '%d %.2f %.2f\n', points(i, 1), points(i, 2), points(i, 3));
end
fclose(fileID);

disp('Coordinates with point IDs have been saved to selected_points_with_id.txt');