function mergedImg = GlobalImgMerge(imgList, weightList)
%GLOBALIMGMERGE Merge a groupd of images with given weights
%   Input: a group of image data, a group of weights
%   Merge these images into one image as the output
%   imgList: a gropup of image data, with same size, channel number, etc.
%            pixel values are in double
%   weightList: a group of weights (the sum should be 1.0)
%   mergedImg: the merged image, pixel value in double

if nargin ~= 2
    disp('wrong argument number for function GlobalImgMerge');
    mergedImg = [];
    return;
end

if (numel(imgList) ~= numel(weightList)) || (numel(imgList) == 0)
    disp('imgList & weightList should be of same size, not empty');
    mergedImg = [];
    return;
end

imgSize = size(imgList{1});
for i = 2:numel(imgList)
    if (~isequal(size(imgList{i}), imgSize))
        disp('all images should have the same size');
        mergedImg = [];
        return;
    end
end

weightSum = 0;
for i = 1:numel(weightList)
    weightSum = weightSum + weightList{i};
end
if abs(weightSum - 1.0) > 0.05
    disp('the sum of all weights should be around 1.0');
    mergedImg = [];
    return;
end

mergedImg = imgList{1} * weightList{1};
for i = 2:numel(imgList)
    mergedImg = mergedImg + imgList{i} * weightList{i};
end

end

