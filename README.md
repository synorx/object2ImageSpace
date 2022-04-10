# object2ImageSpace


1.	Introduction
In recent years, it can be said that there has been a huge increase in photos taken with everyone accessible to cameras and smartphones. These machines can convert the object that the human eye sees in 3D into 2 dimensions and we can filter, interpret, analyze and obtain a lot of information. From phone cameras, we can identify human faces, vehicle license plates from security cameras, agricultural areas from satellite images, roads and buildings from aerial images. How does it transformation a 3D object to 2D object and accurately know their location and height over 2 dimensions?
In this project, the 3D rooftop coordinates of a building by transformation the aerial photo given on the given air photo and the calculation of the height of the building will be explained.

2.	Object Space to Image Space Transformation
Different coordinate systems are used to define the coordinates of an object's location. This is because of where the object we define is. Different coordinate systems are used and transformations are made between each other because the same coordinates cannot be used when defining an object on Earth or defining an object through a photo. Three transformations are required to transform the coordinates of the 6 points given in the Object Space into Image Space.
The first transformation is the transformation from world coordinates to camera coordinates. 10050106.tif image file include the exterior orientation of images. The objects coordinates of the projection centers P0 = (X0, Y0, Z0) and three rotational angles (ω, φ, κ), where where ω is the primary rotation about the X-axis, φ is the secondary rotation about the rotated Y-axis, and κ is the tertiary rotation about the rotated Z-axis. The rotational angles which given the gons convert to radian. This rotational angles are related to Rotational Matrix R and R matrix defined to rotate from world coordinate system to camera coordinate system. The translate matrix related to projection centers coordinates (X0, Y0, Z0) equal to the (Cx, Cy, Cz) respectively. The each rooftop coordinates P= (X, Y, Z) represent (U,V,W).

  ![image](https://user-images.githubusercontent.com/39493696/162598308-87966b23-e7b3-4336-9568-05b1cab669d1.png)


Figure 1: Pc=R(Pw-C). Pc is Camera Coordinates(4x1), R is Rotation Matrix(4x4), Pw is World Coordinates Matrix(4x1) and C is Projection Centers Coordinates Matrix(4x4).

The second transformation is perspective projection matrix defined by from camera coordinate system to film coordinate system. This part is first phase on from 3D to 2D. The film coordinates system is a mathematically positive system. Its xc-axis is parallel to the col-axis of the file coordinate system, whereas its yc-axis is parallel to the row-axis of the file coordinate system, but points into the other direction.
 
 ![image](https://user-images.githubusercontent.com/39493696/162598328-ebdf73ef-afcd-47bf-94c5-b086901f21e1.png)   =   ![image](https://user-images.githubusercontent.com/39493696/162598353-65325abd-f9da-49ff-8e76-ba0ccfa7b186.png)  ![image](https://user-images.githubusercontent.com/39493696/162598356-821a5d6f-cb91-4291-9301-4604b0053ea6.png)   Figure 2: Camera Coordinates Pc(X, Y, Z,1),focal lenght (f), Film Coordinates (x’, y’, z’)
 

![image](https://user-images.githubusercontent.com/39493696/162598378-0cb1e4d6-5ece-43d1-8cf4-5201d2a0ee20.png)     ![image](https://user-images.githubusercontent.com/39493696/162598381-3b426d29-03be-4f80-9455-6ba363e6c3db.png) Figure 3: X, Y,Z are equal to Xc, Yc, Zc and also xc, yc are the film coordinates
 
Last transformation consists of film coordinate system to pixel coordinate system. This coordinate system is defined in the image file. Its units are [pixels], and its origin is at the left upper corner of the left upper pixel.

The image supplied consists of 13824x7680 pixels. A pixel size is 0.012 mm.







After all calculations are done in The Matlab software, the transformed points are shown on the image.

![image](https://user-images.githubusercontent.com/39493696/162598413-942b766e-f550-42f6-b140-40d9cd23ca90.png)



As you can see, all the coordinates that have been transformed are not fully placed in the corners of the roof in the image.
One of the reasons for this may be the error shares of the coordinates given in instructions. Secondly, because the image on hand is not true orthophoto, it is relief distortions because of the building location on the image.









Figure 6: Transformed points on the image

3.	Approximate Height Calculation Single Image

To make a building height shortcut, the pixel coordinates of the points that were transformed in the first section (1, 2, 3) and pixel location points with the help of Matlab data cursor were used (x1, y1), (x2, y2),(x3, y3)) which are foot points.
These points, whose direction is considered the same and determined with cursor help, and the distance between transformed points are calculated by the basic two-point distance equation. This distance obtained was then multiplied by pixel size and scale, calculating the actual size of the building.

3 different roofs and foot points were used to provide the provision. (u1, v1) = 3793,1051	(x1, y1) = 3793,1216
(u2, v2) = 3876,1142	(x2, y2) = 3876,1295 (u3, v3) = 3938,1065	(x3, y3) = 3938,1295


![image](https://user-images.githubusercontent.com/39493696/162598416-cb943d63-0e31-4e8e-a6ce-623a89ee19c7.png)   Figure 7: Sample 2 for height line
 


√(𝑢𝑛 − 𝑥𝑛)2 + (vn − yn)2
ℎ =	1000	× 0.012 × 7500

Equation 1: h is the height in meter, 0.012 pixel size in milimeter, 7500 is scale which is flying height 900 m divided by focal lenght 120 mm.


h1=14.85 meter h2=13.77 meter h3=20.7 meter

![image](https://user-images.githubusercontent.com/39493696/162598421-35adc8e4-1a42-4f1d-b1ac-ba5d9f542f67.png)


 
If it was a photo taken across, the v2foot and v3foot would be in the same places, so the h3 length specified in the drawing wouldn't have moved beyond the shape. The rotation could not be realized because we didn't know the angle between v2foot and v3foot.
That's why it's possible that it's more than it should be.
 
