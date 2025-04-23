    
% Name: Phuntsho Namgyel
% Student ID: 21557163
% Title: function to swap coordinates of two points



function ImgInfo = Swapping_b1_b2(ImgInfo, j)
    temp1 = ImgInfo.b1_dot_X(j);
    temp2 = ImgInfo.b1_dot_Y(j);
    ImgInfo.b1_dot_X(j) = ImgInfo.b2_dot_X(j);
    ImgInfo.b1_dot_Y(j) = ImgInfo.b2_dot_Y(j);
    ImgInfo.b2_dot_X(j) = temp1;
    ImgInfo.b2_dot_Y(j) = temp2;
end