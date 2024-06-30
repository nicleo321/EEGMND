

subjectdir = 'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\SecLevMat';
cd(subjectdir)
conditiondir = 'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\aefdfMspmeeg_subject1'
cd(conditiondir) 
spmdir = C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\SPM\SPM.mat
cd(spmdir)

matlabbatch{1}.spm.meeg.images.convert2images.D = {'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\SecLevMat\aefdfMspmeeg_subject1.mat'};
matlabbatch{1}.spm.meeg.images.convert2images.mode = 'scalp x time';
matlabbatch{1}.spm.meeg.images.convert2images.conditions = cell(1, 0);
matlabbatch{1}.spm.meeg.images.convert2images.channels{1}.type = 'EEG';
matlabbatch{1}.spm.meeg.images.convert2images.timewin = [-Inf Inf];
matlabbatch{1}.spm.meeg.images.convert2images.freqwin = [-Inf Inf];
matlabbatch{1}.spm.meeg.images.convert2images.prefix = '';
matlabbatch{2}.spm.stats.factorial_design.dir(1) = cfg_dep('Convert2Images: M/EEG images folder', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{2}.spm.stats.factorial_design.des.t2.scans1 = {'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\aefdfMspmeeg_subject1\condition_standard.nii,1'};
matlabbatch{2}.spm.stats.factorial_design.des.t2.scans2 = {'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\aefdfMspmeeg_subject1\condition_rare.nii,1'};
matlabbatch{2}.spm.stats.factorial_design.des.t2.dept = 0;
matlabbatch{2}.spm.stats.factorial_design.des.t2.variance = 1;
matlabbatch{2}.spm.stats.factorial_design.des.t2.gmsca = 0;
matlabbatch{2}.spm.stats.factorial_design.des.t2.ancova = 0;
matlabbatch{2}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{2}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{2}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{2}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{2}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{2}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{2}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{2}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{3}.spm.stats.fmri_est.spmmat = {'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\SPM\SPM.mat'};
matlabbatch{3}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{3}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{4}.spm.stats.con.spmmat = {'C:\Users\nicol\Desktop\Masters\Semester 2\NMDA\EEGAnalysis\SecondLevel\SPM\SPM.mat'};
matlabbatch{4}.spm.stats.con.consess{1}.fcon.name = 'RareversusStand';
matlabbatch{4}.spm.stats.con.consess{1}.fcon.weights = [1 -1];
matlabbatch{4}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
matlabbatch{4}.spm.stats.con.delete = 1;
