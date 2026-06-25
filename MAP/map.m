cd d:\matlab_data\map;
spm pet
spm_jobman('initcfg');
matlabbatch{1}.spm.spatial.normalise.estwrite.subj.source = {'anat.nii,1'};
matlabbatch{1}.spm.spatial.normalise.estwrite.subj.wtsrc = '';
matlabbatch{1}.spm.spatial.normalise.estwrite.subj.resample = {'anat.nii,1'};
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.template = {'C:\spm8\templates\T1.nii,1'};
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.smosrc = 8;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.smoref = 0;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.regtype = 'mni';
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.cutoff = 25;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.nits = 16;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.reg = 1;
matlabbatch{1}.spm.spatial.normalise.estwrite.roptions.preserve = 0;
matlabbatch{1}.spm.spatial.normalise.estwrite.roptions.bb = [-78 -112 -50
                                                             78 76 85];
matlabbatch{1}.spm.spatial.normalise.estwrite.roptions.vox = [1 1 1];
matlabbatch{1}.spm.spatial.normalise.estwrite.roptions.interp = 1;
matlabbatch{1}.spm.spatial.normalise.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.normalise.estwrite.roptions.prefix = 'w';
spm_jobman('run',matlabbatch);  
clear matlabbatch;

spm_segment('wanat.nii', 'c:\spm8\templates\T1.nii');

spm_smooth('c1wanat.nii','sc1wanat.nii',[5 5 5],0);

matlabbatch{1}.spm.tools.preproc8.channel.vols = {'wanat.nii,1'};
matlabbatch{1}.spm.tools.preproc8.channel.biasreg = 0.0001;
matlabbatch{1}.spm.tools.preproc8.channel.biasfwhm = 60;
matlabbatch{1}.spm.tools.preproc8.channel.write = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(1).tpm = {'C:\spm8\toolbox\Seg\TPM.nii,1'};
matlabbatch{1}.spm.tools.preproc8.tissue(1).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(1).native = [1 1];
matlabbatch{1}.spm.tools.preproc8.tissue(1).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(2).tpm = {'C:\spm8\toolbox\Seg\TPM.nii,2'};
matlabbatch{1}.spm.tools.preproc8.tissue(2).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(2).native = [1 1];
matlabbatch{1}.spm.tools.preproc8.tissue(2).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(3).tpm = {'C:\spm8\toolbox\Seg\TPM.nii,3'};
matlabbatch{1}.spm.tools.preproc8.tissue(3).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(3).native = [1 0];
matlabbatch{1}.spm.tools.preproc8.tissue(3).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(4).tpm = {'C:\spm8\toolbox\Seg\TPM.nii,4'};
matlabbatch{1}.spm.tools.preproc8.tissue(4).ngaus = 3;
matlabbatch{1}.spm.tools.preproc8.tissue(4).native = [1 0];
matlabbatch{1}.spm.tools.preproc8.tissue(4).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(5).tpm = {'C:\spm8\toolbox\Seg\TPM.nii,5'};
matlabbatch{1}.spm.tools.preproc8.tissue(5).ngaus = 4;
matlabbatch{1}.spm.tools.preproc8.tissue(5).native = [1 0];
matlabbatch{1}.spm.tools.preproc8.tissue(5).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(6).tpm = {'C:\spm8\toolbox\Seg\TPM.nii,6'};
matlabbatch{1}.spm.tools.preproc8.tissue(6).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(6).native = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(6).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.warp.mrf = 0;
matlabbatch{1}.spm.tools.preproc8.warp.reg = 4;
matlabbatch{1}.spm.tools.preproc8.warp.affreg = 'mni';
matlabbatch{1}.spm.tools.preproc8.warp.samp = 3;
matlabbatch{1}.spm.tools.preproc8.warp.write = [1 0];
matlabbatch{2}.spm.tools.vbct{1}.create.filenames = {'wanat.nii'};
matlabbatch{2}.spm.tools.vbct{1}.create.res = 1;
matlabbatch{2}.spm.tools.vbct{1}.create.display = 0;
matlabbatch{2}.spm.tools.vbct{1}.create.output.indir = 1;
matlabbatch{2}.spm.tools.vbct{1}.create.opts.csfsmoothness = [3 3 3];
matlabbatch{2}.spm.tools.vbct{1}.create.opts.csfthinness = 0.55;
matlabbatch{2}.spm.tools.vbct{1}.create.opts.csfdilations = 1;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

