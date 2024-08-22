% Code written by Ravi Chawla - see readme for contact information
% This script used imfindcircles function to find circles
% Dependencies/Apps: Image Processing Toolbox and Statistics & Machine Learning Toolbox/

%Internal housing keeping notes, no bearing to code usage:
% Code derived from file Test_imfindcircles_230901_v2_edited240503.m 

clc; close all; clear all;

%Read all the tif files in the directory. If image files are in a subdirectory, 
%try changing line below to read "Amov = dir ('**\*.tif');" or "Amov = dir ('**/*.tif');"
Amov = dir ('*.tif');
a=numel(Amov);

%Iterate through all the tif files
for i=1:a

input('Press any number to proceed') 
close all;
i = input('Enter image number')


filename = getfield (Amov,{i,1},'name')

A = imread(filename);

X = A;
Y =imadjust(A);
imshow(Y)

Y = imclearborder(Y); %Exclude data at the image border

m = input('Enter 0 if default and 1 to adjust params')
%Default case means image analysis with default imfindcircles with parmas
% Sensitivty = 0.85
% Rmin1 = 6; Rmax1 = 90;
% Default case is useful when the data is reliably in the above param range
% Non-default case of m=1 is the more frequent use case

if m==0 

    Rmin1 = 6;
    Rmax1 = 90;
    [centers,radii,~] = imfindcircles(Y,[Rmin1 Rmax1],'ObjectPolarity','bright','Sensitivity',0.85);
    
    b1 = size(centers);
    len1 = b1(1,1);
    
    radii1 = [];
    
    BW1 = false(size(Y,1),size(Y,2));
    [Xgrid,Ygrid] = meshgrid(1:size(BW1,2),1:size(BW1,1));
    for n = 1:len1
    BW1 = BW1 | (hypot(Xgrid-centers(n,1),Ygrid-centers(n,2)) <= radii(n));
    radii1(n,1) = radii(n);
    end
    
    ndrops = n; 

    str = filename;
    str_trim = str(1:strfind(str,'.')-1)
    mkdir([str_trim 'analysis'])
    
 
    dlmwrite(['./' str_trim 'analysis/' str_trim '_radii.txt'],radii1,'delimiter','\t')
    dlmwrite(['./' str_trim 'analysis/' str_trim '_RadiiRange.txt'], [Rmin1 Rmax1 0.85   ndrops ],'delimiter','\t')

    
    % Create masked image.
    maskedImage1 = Y;
    maskedImage1(~BW1) = 0;
    
    [centersBright1, radiiBright1] = imfindcircles(Y,[Rmin1 Rmax1],'ObjectPolarity','bright', 'Sensitivity',0.85);
    viscircles(centersBright1, radiiBright1,'Color','b');  
    
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure1_circles'])
   
    
    %Binary
    BW_out = BW1;
   
    figure(2)
    histogram(radii1, 20)
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure2_histogram'])
    
    figure(3)
    ecdf(radii)
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure3_radii'])
    
    % Get properties
    props = regionprops(BW_out, {'Area','Eccentricity', 'EquivDiameter', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Circularity','Centroid',});
    propsTable = struct2table(props);    
    str_up = append(str_trim,'_propsTable')
    
    Dia_px = propsTable.EquivDiameter;
    px2um = 0.11;
    EquivDia_um = Dia_px * px2um;
    dlmwrite(['./' str_trim 'analysis/' str_trim '_EquDiaum.txt'], EquivDia_um,'delimiter','\t')
    
    Dia1_px_raw = 2*radii1;
    
    figure(4)
    ecdf(Dia_px)
    hold on
    ecdf(Dia1_px_raw)
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure4_Diameter'])
    
    % mkdir([str_trim 'analysis'])
    save(['./' str_trim 'analysis/' str_trim '.mat'],'-v7.3');
    writetable(propsTable,['./' str_trim 'analysis/' str_up])

end 


if m==1

    Rmin1 = 6;
    Rmax1 = input('Enter max radius')
    Sens = input('Sensitivity between 0 to 1, default 0.85')
    [centers,radii,~] = imfindcircles(Y,[Rmin1 Rmax1],'ObjectPolarity','bright','Sensitivity',[Sens]);
  
    
    b1 = size(centers);
    len1 = b1(1,1);
    
    radii1 = [];
    
    BW1 = false(size(Y,1),size(Y,2));
    [Xgrid,Ygrid] = meshgrid(1:size(BW1,2),1:size(BW1,1));
    for n = 1:len1
    BW1 = BW1 | (hypot(Xgrid-centers(n,1),Ygrid-centers(n,2)) <= radii(n));
    radii1(n,1) = radii(n);
    end
    
    ndrops = n; 

    str = filename;
    str_trim = str(1:strfind(str,'.')-1)
    mkdir([str_trim 'analysis'])
    
    dlmwrite(['./' str_trim 'analysis/' str_trim '_radii.txt'],radii1,'delimiter','\t')
    dlmwrite(['./' str_trim 'analysis/' str_trim '_ParamsRange.txt'], [Rmin1 Rmax1 Sens ndrops],'delimiter','\t')

    
    % Create masked image.
    maskedImage1 = Y;
    maskedImage1(~BW1) = 0;
    
    [centersBright1, radiiBright1] = imfindcircles(Y,[Rmin1 Rmax1],'ObjectPolarity','bright', 'Sensitivity',[Sens]);
    viscircles(centersBright1, radiiBright1,'Color','b');
    
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure1_circles'])
   
    
    %Binary
    BW_out = BW1;
    
    figure(2)
    histogram(radii1, 20)

    saveas(gcf, ['./' str_trim 'analysis/' 'Figure2_histogram'])
    
    figure(3)
    ecdf(radii)
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure3_radii'])
    
    % Use RegionProps function to get properties
    % We are specifically interested in getting EquivDiameter
    props = regionprops(BW_out, {'Area','Eccentricity', 'EquivDiameter', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Circularity','Centroid',});
    propsTable = struct2table(props);
    
    str_up = append(str_trim,'_propsTable')
    
    Dia_px = propsTable.EquivDiameter;
    px2um = 0.11;
    EquivDia_um = Dia_px * px2um;

    dlmwrite(['./' str_trim 'analysis/' str_trim '_EquivDiaum.txt'], EquivDia_um,'delimiter','\t')
    
    Dia1_px_raw = 2*radii1;
    
    figure(4)
    ecdf(Dia_px)
    hold on
    ecdf(Dia1_px_raw)
    saveas(gcf, ['./' str_trim 'analysis/' 'Figure4_Diameter'])

    % mkdir([str_trim 'analysis'])
    save(['./' str_trim 'analysis/' str_trim '.mat'],'-v7.3');
    writetable(propsTable,['./' str_trim 'analysis/' str_up])

end 

TidyData_PostSegmentation_v1_240511
%TidyData_withinSegmentationCode_v8_230824B_edited230901_v3 %For analysis of GC content
%TidyData_withinSegmentationCode_v8_230824B_edited230901_v2 %For analysis of P300
%TidyData_withinSegmentationCode_v6_230615
%TidyData_withinSegmentationCode_v8_230824
%TidyData_withinSegmentationCode_v8_230824B
%TidyData_withinSegmentationCode_v8_230824B_edited230901
%TidyData_withinSegmentationCode_v8_230901_DNAConcExpt
%TidyData_withinSegmentationCode_v8_230901_DNAConcExpt_B


end
