function [tot_feat] = extract_gist(impath)
%
% Copyright Aditya Khosla http://mit.edu/khosla
%
% Please cite this paper if you use this code in your publication:
%   A. Khosla, J. Xiao, A. Torralba, A. Oliva
%   Memorability of Image Regions
%   Advances in Neural Information Processing Systems (NIPS) 2012
%

% if(~exist('c', 'var'))
%   c = conf();
% end

% feature = 'gist';
% p = c.feature_config.(feature);
img = imread(impath)
p.maxsize = 500;
p.imageSize = [256 256];
p.orientationsPerScale = [8 8 8 8];
p.numberBlocks = 4;
p.fc_prefilt = 4;
p.feature_size = 512;

p.train_file = ['%s/train_gist_' num2str(p.feature_size) '.mat'];
p.test_file = ['%s/test_gist_' num2str(p.feature_size) '.mat'];
feat = LMgist(img, [], p);
imglab = rgb2lab(img);
hist_feat = imhist(imglab, 30) / numel(imglab);
tot_feat = [feat, hist_feat'];
