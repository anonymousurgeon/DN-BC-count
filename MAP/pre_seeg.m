clear;
clc;
spm_jobman('initcfg');
matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {'anat.nii,1'};
matlabbatch{1}.spm.spatial.coreg.estwrite.source = {'flair.nii,1'};
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
matlabbatch{2}.spm.spatial.coreg.estwrite.source = {'mra.nii,1'};
matlabbatch{2}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.interp = 1;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

matlabbatch{3}.spm.spatial.coreg.estwrite.ref = {'anat.nii,1'};
matlabbatch{3}.spm.spatial.coreg.estwrite.source = {'twist.nii,1'};
matlabbatch{3}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.interp = 1;
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

matlabbatch{4}.spm.spatial.preproc.data = {'anat.nii,1'};
matlabbatch{4}.spm.spatial.preproc.output.GM = [0 0 1];
matlabbatch{4}.spm.spatial.preproc.output.WM = [0 0 1];
matlabbatch{4}.spm.spatial.preproc.output.CSF = [0 0 1];
matlabbatch{4}.spm.spatial.preproc.output.biascor = 1;
matlabbatch{4}.spm.spatial.preproc.output.cleanup = 0;
matlabbatch{4}.spm.spatial.preproc.opts.tpm = {
                                               'C:\spm8\tpm\grey.nii'
                                               'C:\spm8\tpm\white.nii'
                                               'C:\spm8\tpm\csf.nii'
                                               };
matlabbatch{4}.spm.spatial.preproc.opts.ngaus = [2
                                                 2
                                                 2
                                                 4];
matlabbatch{4}.spm.spatial.preproc.opts.regtype = 'mni';
matlabbatch{4}.spm.spatial.preproc.opts.warpreg = 1;
matlabbatch{4}.spm.spatial.preproc.opts.warpco = 25;
matlabbatch{4}.spm.spatial.preproc.opts.biasreg = 0.0001;
matlabbatch{4}.spm.spatial.preproc.opts.biasfwhm = 60;
matlabbatch{4}.spm.spatial.preproc.opts.samp = 3;
matlabbatch{4}.spm.spatial.preproc.opts.msk = {''};

matlabbatch{5}.spm.util.imcalc.input = {
                                        'c1anat.nii,1'
                                        'c2anat.nii,1'
                                        'c3anat.nii,1'
                                        };
matlabbatch{5}.spm.util.imcalc.output = 'temp.nii';
matlabbatch{5}.spm.util.imcalc.outdir = {''};
matlabbatch{5}.spm.util.imcalc.expression = 'i1+i2+i3';
matlabbatch{5}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{5}.spm.util.imcalc.options.mask = 0;
matlabbatch{5}.spm.util.imcalc.options.interp = 1;
matlabbatch{5}.spm.util.imcalc.options.dtype = 4;

matlabbatch{6}.spm.util.imcalc.input = {'temp.nii,1'};
matlabbatch{6}.spm.util.imcalc.output = 'mask.nii';
matlabbatch{6}.spm.util.imcalc.outdir = {''};
matlabbatch{6}.spm.util.imcalc.expression = 'i1>0.6';
matlabbatch{6}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{6}.spm.util.imcalc.options.mask = 0;
matlabbatch{6}.spm.util.imcalc.options.interp = 1;
matlabbatch{6}.spm.util.imcalc.options.dtype = 4;


matlabbatch{7}.spm.util.imcalc.input = {
                                        'rflair.nii,1'
                                        'mask.nii,1'
                                        };
matlabbatch{7}.spm.util.imcalc.output = 'flair_skull_removed.nii';
matlabbatch{7}.spm.util.imcalc.outdir = {''};
matlabbatch{7}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{7}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{7}.spm.util.imcalc.options.mask = 0;
matlabbatch{7}.spm.util.imcalc.options.interp = 1;
matlabbatch{7}.spm.util.imcalc.options.dtype = 4;



matlabbatch{8}.spm.util.imcalc.input = {
                                        'rtwist.nii,1'
                                        'mask.nii,1'
                                        };
matlabbatch{8}.spm.util.imcalc.output = 'vessel.nii';
matlabbatch{8}.spm.util.imcalc.outdir = {''};
matlabbatch{8}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{8}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{8}.spm.util.imcalc.options.mask = 0;
matlabbatch{8}.spm.util.imcalc.options.interp = 1;
matlabbatch{8}.spm.util.imcalc.options.dtype = 4;


spm_jobman('run',matlabbatch);  
clear matlabbatch;


