% Simple start up script to add necessary directories to MATLAB's path

rootDir = fileparts(which(mfilename));
subDirs = genpath(rootDir);

splitDirs = regexp(subDirs, pathsep, 'split');
cleanDirs = splitDirs(cellfun(@isempty, regexp(splitDirs, '\.git')));

workingDirs = strjoin(cleanDirs, pathsep);
addpath(workingDirs);

clear; clc;
