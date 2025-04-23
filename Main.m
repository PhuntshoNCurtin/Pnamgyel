%start set up/clear
clc                         %clear screen
clear                       %clear break point
close all
format long                 %define format

%dimension of image in mm
img_length = 35.8;

%Create new directory to save all the final image points
if ~exist('All_imagePoints', 'dir')
    mkdir('All_imagePoints');
end

%Create empty list
ImageCountList = zeros(0, 2);

%1. Try to improve on circle detection at different angle and brightness
%2. Try to improve on corner detection at different angle and brightness
%3. Try to improve at when first point = 64 or 7
%4. Try to improve how to assign point_ID if the detected corner points have NaN values



% find subfolders
%----------------------
% Get a list of all files and folders in this folder.
files = dir;
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
n_folders=max(size(subFolders));

%----------------------
% find files in each sub folder (skip first 2)
%----------------------

for i=3:n_folders
    counter = 0;
    dir_str=subFolders(i).name;
    
    cmd_str=sprintf('%s/*.jpg',dir_str);
    files=dir(cmd_str);

    n_files=max(size(files));

    VarType = ["string","double", "double","double", "double", "double", "double","double", "double"];
    VarNames = ["name", "orientation", "angle", "W_dot_X", "W_dot_Y", "b1_dot_X", "b1_dot_Y", "b2_dot_X", "b2_dot_Y"];
    ImgInfo = table('Size', [n_files 9], 'VariableTypes', VarType, 'VariableNames', VarNames);

    if n_files>1
        for j=1:n_files
            fprintf('\nImage ID: %d   Folder: %d\n', j, i-2);
            %filling up 'name' column of the table
            ImgInfo.name(j) = files(j).name;
            imagePoints = NaN;  
            numPoints = 0;
            
            %filling up x and y values of white and black circles
            imagepath = fullfile(dir_str, files(j).name);
            [w_center, b_centers, img_l_pix, img_w_pix] = circleDetect(imagepath);
            %format short g
            %disp (w_center);
            %disp (b_centers);
            ImgInfo.W_dot_X(j) = w_center(1,1);
            ImgInfo.W_dot_Y(j) = w_center(1,2);
            ImgInfo.b1_dot_X(j) = b_centers(1,1);
            ImgInfo.b1_dot_Y(j) = b_centers(1,2);
            ImgInfo.b2_dot_X(j) = b_centers(2,1);
            ImgInfo.b2_dot_Y(j) = b_centers(2,2);

            %call a function to extract all image coordinates
            if ImgInfo.W_dot_X(j) ~= 0
                [imagePoints, numPoints] = Automatic_extraction(imagepath);
            end
                
            
            %call a function to perform orientation and transformation
            if ~all(isnan(imagePoints(:))) && ImgInfo.W_dot_X(j) ~= 0
                ImgInfo = detectOrientation(ImgInfo, j);
                imagePoints = labels_Transformation(imagePoints, ImgInfo, j, imagepath);
            end


            %write for this image the table with PointID, X, Y as CSV
            VarType = ["double","double", "double"];
            VarNames = ["ID", "x", "y"];
            TransImgCoor = table('Size', [numPoints 3], 'VariableTypes', VarType, 'VariableNames', VarNames);

            %turn pixels in img coordinates
            s = img_length/img_l_pix; %scale
            DeltaX = img_l_pix/2;
            DeltaY = img_w_pix/2;

            if  ~isnan(imagePoints)
                for k=1:numPoints
                    TransImgCoor.ID(k)=imagePoints(k,1);
                    TransImgCoor.x(k) = (imagePoints(k,2)-DeltaX)*s;
                    TransImgCoor.y(k) = (imagePoints(k,3)-DeltaY)*s;
                end
                [~, filename, ~] = fileparts(imagepath); 
                saveFolder = 'All_imagePoints';           % Folder to save CSVs
                csvName = fullfile(saveFolder, strcat(filename, '.csv'));  % Full path
                writetable(TransImgCoor, csvName);  
                counter = counter + 1;
            end      
        end
    end
    ImageCountList(end+1,:) = [i, counter];
end

fprintf('\nEnd');
for i = 1:size(ImageCountList,1)
    fprintf('\n\nTOTAL PROCESSABLE IMAGES FOUND IN FOLDER %d IS: %d\n', ImageCountList(i,1), ImageCountList(i,2)); 
end




