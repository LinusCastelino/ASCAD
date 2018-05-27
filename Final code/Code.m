function Code(P, A, D, IP)
warning off;

P_name= P;    %input('Enter Patient name : ','s');
P_age= A;
D_name= D;    %input('Enter Doctor (medical practioner) name : ','s');
%img_input = input('Enter the image index : ');
img_path= IP;    %strcat('C:\AAA\Img\',int2str(img_input),'.jpg');
img= imread(img_path);

figure, imshow(img);
 
img_grayS = rgb2gray(img);
figure, imshow(img_grayS);

%histogram stretching
bins = linspace(0,255,256);
H = hist(img_grayS(:), bins);
H(H==0) = eps(sum(H));
cdf = [0,cumsum(H)/sum(H)];    %cumulative distribution function
pct= 0.05;    %percent of pixel values to ignore
h_low = interp1(cdf, [0,bins], pct);
h_high = interp1(cdf, [0,bins], 1-pct);
stretchedImg= uint8((double(img_grayS)-h_low)/(h_high-h_low) * 255);
%img_grayS= uint8(imadjust(img_grayS, stretchlim(img_grayS), []));    %histogram stretching using inbuilt function
figure, imshow(stretchedImg); 

BW_c= imcomplement(stretchedImg);
BW_filled= imfill(BW_c,4, 'holes');
BW_refined= imcomplement(BW_filled);
figure, imshow(BW_refined);

%Gaussian filter
myfilter = fspecial('gaussian',[3 3],16); 
filteredImg = imfilter(BW_refined, myfilter, 'replicate'); 
 

img_binary= im2bw(BW_refined,graythresh(filteredImg));   % converting the enhanced image to binary
figure, imshow(img_binary); 

img_binary_c= imcomplement(img_binary);    %bwareaopen and bwconncomp works only on bright pixels
refined_img= bwareaopen(img_binary_c,200, 4);    %removing unwanted spots from the image having a maximum pixel density of 200 pixels
figure, imshow(refined_img);
 
%EROSION (EXPERIMENTAL) 
se = strel('disk',2);  
erodedBW = imerode(refined_img,se);    %Shrinks each 'disk' shaped object in the image 
figure, imshow(erodedBW);

img_binary1 = imclearborder(erodedBW); %remove border objects
figure, imshow(img_binary1);

CC= bwconncomp(img_binary1, 4);    % keeping connectivity 4 to ignore diagonal connection
CA= regionprops(CC, 'Area');    %returns the areas of all objects in the image identified by bwconncomp()
CP= regionprops(CC, 'Perimeter');    %returns the perimeters of all objects in the image identified by bwconncomp()
img_binary2= imcomplement(img_binary1);

areas= cell(CC.NumObjects,1);    %storing the area of individual components from CA.Area
                                 %CA.Area is not feasible to use for computations 
                                 
for i=1: CC.NumObjects
    areas{i,1}= CA(i,1).Area;
end
areas= cell2mat(areas);    %converting the cell to array

iqr= quantile(areas,0.75)-quantile(areas,0.25);      %inter quartile range

average=iqr*1.5;    %going by the definition of an outlier

%counting the number of valid and invalid cels in the image (only considering the objects with areas within the inter quartile range)
validCells=0; invalidCells=0;
for i=1:CC.NumObjects
    if CA(i,1).Area >= quantile(areas,0.25)-average && CA(i,1).Area <= quantile(areas,0.75)+ average
        validCells= validCells+1;
    else
        invalidCells= invalidCells+1;
    end
end

%calculating the metric value for each valid cell
metric= cell(validCells ,1);
k=1;
for i=1:CC.NumObjects
    if CA(i,1).Area >= quantile(areas,0.25)-average && CA(i,1).Area <= quantile(areas,0.75)+ average 
        metric{k,1} = (4*pi*CA(i,1).Area)/(CP(i,1).Perimeter * CP(i,1).Perimeter);
        k=k+1;
    end
end

normal=0; abnormal=0;

for i=1:validCells
   if metric{i,1}>=0.75    %all cells with a metric value above 0.75 are considered normal, as they prove to be more circular
       normal=normal+1;
   else
       abnormal=abnormal+1;
   end
   
end

threshold=0.1*validCells;    % 10 percent of the number of valid cells 


%printing the report
disp(sprintf('\n\nReport :-'));
disp(sprintf('Patient name : %s', P_name));
disp(sprintf('Patient age : %s', P_age));
disp(sprintf('Doctor / Medical practioner name : %s', D_name));
disp(sprintf('Image Path : %s', img_path));
disp(sprintf('\nTotal number of objects detected\t=  %d',CC.NumObjects));
disp(sprintf('Number of valid cells\t\t\t\t=  %d',validCells));
disp(sprintf('Number of normal cells\t\t\t\t=  %d',normal));
disp(sprintf('Number of abnormal cells\t\t\t=  %d',abnormal));
disp(sprintf('Threshold \t\t\t\t\t\t\t=  %f',threshold));
if abnormal>threshold
    disp(sprintf('\nResult : \t\tYou are diagnosed with Sickle Cell Anaemia.\n'));
    msgbox(sprintf(' Patient name : %s\n Patient age : %s\n Doctor / Medical practioner name : %s\n Image Path : %s\n\n Total number of objects detected\t=  %d\n Number of valid cells\t\t\t\t=  %d\n Number of normal cells\t\t\t\t=  %d\n Number of abnormal cells\t\t\t=  %d\n Threshold \t\t\t\t\t\t\t=  %f\n\n Result : \t\tYou are diagnosed with Sickle Cell Anaemia.\n', P_name, P_age, D_name, img_path, CC.NumObjects, validCells, normal, abnormal, threshold),'Report- Positive');
else
    disp(sprintf('\nResult : \t\t›ou are safe.\n'));
    msgbox(sprintf(' Patient name : %s\n Patient age : %s\n Doctor / Medical practioner name : %s\n Image Path : %s\n\n Total number of objects detected\t=  %d\n Number of valid cells\t\t\t\t=  %d\n Number of normal cells\t\t\t\t=  %d\n Number of abnormal cells\t\t\t=  %d\n Threshold \t\t\t\t\t\t\t=  %f\n\n Result : \t\tYou are safe.\n', P_name, P_age, D_name, img_path, CC.NumObjects, validCells, normal, abnormal, threshold),'Report- Negative');
end

end    %function Code end