% deface.m
sharedir = ''; % select location of defaced anatomicals
anatfs = dir([sharedir '\*ANAT.nii']); % alter depending on naming convention
sn = 20; % subject number
for s = 1:sn
        anat = anatfs(s).name;
        nii = load_untouch_nii([sharedir '\' anat]);
		% settings will depend on matrix size - default should work for spm8
		xslice = 70; 
		yslices = 130:192;
        nii.img(1:xslice,yslices,:,:) = 0;
        ind = 0;
        for i = 80:131 % ditto above
            ind = ind + 1;
            depth = round(xslice/50*ind);
            nii.img(1:depth,i,:,:)=0;
        end
        save_untouch_nii(nii,anat);
        disp(s)
end
    