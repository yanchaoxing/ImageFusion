% This file is for Merging Fused Images - those results of VIFB. 
%
% Obviously, different Image Fusion Algorithms outperform only on some of
% the known Evaluation Metrics. So it will be informative to merge these
% Fused Images to see if the best results are in-between.
% 
% One simple way is to merge the fused images as a whole, which seems won't
% work since different regions of one image have different characteristics
% which may need a different merging strategy.
% 
% So we will have to merge the fused images region by region, and the 
% image segmentation should take image features as main clue. Here we have
% several categories of features: (1) structural features, (2) information
% entropy, (3) contour, edges, (4) texture, (5) maybe human perception.
% 
% Step 1: Merge 2~4 fused images globally
%         Choose the BEST algorithms for each category (evaluation metric)
% Step 2: Calculate the evaluation metrics for each iteration, plot cure
%         find the "best" metrics
% Step 3: Analyze global merging results - merged images together with the
%         metrics, calculate the Average Metrics Improvement
% Step 4: Choose suitable/all image features for segmenting images into
%         different regions with a category flag, then perform Adaptive
%         Local Merging. Repeat Step 1~3, hope a better result is there.
% Step 5: Take the image information entropy into account to control the
%         weighting scheme
%
% If you use this code, please cite the following paper:
%
% X. Zhang, P. Ye, G. Xiao. VIFB:A Visible and Infrared Benchmark. In
% Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern
% Recognition Workshops, 2020.
%
% [Maybe another paper here.]
%
% Thanks a lot!
%
% For more information, please see https://github.com/yanchaoxing/ImageFusion
%
% Contact: xingyanchao@hotmail.com

close all
clear
clc
warning off all;

% NOTE: the ending '\' for each path is always omitted, you need add one
%       before use each path

addpath('.\util');
addpath(['.\methods'])
addpath(['.\methods\AdaptiveMerge'])

path = [getConfig('BasePath') '\output'];
outputPath = [path '\fused_images'];

% get Visible Image Array & InfraRed Image Array
imgsVI = configImgsVI;
imgsIR = configImgsIR;
% get Image Fusion Algorithm Array
methods = configMethods;

numImgsVI = length(imgsVI); % Image Number
numImgsIR = length(imgsIR);
numMethods = length(methods); % Algorithm Number

if ~exist(outputPath,'dir')
    mkdir(outputPath);
end

carLightADF = imread([outputPath '\carLight_ADF.jpg']);
carLightNSCT_SR = imread([outputPath '\carLight_NSCT_SR.jpg']);

carLightADFDbl = im2double(carLightADF);
carLightNSCT_SRDbl = im2double(carLightNSCT_SR);

imgList = {carLightNSCT_SRDbl carLightNSCT_SRDbl};
weightList = {0.3 0.7};

mergedImageDbl = GlobalImgMerge(imgList, weightList);

imwrite(mergedImageDbl, [outputPath '\mergedImage.jpg']);

visualization = 0;

for idxMethod = 1:numMethods
    m = methods{idxMethod};
    t1 = clock;

    j = 0;
    for idxImgs = 1:length(imgsVI)
        sVI = imgsVI{idxImgs};
        sIR = imgsIR{idxImgs};

        sVI.img = strcat(sVI.path,sVI.name, '.',sVI.ext);
        sIR.img = strcat(sIR.path,sIR.name, '.',sIR.ext);

        imgVI = imread(sVI.img);
        imgIR = imread(sIR.img);

        [imgH_VI,imgW_VI,chVI] = size(imgVI);
        [imgH_IR,imgW_IR,chIR] = size(imgIR);
        
        % check whether the result exists
        if exist([outputPath sVI.name '_' m.name '.jpg'], 'file')
            continue;
        end
        
        disp([num2str(idxMethod) '_' m.name ', ' num2str(idxImgs) '_' sVI.name])       

        funcName = ['img = run_' m.name '(sVI, sIR, visualization);'];

        try

            cd(['./methods/' m.name]);
            addpath(genpath('./'))
            
            eval(funcName);
            j=j+1;
            
        catch err
            disp('error');
            rmpath(genpath('./'))
            cd('../../')
            continue;
        end
        
        imwrite(img, [outputPath '/' sVI.name '_' m.name '.jpg']); 
        cd('../../');
    end
    
    t2 = clock;
    runtimeAverage = etime(t2,t1)./j;
        
    str=['The total runtime of ' m.name ' is: ' num2str(etime(t2,t1)) 's'];
    disp(str)
    
    str=['The average runtime of ' m.name ' per image is: ' num2str(runtimeAverage) 's'];
    disp(str)
end
