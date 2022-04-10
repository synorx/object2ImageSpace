%%
%--This code written by Alperen Düzen--

%Code provides Object Space to Image Space transformation with help of the
%Projection Matrix in homogeneous coordinates and show the coordinates on
% 106.jp2 image

%% Code Parts 1 
%World2Camera Transformation
image = imread('106.jp2');

%Focal Lenght in mm(f) and pixel size in mm
f = 120;
pixel_size=0.012;
%rooftop Coordinates which transform the Object to Image with 1
rooftop=[497312.615 ,     5419964.073 ,         311.650 , 1; 
        497319.591,       5419956.416 ,         311.650 , 1; 
        497324.876 ,      5419961.722 ,         313.700 , 1; 
        497328.801 ,      5419964.973 ,         311.650 , 1; 
        497322.057 ,      5419972.217 ,         311.650 , 1; 
        497318.113 ,      5419968.575 ,         314.300 , 1;
        497312.615 ,      5419964.073 ,         311.650 , 1; ];
 
%Rotational angles(gons) convert to radians and Rotational Matrix Form
omega = (-0.53451)*0.0157079633;
phi = (-0.19025)*0.0157079633;
kappa = (-0.13489)*0.0157079633;

%Rotational matrix 4*4
r_11 = cos(phi) * cos(kappa) + sin(phi) * sin(omega) * sin(kappa);
r_12 = cos(omega)*sin(kappa);
r_13 = -sin(phi)*cos(kappa) + cos(phi)*sin(omega)*sin(kappa);
r_21 = -cos(phi)*sin(kappa)+sin(phi)*sin(omega)*cos(kappa);
r_22 = cos(omega)*cos(kappa);
r_23 = sin(phi)*sin(kappa)+cos(phi)*sin(omega)*cos(kappa);
r_31 = sin(phi)*cos(omega);
r_32 = -sin(omega);
r_33 = cos(omega)*cos(phi);

rotationanl_matrix = [r_11 r_12 r_13 0;r_21 r_22 r_23 0;r_31 r_32 r_33 0;0 0 0 1];
% 4*4 Translation matrix with Projection Centers Coordinates on Image
c_matrix=[1 0 0 -497312.996; %X
          0 1 0 -5419477.065;%Y 
          0 0 1 -1158.888; %Z
          0 0 0 1];

%Rigid Transformation
world2camera=[];
for i=1:7
world2camera(:,i)=rotationanl_matrix*c_matrix*[rooftop(i,1);rooftop(i,2);rooftop(i,3);rooftop(i,4)];
end

%% Part 2
%Camera2Film transformation

%Perspective Projection
PP = [-f 0 0 0 ; 0 -f 0 0; 0 0 1 0 ];
%It's a transverse part of camera to film transformation
transverse=[];
for k=1:7
transverse(:,k)=[world2camera(1,k)/world2camera(3,k);world2camera(2,k)/world2camera(3,k);world2camera(3,k);1];
end
%Film Coordinates
camera2film = PP*transverse;

%% Part 3
%Film coordinates transformation pixel(image) Space 
%u=column v=row for six rooftop coordinates
u=[];
v=[];
for j=1:7
u(1,j)=3840 + camera2film(1,j)/pixel_size;
v(1,j)=6912 - camera2film(2,j)/pixel_size;
end

%% Final Part
%Show the points o Image
imshow(image, []);
hold on;
plot( u, v, 'r-','MarkerSize', 4);

str={'1','2','3','4','5','6',' -7'};
text(u,v,str)





