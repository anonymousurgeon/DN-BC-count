clear;
clc;
spm_jobman('initcfg');
cd d:\matlab_data\siscom\;
matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'anat.nii,1'};
matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'interictal.nii,1'};
matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 1;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
matlabbatch{2}.spm.spatial.coreg.estwrite.ref = {'anat.nii,1'};
matlabbatch{2}.spm.spatial.coreg.estwrite.source = {'ictal.nii,1'};
matlabbatch{2}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.interp = 1;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

matlabbatch{3}.spm.spatial.preproc.data = {'anat.nii,1'};
matlabbatch{3}.spm.spatial.preproc.output.GM = [0 0 1];
matlabbatch{3}.spm.spatial.preproc.output.WM = [0 0 1];
matlabbatch{3}.spm.spatial.preproc.output.CSF = [0 0 0];
matlabbatch{3}.spm.spatial.preproc.output.biascor = 1;
matlabbatch{3}.spm.spatial.preproc.output.cleanup = 0;
matlabbatch{3}.spm.spatial.preproc.opts.tpm = {
                                               'C:\spm8\tpm\grey.nii'
                                               'C:\spm8\tpm\white.nii'
                                               'C:\spm8\tpm\csf.nii'
                                               };
matlabbatch{3}.spm.spatial.preproc.opts.ngaus = [2
                                                 2
                                                 2
                                                 4];
matlabbatch{3}.spm.spatial.preproc.opts.regtype = 'mni';
matlabbatch{3}.spm.spatial.preproc.opts.warpreg = 1;
matlabbatch{3}.spm.spatial.preproc.opts.warpco = 25;
matlabbatch{3}.spm.spatial.preproc.opts.biasreg = 0.0001;
matlabbatch{3}.spm.spatial.preproc.opts.biasfwhm = 60;
matlabbatch{3}.spm.spatial.preproc.opts.samp = 3;
matlabbatch{3}.spm.spatial.preproc.opts.msk = {''};

matlabbatch{4}.spm.util.imcalc.input = {
                                        'c1anat.nii,1'
                                        'c2anat.nii,1'
                                        };
matlabbatch{4}.spm.util.imcalc.output = 'mask_temp.nii';
matlabbatch{4}.spm.util.imcalc.outdir = {''};
matlabbatch{4}.spm.util.imcalc.expression = 'i1+i2';
matlabbatch{4}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{4}.spm.util.imcalc.options.mask = 0;
matlabbatch{4}.spm.util.imcalc.options.interp = 1;
matlabbatch{4}.spm.util.imcalc.options.dtype = 4;

matlabbatch{5}.spm.util.imcalc.input = {'mask_temp.nii,1'};
matlabbatch{5}.spm.util.imcalc.output = 'mask.nii';
matlabbatch{5}.spm.util.imcalc.outdir = {''};
matlabbatch{5}.spm.util.imcalc.expression = 'i1>0.8';
matlabbatch{5}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{5}.spm.util.imcalc.options.mask = 0;
matlabbatch{5}.spm.util.imcalc.options.interp = 1;
matlabbatch{5}.spm.util.imcalc.options.dtype = 4;

matlabbatch{6}.spm.util.imcalc.input = {
                                        'rinterictal.nii,1'
                                        'mask.nii,1'
                                        };
matlabbatch{6}.spm.util.imcalc.output = 'interictal_skull_removed.nii';
matlabbatch{6}.spm.util.imcalc.outdir = {''};
matlabbatch{6}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{6}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{6}.spm.util.imcalc.options.mask = 0;
matlabbatch{6}.spm.util.imcalc.options.interp = 1;
matlabbatch{6}.spm.util.imcalc.options.dtype = 4;

matlabbatch{7}.spm.util.imcalc.input = {
                                        'rictal.nii,1'
                                        'mask.nii,1'
                                        };
matlabbatch{7}.spm.util.imcalc.output = 'ictal_skull_removed.nii';
matlabbatch{7}.spm.util.imcalc.outdir = {''};
matlabbatch{7}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{7}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{7}.spm.util.imcalc.options.mask = 0;
matlabbatch{7}.spm.util.imcalc.options.interp = 1;
matlabbatch{7}.spm.util.imcalc.options.dtype = 4;

spm_jobman('run',matlabbatch);  
clear matlabbatch;

clear;
clc;

V=spm_vol('mask.nii');
X = spm_read_vols(V);
V=spm_vol('interictal_skull_removed.nii');
r1 = spm_read_vols(V);
V=spm_vol('ictal_skull_removed.nii');
r2 = spm_read_vols(V);

mean1 = sum(r1(:))/sum(X(:));
mean2 = sum(r2(:))/sum(X(:));
express1=['i1/',num2str(mean1)];
express2=['i1/',num2str(mean2)];

matlabbatch{1}.spm.util.imcalc.input = {'interictal_skull_removed.nii,1'};
matlabbatch{1}.spm.util.imcalc.output = 'interictal_stand.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = express1;
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
matlabbatch{2}.spm.util.imcalc.input = {'ictal_skull_removed.nii,1'};
matlabbatch{2}.spm.util.imcalc.output = 'ictal_stand.nii';
matlabbatch{2}.spm.util.imcalc.outdir = {''};
matlabbatch{2}.spm.util.imcalc.expression = express2;
matlabbatch{2}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{2}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{2}.spm.util.imcalc.options.mask = 0;
matlabbatch{2}.spm.util.imcalc.options.interp = 1;
matlabbatch{2}.spm.util.imcalc.options.dtype = 4;
matlabbatch{3}.spm.util.imcalc.input = {
                                        'interictal_stand.nii,1'
                                        'ictal_stand.nii,1'
                                        };
matlabbatch{3}.spm.util.imcalc.output = 'siscom.nii';
matlabbatch{3}.spm.util.imcalc.outdir = {''};
matlabbatch{3}.spm.util.imcalc.expression = '((i2-i1)./i1)*100';
matlabbatch{3}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{3}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{3}.spm.util.imcalc.options.mask = 0;
matlabbatch{3}.spm.util.imcalc.options.interp = 1;
matlabbatch{3}.spm.util.imcalc.options.dtype = 4;

spm_jobman('run',matlabbatch);  
clear matlabbatch;