matlabbatch{1}.spm.util.imcalc.input = {
                                        'ct_wanat.nii,1'
                                        'C:\spm8\mask.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'thickness.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

                                                                          
matlabbatch{1}.spm.util.imcalc.input = {
                                        'binary.nii,1'
                                        'C:\spm8\mask.img,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'mbinary.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

spm_smooth('mbinary.nii','smbinary.nii',[5 5 5],0);


matlabbatch{1}.spm.util.imcalc.input = {
                                        'smbinary.nii,1'
                                        'C:\spm8\map_mean_std\mean.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'junction_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1-i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

matlabbatch{1}.spm.util.imcalc.input = {
                                        'junction_map.nii,1'
                                        'C:\spm8\map_mean_std\std.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'junction_z_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1./i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

matlabbatch{1}.spm.util.imcalc.input = {
                                        'sc1wanat.nii,1'
                                        'C:\spm8\map_mean_std\mean_gm.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'extension_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1-i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

matlabbatch{1}.spm.util.imcalc.input = {
                                        'extension_map.nii,1'
                                        'C:\spm8\map_mean_std\std_gm.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'extension_z_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1./i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

matlabbatch{1}.spm.util.imcalc.input = {
                                        'thickness.nii,1'
                                        'C:\spm8\map_mean_std\mean_thickness.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'thickness_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1-i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;


matlabbatch{1}.spm.util.imcalc.input = {
                                        'thickness_map.nii,1'
                                        'C:\spm8\map_mean_std\std_thickness.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'thickness_z_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1./i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

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
spm_jobman('run',matlabbatch);  
clear matlabbatch;


clear;
clc;
spm_jobman('initcfg');
matlabbatch{1}.spm.spatial.preproc.data = {'rflair.nii,1'};
matlabbatch{1}.spm.spatial.preproc.output.GM = [0 0 0];
matlabbatch{1}.spm.spatial.preproc.output.WM = [0 0 0];
matlabbatch{1}.spm.spatial.preproc.output.CSF = [0 0 0];
matlabbatch{1}.spm.spatial.preproc.output.biascor = 1;
matlabbatch{1}.spm.spatial.preproc.output.cleanup = 0;
matlabbatch{1}.spm.spatial.preproc.opts.tpm = {
                                               'C:\spm8\tpm\grey.nii'
                                               'C:\spm8\tpm\white.nii'
                                               'C:\spm8\tpm\csf.nii'
                                               };
matlabbatch{1}.spm.spatial.preproc.opts.ngaus = [2
                                                 2
                                                 2
                                                 4];
matlabbatch{1}.spm.spatial.preproc.opts.regtype = 'mni';
matlabbatch{1}.spm.spatial.preproc.opts.warpreg = 1;
matlabbatch{1}.spm.spatial.preproc.opts.warpco = 25;
matlabbatch{1}.spm.spatial.preproc.opts.biasreg = 0.0001;
matlabbatch{1}.spm.spatial.preproc.opts.biasfwhm = 60;
matlabbatch{1}.spm.spatial.preproc.opts.samp = 3;
matlabbatch{1}.spm.spatial.preproc.opts.msk = {''};

matlabbatch{2}.spm.spatial.normalise.estwrite.subj.source = {'mrflair.nii,1'};
matlabbatch{2}.spm.spatial.normalise.estwrite.subj.wtsrc = '';
matlabbatch{2}.spm.spatial.normalise.estwrite.subj.resample = {'mrflair.nii,1'};
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.template = {'C:\spm8\templates\T1.nii,1'};
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.weight = '';
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.smosrc = 8;
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.smoref = 0;
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.regtype = 'mni';
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.cutoff = 25;
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.nits = 16;
matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.reg = 1;
matlabbatch{2}.spm.spatial.normalise.estwrite.roptions.preserve = 0;
matlabbatch{2}.spm.spatial.normalise.estwrite.roptions.bb = [-78 -112 -50
                                                             78 76 85];
matlabbatch{2}.spm.spatial.normalise.estwrite.roptions.vox = [1 1 1];
matlabbatch{2}.spm.spatial.normalise.estwrite.roptions.interp = 1;
matlabbatch{2}.spm.spatial.normalise.estwrite.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.normalise.estwrite.roptions.prefix = 'w';

matlabbatch{3}.spm.util.imcalc.input = {
                                        'wmrflair.nii,1'
                                        'C:\spm8\templates\brain_mask.nii,1'
                                        };
matlabbatch{3}.spm.util.imcalc.output = 'brain_flair.nii';
matlabbatch{3}.spm.util.imcalc.outdir = {''};
matlabbatch{3}.spm.util.imcalc.expression = 'i1.*i2';
matlabbatch{3}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{3}.spm.util.imcalc.options.mask = 0;
matlabbatch{3}.spm.util.imcalc.options.interp = 1;
matlabbatch{3}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

clear;
clc;
V=spm_vol('brain_flair.nii');
X = spm_read_vols(V);
V=spm_vol('C:\spm8\templates\brain_mask.nii');
Y = spm_read_vols(V);
mean = sum(X(:))/sum(Y(:));
express=['i1/',num2str(mean)];

matlabbatch{1}.spm.util.imcalc.input = {'wmrflair.nii'};
matlabbatch{1}.spm.util.imcalc.output = 'flair_norm.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = express;
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;

matlabbatch{1}.spm.util.imcalc.input = {
                                        'flair_norm.nii,1'
                                        'C:\spm8\map_mean_std\mean_flair.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'flair_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1-i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;


matlabbatch{1}.spm.util.imcalc.input = {
                                        'flair_map.nii,1'
                                        'C:\spm8\map_mean_std\std_flair.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'flair_z_map.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {''};
matlabbatch{1}.spm.util.imcalc.expression = 'i1./i2';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
spm_jobman('run',matlabbatch);  
clear matlabbatch;


matlabbatch{1}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.matname = {'anat_sn.mat'};
matlabbatch{1}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.vox = [NaN NaN NaN];
matlabbatch{1}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.bb = [NaN NaN NaN
                                                              NaN NaN NaN];
matlabbatch{1}.spm.util.defs.comp{1}.inv.space = {'anat.nii,1'};
matlabbatch{1}.spm.util.defs.ofname = '';
matlabbatch{1}.spm.util.defs.fnames = {'junction_z_map.nii,1'};
matlabbatch{1}.spm.util.defs.savedir.savepwd = 1;
matlabbatch{1}.spm.util.defs.interp = 1;

matlabbatch{2}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.matname = {'anat_sn.mat'};
matlabbatch{2}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.vox = [NaN NaN NaN];
matlabbatch{2}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.bb = [NaN NaN NaN
                                                              NaN NaN NaN];
matlabbatch{2}.spm.util.defs.comp{1}.inv.space = {'anat.nii,1'};
matlabbatch{2}.spm.util.defs.ofname = '';
matlabbatch{2}.spm.util.defs.fnames = {'extension_z_map.nii,1'};
matlabbatch{2}.spm.util.defs.savedir.savepwd = 1;
matlabbatch{2}.spm.util.defs.interp = 1;

matlabbatch{3}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.matname = {'anat_sn.mat'};
matlabbatch{3}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.vox = [NaN NaN NaN];
matlabbatch{3}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.bb = [NaN NaN NaN
                                                              NaN NaN NaN];
matlabbatch{3}.spm.util.defs.comp{1}.inv.space = {'anat.nii,1'};
matlabbatch{3}.spm.util.defs.ofname = '';
matlabbatch{3}.spm.util.defs.fnames = {'thickness_z_map.nii,1'};
matlabbatch{3}.spm.util.defs.savedir.savepwd = 1;
matlabbatch{3}.spm.util.defs.interp = 1;
 
matlabbatch{4}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.matname = {'mrflair_sn.mat'};
matlabbatch{4}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.vox = [NaN NaN NaN];
matlabbatch{4}.spm.util.defs.comp{1}.inv.comp{1}.sn2def.bb = [NaN NaN NaN
                                                              NaN NaN NaN];
matlabbatch{4}.spm.util.defs.comp{1}.inv.space = {'mrflair.nii,1'};
matlabbatch{4}.spm.util.defs.ofname = '';
matlabbatch{4}.spm.util.defs.fnames = {'flair_z_map.nii,1'};
matlabbatch{4}.spm.util.defs.savedir.savepwd = 1;
matlabbatch{4}.spm.util.defs.interp = 1;
spm_jobman('run',matlabbatch); 
clear matlabbatch;

delete('flair_map.nii','flair_norm.nii','flair_z_map.nii','b*.nii','c*.nii','e*.nii','g*.nii','i*.nii','j*.nii','m*.nii','r*.nii','s*.nii','t*.nii','wanat.nii','watlas71_lr.hdr','watlas71_lr.img','wmrflair.nii','*.mat','*.ps');
movefile('wjunction_z_map.nii', 'junction.nii');
movefile('wextension_z_map.nii', 'extension.nii');
movefile('wthickness_z_map.nii', 'thickness.nii');
movefile('wflair_z_map.nii', 'nFSI.nii');


