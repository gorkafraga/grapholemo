%script for analyzing tasks on first level
%Iliana Karipidis, August 2014
%David Willinger, November 2017
%Patrick Haller, May 2018
%--------------------------------------
% Output are files containing the contrasts: 'SPM.m' and e.g., 'spmT_0002.nii' (2 indicates contrast 2)
function matlabbatch = create_GLM5a(paths, task, subject,scans,rp,bad_scans)

logfile = ls([paths.study, paths.logs, task '\' subject, '\*final_parameters.csv']);

onsets = {};
parameters = {};

try
    % get stimulus onsets for each block
    [onsets,parameters] = get_fbl_onsets_model( fullfile(paths.study,paths.logs,task,subject,logfile) );
catch MExc
    fprintf(['ERROR: Logfile processing failed with error: ' MExc.message '\n']);
    matlabbatch = [];
    return ;
end

pathSubject = fullfile(paths.study,paths.analysis,task,'1stlev_GLM5a',subject);

if ~isdir(pathSubject)
    mkdir(pathSubject);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% SPECIFY 1ST LEVEL %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathSubject = fullfile(paths.study,paths.analysis,task,'1stlev_GLM5a',subject);
% define subject path
matlabbatch{1}.spm.stats.fmri_spec.dir = cellstr(pathSubject);
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 1;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 32;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 16;

% loop through sessions (= blocks)
for s=1:3
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).scans = cellstr(scans{s});
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).name = 'stimulus_onset';
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).onset = cell2mat(onsets(1,s));
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).pmod.name = 'AS_choice';
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).pmod.param = cell2mat(parameters(3,s));
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).pmod.poly = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(1).orth = 0;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).name = 'feedback_onset';
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).onset = cell2mat(onsets(2,s));
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).pmod.name = 'PE_neg';
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).pmod.param = cell2mat(parameters(6,s));
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).pmod.poly = 1; 
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).cond(2).orth = 0;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).multi = {''};
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(s).multi_reg = cellstr(char(rp{s},bad_scans{s}));
end

matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%%
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% ESTIMATE %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% CONTRASTS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));


matlabbatch{3}.spm.stats.con.consess{1}.fcon.name = 'Effects of interest';
matlabbatch{3}.spm.stats.con.consess{1}.fcon.weights = eye(4);
matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'repl';

matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Main effect of stimulus onset';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';

matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'Parametric modulation of stimulus onset by AS of chosen pair';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 1];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';

matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'Main effect of feedback onset';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0 1];
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';

matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'Parametric modulation of feedback onset by negative PE';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';

end

