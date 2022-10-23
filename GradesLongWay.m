tic
clear
load examgrades.mat
for i=1:size(grades,1)
    A=grades(i,1:5);
    B=min(A);
    grades(i,6)=B;
    C=max(A);
    grades(i,7)=C;
    D=mean(A);
    grades(i,8)=D;
end
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
    if gradesTable.MeanScore(i)>=90
        gradesTable.GradeLetter(i)={'A'};
    elseif gradesTable.MeanScore(i)>=80 && gradesTable.MeanScore(i)<90
        gradesTable.GradeLetter(i)= {'B'};
    elseif gradesTable.MeanScore(i)>=70 && gradesTable.MeanScore(i)<80
        gradesTable.GradeLetter(i)= {'C'};
    elseif gradesTable.MeanScore(i)>=60 && gradesTable.MeanScore(i)<70
        gradesTable.GradeLetter(i)= {'D'};
    elseif gradesTable.MeanScore(i)<60
        gradesTable.GradeLetter(i)= {'F'};
    end
end
toc