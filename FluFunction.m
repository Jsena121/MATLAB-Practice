function [Starts,Ends]=FluFunction(Input);
IndicesGreaterThan1 = find(Input(:,1) > 1);
A=diff(IndicesGreaterThan1);
B=[0;A];
C=[A;0];
Starts = IndicesGreaterThan1(B ~= 1);
Ends = IndicesGreaterThan1(C ~= 1);

