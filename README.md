<<<<<<< HEAD
#SIPS manual#
This code is aims to identify the human stratum proprium of interparietal sulcus (SIPS, Sachs 1892) based on diffusion MRI dataset. 
The original work is described in:

>Uesaki, M., Takemura, H. & Ashida, H. Computational Neuroanatomy of human stratum proprium of interparietal sulcus. Brain Structure and Function, in press.

For more information please contact

> Hiromasa Takemura, Center for Information and Neural Networks (CiNet), NICT, Osaka Japan
http://researchmap.jp/hiromasatakemura/


##Contents in repository##
- AFQ_findSIPS.m: code for identiyfing SIPS from whole-brain streamlines
- SIPS_convertROI.m: code to generate ROIs to identify SIPS based on Freesurfer parcellations
- ProbAtlas/SIPS_MNI152_probabilistic.nii.gz: Probabilistic atlas of human SIPS in MNI152 coordinates (based on 100 subject's SIPS identification)
- ProbAtlas/icbm_avg_152_t1_tal_lin.nii: Template T1-weighted image in MNI152 space. 

##Online instructuion and tutorial##
 https://github.com/vistalab/vistasoft/wiki/Identify-human-Stratum-Proprium-of-Interparietal-Sulcus


=======
# SIPS
This directory hosts functions and scripts to identify human Stratum proprium of interparietal sulcus.
The repository will be finally merged into AFQ repository. 

Functions:
AFQ_findSIPS: Code to identify human stratum proprium interparietal sulcus (SIPS).
SIPS_convertROI: Code to prepare ROI files for SIPS identification

Atlas:
ProbAtlas: Probabilistic atlas of human SIPS from 100 subjects in MNI152 space

Documentation: https://github.com/vistalab/vistasoft/wiki/Identify-human-Stratum-Proprium-of-Interparietal-Sulcus

Dependency:
vistasoft: https://github.com/vistalab/vistasoft

mba: https://github.com/francopestilli/mba

If you use this code for your own study, please cite following article as a reference:

Uesaki, M., Takemura, H. & Ashida, H. (2017) Computational neuroanatomy of human stratum proprium of interparietal sulcus. Brain Structure and Function. 
>>>>>>> a0893ecb807c6f4e0537dd956f0abd6801d7abc0
