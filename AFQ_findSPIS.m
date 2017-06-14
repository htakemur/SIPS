function AFQ_findSPIS(fgFile, tractname, roiDir, targetROI1, targetROI2, thresholdroi, thresholdlength, rmOutlier, maxDist, maxLenStd)
% Script for segmenting "Stratum Proprium of Interparietal Sulcus" by Sachs
% (1892). 

% INPUT: 
% fgFile: A full path to the file including whole-brain streamlines (.mat, .pdb or .tck format).
% tractname: Tract name to save (e.g. 'LH_SPIS.pdb'; .pdb or .mat format) 
% roiDir: A full path to folder including ROI file 
% targetROI1: Name of targer ROI1 (nifti format; e.g. "lh_precuneus_spl")
% targetROI2: Name of target ROI2 (nifti format; e.g. "1031_ctx-lh-supramarginal");;
% thresholdroi: Distance threshold between ROI and SPIS streamline endpoints (Default: 3 mm)
% thresholdlength: Length threshold for discarding extremely short streamlines (Default: 15 mm) 
% rmOutlier: If this variable is "true", remove outliner streamlines using MBA code
% maxDist  = the maximum gaussian distance a streamline can be from the core of
%            the tract and be retained in the streamline group
% maxLenStd   = The maximum length of a streamline (in stadard deviations from the
%            mean length)
%
% Documentation: https://github.com/vistalab/vistasoft/wiki/Identify-human-Stratum-Proprium-of-Interparietal-Sulcus
%
% Notes:
% For performing tractography, we recommend to use Anatomically-Constrained Tractography (ACT; Smith et al.) implemented in MrTrix because it has a better sensitivity to tract like SPIS. 
%
% Dependency:
% vistasoft: https://github.com/vistalab/vistasoft
% mba: https://github.com/francopestilli/mba
%
% If you use this code for your own study, please cite following article as a reference:
% Uesaki, M., Takemura, H. & Ashida, H. (2017) Computational neuroanatomy of human stratum proprium of interparietal sulcus. bioRxiv. 
% 
% Hiromasa Takemura (C) CiNet, 2017
%

% Distance threshold between streamline endpoint and ROIs
if notDefined('thresholdroi')
thresholdroi = 3;
end

% Length threshold: clipping fascicle shorter than this (in mm)
if notDefined('thresholdlength')
thresholdlength = 15;
end

% Optional variable to exclude outliners
if notDefined('rmOutlier')
rmOutlier = 1;
end

% Other parameters in excluding criteria 
if notDefined('maxDist')
maxDist = 3;
end
if notDefined('maxLenStd')
maxLenStd = 3;
end

% Set targetROIfile
targetROIfile{1} = [roiDir, targetROI1, '.nii.gz'];
targetROIfile{2} = [roiDir, targetROI2, '.nii.gz'];

%% (1) Load streamlines

fprintf('Loading streamlines ...\n')
fg = fgRead(fgFile);

%% (2) Segmenting streamlines terminating Precuneus/SPL and SMG
fprintf('Segmenting streamlines based on ROI termination ...\n')
[fgsegment keepFascicles] = dtiSegmentFiberWithNiftiRoi(fg, targetROIfile{1}, targetROIfile{2}, thresholdroi);

%% (3) Excluding extremely short streamlines
fprintf('Excluding extremely short streamlines ...\n')
[Lnorm, Lmm] = mbaComputeFiberLengthDistribution(fgsegment);
keepFasciclesmm = zeros(length(Lmm),1);
keepFasciclesmm(Lmm>thresholdlength) = 1;
fgsegmentmm = fgExtract(fgsegment, logical(keepFasciclesmm), 'keep');

%% (4) Excluding topological outlier
fprintf('Excluding topological outlier ...\n')
if rmOutlier == 1,
[fgsegment2 keepFascicles2] = mbaComputeFibersOutliers(fgsegmentmm, maxDist, maxLenStd, 30);
else 
end
 
%% (5) Save tract
fgWrite(fgsegment2, tractname);

