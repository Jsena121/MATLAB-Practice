clear
load flu.mat
flu2 = dataset2struct(flu);
flu3 = struct2table(flu2);
flu3.DatenumVals = datenum(flu3.Date);
flu3.DateTimeVals = datetime(flu3.DatenumVals,'ConvertFrom','datenum');
DatenumVals = flu3.DatenumVals;
DateTimeVals = flu3.DateTimeVals;
ResultStruct.Location = [];
ResultStruct.StartDate = [];
ResultStruct.EndDate = [];
%NE
Input=flu3.NE;
[Starts,Ends]=FluFunction(Input);
NELocationCell(1:length(Starts),1) = {'NE'};
NELocation=NELocationCell;
NEStartDate = flu3.Date(Starts);
NEEndDate = flu3.Date(Ends);
%MidAtl
Input=flu3.MidAtl;
[Starts,Ends]=FluFunction(Input);
MidAtlLocationCell(1:length(Starts),1) = {'MidAtl'};
MidAtlLocation=MidAtlLocationCell;
MidAtlStartDate = flu3.Date(Starts);
MidAtlEndDate = flu3.Date(Ends);
%ENCentral
Input=flu3.ENCentral;
[Starts,Ends]=FluFunction(Input);
ENCentralLocationCell(1:length(Starts),1) = {'ENCentral'};
ENCentralLocation=ENCentralLocationCell;
ENCentralStartDate = flu3.Date(Starts);
ENCentralEndDate = flu3.Date(Ends);
%WNCentral
Input=flu3.WNCentral;
[Starts,Ends]=FluFunction(Input);
WNCentralLocationCell(1:length(Starts),1) = {'WNCentral'};
WNCentralLocation=WNCentralLocationCell;
WNCentralStartDate = flu3.Date(Starts);
WNCentralAtlEndDate = flu3.Date(Ends);
%SAtl
Input=flu3.SAtl;
[Starts,Ends]=FluFunction(Input);
SAtlLocationCell(1:length(Starts),1) = {'SAtl'};
SAtlLocation=SAtlLocationCell;
SAtlStartDate = flu3.Date(Starts);
SAtlEndDate = flu3.Date(Ends);
%ESCentral
Input=flu3.ESCentral;
[Starts,Ends]=FluFunction(Input);
ESCentralLocationCell(1:length(Starts),1) = {'ESCentral'};
ESCentralLocation=ESCentralLocationCell;
ESCentralStartDate = flu3.Date(Starts);
ESCentralEndDate = flu3.Date(Ends);
%WSCentral
Input=flu3.WSCentral;
[Starts,Ends]=FluFunction(Input);
WSCentralLocationCell(1:length(Starts),1) = {'WSCentral'};
WSCentralLocation=WSCentralLocationCell;
WSCentralStartDate = flu3.Date(Starts);
WSCentralEndDate = flu3.Date(Ends);
%Mtn
Input=flu3.Mtn;
[Starts,Ends]=FluFunction(Input);
MtnLocationCell(1:length(Starts),1) = {'Mtn'};
MtnLocation=MtnLocationCell;
MtnStartDate = flu3.Date(Starts);
MtnEndDate = flu3.Date(Ends);
%Pac
Input=flu3.Pac;
[Starts,Ends]=FluFunction(Input);
PacLocationCell(1:length(Starts),1) = {'Pac'};
PacLocation=PacLocationCell;
PacStartDate = flu3.Date(Starts);
PacEndDate = flu3.Date(Ends);
%WtdIlI
Input=flu3.WtdILI;
[Starts,Ends]=FluFunction(Input);
WtdILILocationCell(1:length(Starts),1) = {'WtdILI'};
WtdILILocation=WtdILILocationCell;
WtdILIStartDate = flu3.Date(Starts);
WtdILIEndDate = flu3.Date(Ends);

ResultStruct.Location=vertcat(NELocation,MidAtlLocation,ENCentralLocation, ...
    WNCentralLocation,SAtlLocation,ESCentralLocation,WSCentralLocation, ...
    MtnLocation,PacLocation,WtdILILocation);
ResultStruct.StartDate=vertcat(NEStartDate,MidAtlStartDate,ENCentralStartDate, ...
    WNCentralStartDate,SAtlStartDate,ESCentralStartDate,WSCentralStartDate, ...
    MtnStartDate,PacStartDate,WtdILIStartDate);
ResultStruct.EndDate=vertcat(NEEndDate,MidAtlEndDate,ENCentralEndDate, ...
    WNCentralAtlEndDate,SAtlEndDate,ESCentralEndDate,WSCentralEndDate, ...
    MtnEndDate,PacEndDate,WtdILIEndDate);
ResultTable = struct2table(ResultStruct);


%Plot
figure
grid on
hold on
plot (flu3.DateTimeVals,flu3.NE,'b.',flu3.DateTimeVals,flu3.MidAtl,'go', ...
    flu3.DateTimeVals,flu3.ENCentral,'rx',flu3.DateTimeVals,flu3.WNCentral, ...
    'c+',flu3.DateTimeVals,flu3.SAtl,'m*',flu3.DateTimeVals,flu3.ESCentral,'ks', ...
    flu3.DateTimeVals,flu3.WSCentral,'bd',flu3.DateTimeVals,flu3.Mtn,'gv', ...
    flu3.DateTimeVals,flu3.Pac,'r^',flu3.DateTimeVals,flu3.WtdILI,'c<');
title ('Flu Statistics FY 2006');
xlabel ('Date');
ylabel ('Percent Infected');
legend ('NE','MidAtl','ENCentral','WNCentral','SAtl','ESCentral', ...
    'WSCentral','Mtn','Pac','WtdILI');

%Interpolate
FluInterp.InterpDatenum = [];

Oct012005 = datenum (2005, 10, 01);
Oct012006 = datenum (2006, 10, 01);

FluInterp.InterpDatenum = (Oct012005:Oct012006)';

LocationMaster = {'NE','MidAtl','ENCentral','WNCentral','SAtl','ESCentral','WSCentral','Mtn','Pac','WtdILI'};

for i = (1:length(LocationMaster));
    IntInput = flu3.(LocationMaster{i});
    FluInterp.(LocationMaster{i}) = interp1(flu3.DatenumVals, ...
        flu3.(LocationMaster{i}),FluInterp.InterpDatenum,'previous', 'extrap');
end
FlueInterpTable = struct2table (FluInterp);

