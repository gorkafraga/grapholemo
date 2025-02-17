%% COUNT FILES MAKE SUMMARY TABLE
%-----------------------------------
clear all
close all
%%inputs 
dirinput= 'O:\studies\grapholemo\raw';
diroutput= 'O:\studies\grapholemo\raw';
masterfile      = 'O:\studies\grapholemo\LEMO_Master.xlsx';

folderNames = {'mri\anat','mri\func\FBL_partA','mri\func\FBL_partB','mri\func\symcontrol'};
subfolderNames = {'parrec','nifti','realign_check','logs'};
%% find subjects
subjectFiles = dir([dirinput,'\gpl*']);
files = subjectFiles(find(cellfun(@length, {subjectFiles.name})==6));%take only file names with characters
sIDs = {files.name};
 
%%
cd (dirinput)
sTable=[];
for i=1:length(sIDs) 
    counter = 1;
    for j = 1:length(folderNames)
        for k=1:length(subfolderNames)
           folderContent = dir([sIDs{i},'\',folderNames{j},'\',subfolderNames{k}]);
           folderContent = folderContent(~contains({folderContent.name},'Thumbs.db'));
           fileCount =  length(folderContent(cell2mat({folderContent.isdir})==0));
            sTable(i,counter)= fileCount;
            counter = counter + 1;
         end
    end
end
%%
header ={};
c= 1;
for j = 1:length(folderNames)
        for k=1:length(subfolderNames)
         header{c} =  [folderNames{j},'\',subfolderNames{k}];
         c=c+1;
        end
end
header = ['Subj_ID',header];
%% Gather and save
summaryTable = cell2table([sIDs',num2cell(sTable)]);
summaryTable.Properties.VariableNames = header;
summaryTable.Subj_ID = upper(summaryTable.Subj_ID)
 %% Merge with subjects in master file 
  T = readtable(masterfile,'sheet','Demographics','Range','A1:GD45');
  T = T(find(contains(T.Subj_ID,'GPL')),:); %trim table to take only files with valid subjID and skip remaining rows NAs 
  T.Properties.RowNames= T.Subj_ID;
  T = T(:,1);
  
 summaryTableMerged = outerjoin(T,summaryTable);
 summaryTableMerged.Properties.VariableNames{1} = 'Subj_ID';
  
%% save
cd(diroutput);
outputfilename = 'tmp_summary_MR_files.xls';
if exist(outputfilename,'file') == 0
   writetable(summaryTableMerged,outputfilename,'sheet','ALL','WriteVariableNames',true);
    
else
    disp('CANNOT SAVE FILE, IT ALREADY EXISTS!!');
end 