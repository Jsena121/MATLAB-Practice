clear
load examgrades.mat
%a=random('Stable',2,0,30,70,size(grades));
%a=100*rand(120,5);
a=50*rand(120,5)+50;
[gradesTable,gradesCell]=GradesConv(a);
% grades(:,6)=min(grades(:,1:5),[],2);
% grades(:,7)=max(grades(:,1:5),[],2);
% grades(:,8)=mean(grades(:,1:5),2);
% gradesTable=array2table(grades);
% gradesTable.Properties.VariableNames(1)={'ExamScore1'};
% gradesTable.Properties.VariableNames(2)={'ExamScore2'};
% gradesTable.Properties.VariableNames(3)={'ExamScore3'};
% gradesTable.Properties.VariableNames(4)={'ExamScore4'};
% gradesTable.Properties.VariableNames(5)={'ExamScore5'};
% gradesTable.Properties.VariableNames(6)={'MinScore'};
% gradesTable.Properties.VariableNames(7)={'MaxScore'};
% gradesTable.Properties.VariableNames(8)={'MeanScore'};
% gradesCell=num2cell(grades);
% gradesTable.GradeLetter=cell(size(gradesTable,1),1);
% for i=1:size (grades,1)
% %     j="Student"+i
% %     gradesTable.Properties.RowNames(i)=j;
%     gradesTable.Properties.RowNames(i)="Student"+i;
% end
% % tic
% % for i=1:size (grades,1)
% %     if gradesTable.MeanScore(i)>=90
% %         gradesTable.GradeLetter(i)={'A'};
% %     elseif gradesTable.MeanScore(i)>=80 && gradesTable.MeanScore(i)<90
% %         gradesTable.GradeLetter(i)= {'B'};
% %     elseif gradesTable.MeanScore(i)>=70 && gradesTable.MeanScore(i)<80
% %         gradesTable.GradeLetter(i)= {'C'};
% %     elseif gradesTable.MeanScore(i)>=60 && gradesTable.MeanScore(i)<70
% %         gradesTable.GradeLetter(i)= {'D'};
% %     elseif gradesTable.MeanScore(i)<60
% %         gradesTable.GradeLetter(i)= {'F'};
% %     end
% % end
% % toc
% % tic 
% % rowIndeces=find (gradesTable.MinScore<70 & gradesTable.MaxScore >75);
% % AIndeces=find (gradesTable.MeanScore>=90);
% % BIndeces=find (gradesTable.MeanScore<90 & gradesTable.MeanScore>=80);
% % CIndeces=find (gradesTable.MeanScore<80 & gradesTable.MeanScore>=70);
% % DIndeces=find (gradesTable.MeanScore<70 & gradesTable.MeanScore>=60);
% % FIndeces=find (gradesTable.MeanScore<60);
% % gradesTable.GradeLetter(AIndeces)={'A'};
% % gradesTable.GradeLetter(BIndeces)={'B'};
% % gradesTable.GradeLetter(CIndeces)={'C'};
% % gradesTable.GradeLetter(DIndeces)={'D'};
% % gradesTable.GradeLetter(FIndeces)={'F'};
% gradesTable.GradeLetter(gradesTable.MeanScore>=90)={'A'};
% gradesTable.GradeLetter(gradesTable.MeanScore<90 & gradesTable.MeanScore>=80)={'B'};
% gradesTable.GradeLetter(gradesTable.MeanScore<80 & gradesTable.MeanScore>=70)={'C'};
% gradesTable.GradeLetter(gradesTable.MeanScore<70 & gradesTable.MeanScore>=60)={'D'};
% gradesTable.GradeLetter(gradesTable.MeanScore<60)={'F'};