clear
load examgrades.mat
for i=1:size(grades,1)
    A=grades(i,1:5);
    grades(i,6)=min(A);
    grades(i,7)=max(A);
    grades(i,8)=mean(A);
end