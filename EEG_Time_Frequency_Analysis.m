%-----------------------------------------------------------------------
% performing a time-frequency analysis before averaging over trials using Morlet wavelets
%to decompose each trial into power and phase across peristimulus time and frequency
% spm SPM - SPM12 (7771)
%-----------------------------------------------------------------------
spmdir = 'C:\Users\zebaq\Documents\MATLAB\spm12\spm12'; % SPM present working directory
addpath(spmdir)
spm_jobman('initcfg') %intializing spm_jobman function
%-----------------------------------------------------------------------
%Wavelet estimation
job = []; % job structure initialization
job{1}.spm.meeg.tf.tf.D = {'C:\Users\zebaq\Documents\MATLAB\EEG\aefdfMspmeeg_subject1.mat'};
job{1}.spm.meeg.tf.tf.channels{1}.all = 'all';
job{1}.spm.meeg.tf.tf.frequencies = [6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40];
job{1}.spm.meeg.tf.tf.timewin = [-Inf Inf];
job{1}.spm.meeg.tf.tf.method.morlet.ncycles = 5;
job{1}.spm.meeg.tf.tf.method.morlet.timeres = 0;
job{1}.spm.meeg.tf.tf.method.morlet.subsample = 5;
job{1}.spm.meeg.tf.tf.phase = 1;
job{1}.spm.meeg.tf.tf.prefix = '';
spm_jobman('run', job);
%------------------------------------------------------------------------
%Crop
job = [];
job{2}.spm.meeg.preproc.crop.D(1) = cfg_dep('Time-frequency analysis: M/EEG time-frequency power dataset', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dtfname'));
job{2}.spm.meeg.preproc.crop.timewin = [-100 400]; %add appropriate time window
job{2}.spm.meeg.preproc.crop.freqwin = [-Inf Inf];
job{2}.spm.meeg.preproc.crop.channels{1}.all = 'all';
job{2}.spm.meeg.preproc.crop.prefix = 'p';
job{3}.spm.meeg.preproc.crop.D(1) = cfg_dep('Time-frequency analysis: M/EEG time-frequency phase dataset', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dtphname'));
job{3}.spm.meeg.preproc.crop.timewin = [-100 400]; %add appropriate time window
job{3}.spm.meeg.preproc.crop.freqwin = [-Inf Inf];
job{3}.spm.meeg.preproc.crop.channels{1}.all = 'all';
job{3}.spm.meeg.preproc.crop.prefix = 'p';
spm_jobman('run', job);
%----------------------------------------------------------------------
%Average
job = [];
job{4}.spm.meeg.averaging.average.D(1) = cfg_dep('Crop: Cropped M/EEG datafile', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
job{4}.spm.meeg.averaging.average.userobust.standard = false;
job{4}.spm.meeg.averaging.average.plv = false;
job{4}.spm.meeg.averaging.average.prefix = 'm';
job{5}.spm.meeg.averaging.average.D(1) = cfg_dep('Crop: Cropped M/EEG datafile', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
job{5}.spm.meeg.averaging.average.userobust.standard = false;
job{5}.spm.meeg.averaging.average.plv = true;
job{5}.spm.meeg.averaging.average.prefix = 'm';
spm_jobman('run', job);
%----------------------------------------------------------------------
% Baseline rescaling
job = [];
job{6}.spm.meeg.tf.rescale.D(1) = cfg_dep('Averaging: Averaged Datafile', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
job{6}.spm.meeg.tf.rescale.method.LogR.baseline.timewin = [-100 0];
job{6}.spm.meeg.tf.rescale.method.LogR.baseline.pooledbaseline = 0;
job{6}.spm.meeg.tf.rescale.method.LogR.baseline.Db = [];
job{6}.spm.meeg.tf.rescale.prefix = 'r';
spm_jobman('run', job);
%----------------------------------------------------------------------
%Contrasting conditions
job = [];
job{7}.spm.meeg.averaging.contrast.D(1) = cfg_dep('Averaging: Averaged Datafile', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
job{7}.spm.meeg.averaging.contrast.contrast(1).c = [1 -1];%add desired contrasts
job{7}.spm.meeg.averaging.contrast.contrast(1).label = 'standard'; %label contrasts
job{7}.spm.meeg.averaging.contrast.contrast(2).c = [-1 1];%add desired contrasts
job{7}.spm.meeg.averaging.contrast.contrast(2).label = 'rare';%label contrasts
job{7}.spm.meeg.averaging.contrast.weighted = 1;
job{7}.spm.meeg.averaging.contrast.prefix = 'w';
job{8}.spm.meeg.averaging.contrast.D(1) = cfg_dep('Averaging: Averaged Datafile', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
job{8}.spm.meeg.averaging.contrast.contrast(1).c = [1 -1]; %add desired contrasts
job{8}.spm.meeg.averaging.contrast.contrast(1).label = 'standard';%label contrasts
job{8}.spm.meeg.averaging.contrast.contrast(2).c = [-1 1];%add desired contrasts
job{8}.spm.meeg.averaging.contrast.contrast(2).label = 'rare';%label contrasts
job{8}.spm.meeg.averaging.contrast.weighted = 1;
job{8}.spm.meeg.averaging.contrast.prefix = 'w';
spm_jobman('run', job);
%----------------------------------------------------------------------
%Creating 2D time-frequency images
job = [];
job{9}.spm.meeg.images.convert2images.D(1) = cfg_dep('Time-frequency rescale: Rescaled TF Datafile', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
job{9}.spm.meeg.images.convert2images.mode = 'time x frequency';
job{9}.spm.meeg.images.convert2images.conditions = cell(1, 0);
job{9}.spm.meeg.images.convert2images.channels{1}.type = 'EEG';
job{9}.spm.meeg.images.convert2images.timewin = [-Inf Inf];
job{9}.spm.meeg.images.convert2images.freqwin = [-Inf Inf];
job{9}.spm.meeg.images.convert2images.prefix = 'eeg_img_pow';
spm_jobman('run', job);
%----------------------------------------------------------------------
