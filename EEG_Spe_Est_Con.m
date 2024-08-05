spm('Defaults', 'FMRI');        % Reset SPM defaults for fMRI (not sure necessary - safety catch?)
%global defaults;               % Reset Global defaults (not sure why needed?)
spm_jobman('initcfg')           %spm_jobman initialization

% Data Management
% -----------------------------------------------------------------------------------------------------------------------------------------------
spmdir = 'C:\Users\zebaq\Documents\MATLAB\spm12\spm12'; %SPM working directory:
addpath(spmdir)
datadir      = 'C:\Users\zebaq\Documents\MATLAB\EEG'        ; %Directory for data 
cd(datadir) 

condition_files = {strcat(datadir, '\eeg_img_powrmptf_aefdfMspmeeg_subject1\condition_rare.nii,1'), strcat(datadir, '\eeg_img_powrmptf_aefdfMspmeeg_subject1\condition_standard.nii,1')};

% Initialize SPM batch
job = {};

% Factorial design specification
job{1}.spm.stats.factorial_design.dir = {datadir}; %enter data directory
job{1}.spm.stats.factorial_design.des.anovaw.fsubject(1).scans = {condition_files}; % enter condition files
job{1}.spm.stats.factorial_design.des.anovaw.fsubject(1).conds = [1 2]; %Specify conditions
job{1}.spm.stats.factorial_design.des.anovaw.dept = 1;
job{1}.spm.stats.factorial_design.des.anovaw.variance = 1;
job{1}.spm.stats.factorial_design.des.anovaw.gmsca = 0;
job{1}.spm.stats.factorial_design.des.anovaw.ancova = 0;
job{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
job{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
job{1}.spm.stats.factorial_design.masking.im = 1;
job{1}.spm.stats.factorial_design.masking.em = {''};
job{1}.spm.stats.factorial_design.globalc.g_omit = 1;
job{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
job{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% Model estimation
job{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', ...
    substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
job{2}.spm.stats.fmri_est.write_residuals = 0;
job{2}.spm.stats.fmri_est.method.Classical = 1;

% Contrast manager
job{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', ...
    substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
job{3}.spm.stats.con.consess{1}.fcon.name = 'All Effects';
job{3}.spm.stats.con.consess{1}.fcon.weights = [1 0; 1 1];
job{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
job{3}.spm.stats.con.delete = 0;

% Run the job
spm_jobman('run', job);
