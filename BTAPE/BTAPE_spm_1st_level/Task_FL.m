% Initialize SPM
spmdir = 'C:\Users\zebaq\Documents\MATLAB\spm12\spm12'; %SPM working directory:
addpath(spmdir)
spm('defaults', 'FMRI');
spm_jobman('initcfg');

specdir = 'C:\Users\zebaq\Documents\MATLAB\fMRI\BTAPE\BTAPE_jobs';
cd(specdir)
% Define the base directory where the subfolders are located
base_dir = 'C:\Users\zebaq\Documents\MATLAB\fMRI\BTAPE\BIDS\sub-01\func';
cd(base_dir)

% Specify the subfolder names where .nii files are located
subfolders = {'sub-01_task-BTP_run-5_bold', 'sub-01_task-BTP_run-8_bold', ...
              'sub-01_task-BTP_run-11_bold', 'sub-01_task-BTP_run-14_bold', ...
              'sub-01_task-BTP_run-17_bold', 'sub-01_task-BTP_run-19_bold'};

func_files = {'swrMFBTAPE-0005-%05d-%06d.nii,1', 'swrMFBTAPE-0008-%05d-%06d.nii,1', ...
              'swrMFBTAPE-0011-%05d-%06d.nii,1', 'swrMFBTAPE-0014-%05d-%06d.nii,1', ...
              'swrMFBTAPE-0017-%05d-%06d.nii,1', 'swrMFBTAPE-0019-%05d-%06d.nii,1'};

mot_reg = {'rp_MFBTAPE-0005-00001-000001.txt', 'rp_MFBTAPE-0008-00001-000001.txt', ...
           'rp_MFBTAPE-0011-00001-000001.txt', 'rp_MFBTAPE-0014-00001-000001.txt', ...
            'rp_MFBTAPE-0017-00001-000001.txt', 'rp_MFBTAPE-0019-00001-000001.txt'};

% Initialize job structure
job = [];
job{1}.spm.stats.fmri_spec.dir = {base_dir};
job{1}.spm.stats.fmri_spec.timing.units = 'secs';
job{1}.spm.stats.fmri_spec.timing.RT = 1;
job{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
job{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
% Loop over each subfolder
for j = 1:numel(subfolders)
    % Construct full path to the current subfolder
    current_subfolder = fullfile(base_dir, subfolders{j});

    % Generate file paths for Runs
    scans_run = arrayfun(@(i) fullfile(current_subfolder, sprintf(func_files{j}, i, i)), 1:360, 'UniformOutput', false);
    
   
    %%
    job{j}.spm.stats.fmri_spec.sess(1).scans = scans_run';
    job{j}.spm.stats.fmri_spec.sess(1).cond(1).name = 'Condition 1';
    job{j}.spm.stats.fmri_spec.sess(1).cond(1).onset = [4 
                                                                40
                                                                112
                                                                184
                                                                256];
    job{j}.spm.stats.fmri_spec.sess(1).cond(1).duration = 24;
    job{j}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
    job{j}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
    job{j}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;
    job{j}.spm.stats.fmri_spec.sess(1).cond(2).name = 'Condition 2';
    job{j}.spm.stats.fmri_spec.sess(1).cond(2).onset = [76
                                                                148
                                                                220
                                                                292
                                                                328];
    job{j}.spm.stats.fmri_spec.sess(1).cond(2).duration = 24;
    job{j}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
    job{j}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
    job{j}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;
    job{j}.spm.stats.fmri_spec.sess(1).multi = {''};
    job{j}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
    job{j}.spm.stats.fmri_spec.sess(1).multi_reg = {fullfile(current_subfolder,mot_reg{j})};
    job{j}.spm.stats.fmri_spec.sess(1).hpf = 128;
end
job{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
job{1}.spm.stats.fmri_spec.bases.hrf.derivs = [1 0]; %time derivative
job{1}.spm.stats.fmri_spec.volt = 1;
job{1}.spm.stats.fmri_spec.global = 'None';
job{1}.spm.stats.fmri_spec.mthresh = 0.8;
job{1}.spm.stats.fmri_spec.mask = {''};
job{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
%% %Estimation
   
job{2}.spm.stats.fmri_est.spmmat = {strcat(base_dir,'\SPM.mat')};
job{2}.spm.stats.fmri_est.write_residuals = 0;
job{2}.spm.stats.fmri_est.method.Classical = 1;
 spm_jobman('run',job)
