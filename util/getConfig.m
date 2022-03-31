function configValue = getConfig(configName)
%GETCONFIG 根据configName返回configValue
%   configName为字符串，configValue为对应值（比如路径、数字）
    if (strcmp(configName,'BasePath'))
        configValue = 'D:\xing\workspace\matlab\VIFB-master';
    end
end

