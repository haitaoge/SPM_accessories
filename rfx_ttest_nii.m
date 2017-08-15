function rfx_ttest_nii
tic
% prompt for images
files = spm_select([1,Inf],'image');
% make 4D brain
subn = size(files,1);
for i = 1:subn
    nii = load_nii(files(i,1:end-2));
    if i == 1
        brain4D = zeros([size(nii.img) subn]);
    end
    brain4D(:,:,:,i) = nii.img;
end
mask = isnan(sum(brain4D,4));
% perform ttest
[~,~,~,stats]=ttest(brain4D,0,.95,'both',4);
% write output
niiout = nii;
niiout.img = stats.tstat;
niiout.img(mask) = 0;
niiout.descrip = ['SPM{T_[' num2str(subn-1) '.0]} - one sample random effects t-test'];
niiout.hdr.hist.descrip = ['SPM{T_[' num2str(subn-1) '.0]} - one sample random effects t-test'];
niiout.fileprefix = 'RFXT';
filename = 'RFXT.nii';
save_nii(niiout,filename);
disp('Done!')
toc
return