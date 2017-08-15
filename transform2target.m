function transform2target(img,target)
% adjust matrix size of image to target's space


    vout = spm_vol(target);
    bsize = vout.dim;
    vi = spm_vol(img);
    v = load_nii(img);
    v = v.img;
    if length(vout)>1
        vout = vout(1);
    end
    T = vout.mat;
    outmap = NaN(vout.dim);
    [x,y,z] = ind2sub(size(v),find(~isnan(v))); % calculate indices
    xyz_vox = [x y z]';
    xyz_vox = [xyz_vox;ones(1,length(x))]; % add a row of ones to the bottom
    xyz_mni = vi.mat*xyz_vox;
    xyz = xyz_mni(1:3,:)';
    coordinate = [xyz ones(length(x),1)]*(inv(T))';
    coordinate(:,4) = [];
    coordinate = round(coordinate);
    negcor = sum(coordinate < 1,2)==0;
    coordinate = coordinate(negcor,:);
    x = x(negcor);
    y = y(negcor);
    z = z(negcor);
    hicor = coordinate(:,1) > bsize(1) | coordinate(:,2) > bsize(2) | coordinate(:,3) > bsize(3);
    coordinate = coordinate(~hicor,:);
    x = x(~hicor);
    y = y(~hicor);
    z = z(~hicor);
    for i = 1:size(coordinate,1)
        outmap(coordinate(i,1),coordinate(i,2),coordinate(i,3))=v(x(i),y(i),z(i));
    end

vout.fname = [img '_transformed.img'];
vout.descrip = '';
spm_write_vol(vout,outmap);

return