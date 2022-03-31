% This is used to set the path to visible images
%
% Please change the path in line 16 to your own path before running
%
% Author:Xingchen Zhang, Ping Ye, Gang Xiao
% Contact: xingchen.zhang@imperial.ac.uk
%
% If you use this code, please site the following paper:
%
% X. Zhang, P. Ye, G. Xiao. VIFB:A Visible and Infrared Benchmark. In
% Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern
% Recognition Workshops, 2020.

function imgs=configImgsIR

    path = [getConfig('BasePath') '\input\'];

    img_IR = {
    struct('name','carLight','path',strcat(path,'IR\'),'ext','jpg'),...
    };
%     struct('name','carShadow','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','carWhite','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','elecbike','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','fight','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','kettle','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','labMan','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','man','path',strcat(path,'IR\'),'ext','jpg'),...
%      struct('name','manCall','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','manCar','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','manlight','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','manWalking','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','manwithbag','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','nightCar','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','peopleshadow','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','running','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','snow','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','tricycle','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','walking','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','walking2','path',strcat(path,'IR\'),'ext','jpg'),...
%     struct('name','walkingnight','path',strcat(path,'IR\'),'ext','jpg'),...

imgs=[img_IR];