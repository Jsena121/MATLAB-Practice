function [gradesTable,gradesCell]=GradesConv(grades)
grades(:,6)=min(grades(:,1:5),[],2);
grades(:,7)=max(grades(:,1:5),[],2);
grades(:,8)=mean(grades(:,1:5),2);
gradesTable=array2table(grades);
gradesTable.Properties.VariableNames(1)={'ExamScore1'};
gradesTable.Properties.VariableNames(2)={'ExamScore2'};
gradesTable.Properties.VariableNames(3)={'ExamScore3'};
gradesTable.Properties.VariableNames(4)={'ExamScore4'};
gradesTable.Properties.VariableNames(5)={'ExamScore5'};
gradesTable.Properties.VariableNames(6)={'MinScore'};
gradesTable.Properties.VariableNames(7)={'MaxScore'};
gradesTable.Properties.VariableNames(8)={'MeanScore'};
gradesCell=num2cell(grades);
gradesTable.GradeLetter=cell(size(gradesTable,1),1);
for i=1:size (grades,1)
        gradesTable.Properties.RowNames(i)="Student"+i;
end
gradesTable.GradeLetter(gradesTable.MeanScore>=90)={'A'};
gradesTable.GradeLetter(gradesTable.MeanScore<90 & gradesTable.MeanScore>=80)={'B'};
gradesTable.GradeLetter(gradesTable.MeanScore<80 & gradesTable.MeanScore>=70)={'C'};
gradesTable.GradeLetter(gradesTable.MeanScore<70 & gradesTable.MeanScore>=60)={'D'};
gradesTable.GradeLetter(gradesTable.MeanScore<60)={'F'};