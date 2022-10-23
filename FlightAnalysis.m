tic
clear
ops =readtable('operations.csv');
%CessnaBool = strcmp (ops.manufacturer, 'CESSNA'); <-- case sensitive
%CessnaBool = contains (ops.manufacturer, 'CESSNA');<-- not case sensitive
%generate result structure
ResultStruct.Municipality = [];
ResultStruct.Time = [];
ResultStruct.Est_FlightTime = [];

%Identify desired time range and convert string times to datenum
StartTime = datenum(2022,06,01,09,00,00);
EndTime =datenum(2022,06,01,21,00,00);
ops.DateNumVals = datenum(ops.time,'yyyy-mm-dd HH:MM:SS');

%Set desired parameters
CessnaBool = strncmp (ops.manufacturer, 'CESSNA',4);
Cessna = find(CessnaBool==1);
Cessna172Bool = contains (ops.model(Cessna),'172');
Cessna172 = Cessna(Cessna172Bool==1);
Cessna172Newerthan2000Bool = ops.year(Cessna172)>=2000;
Cessna172Newerthan2000 = Cessna172(Cessna172Newerthan2000Bool==1);
Cessna172Municipalities = ops.municipality(Cessna172);
TimeFrameBool = ops.DateNumVals(Cessna172Newerthan2000)>=StartTime & ...
    ops.DateNumVals(Cessna172Newerthan2000)<=EndTime;
TimeFrame = Cessna172Newerthan2000(TimeFrameBool==1);

%Generate result table
ResultStruct.Municipality = ops.municipality(TimeFrame);
ResultStruct.Time = ops.time(TimeFrame);
ResultStruct.Est_FlightTime = ops.est_flighttime(TimeFrame);
ResultTable = struct2table (ResultStruct);
ResultTable.DateTime = datetime(ResultTable.Time,'Format',['yyyy-MM-dd ' ...
    'HH:mm:ss.SSS+00']);
ResultTable.DateNum = datenum(ResultTable.Time,'yyyy-mm-dd HH:MM:SS');

%Plotting
figure
grid on
hold on
plot (ResultTable.DateTime,ResultTable.Est_FlightTime,'bd');
plot (ResultTable,"DateTime","Est_FlightTime")
help plot

%TimeframeBool = ops.time(Cessna172Newerthan2000)>=StartTime && ops.time(Cessna172Newerthan2000)<= EndTime;

%example on finding unique instances of municipalities
[UniqueMuncs,UniqueIndeces] = unique(Cessna172Municipalities);
Cessna172UniqueIndeces = Cessna172(UniqueIndeces); 
%UniqueIndeces locates a unique municipality's location in UniqueMuncs as
%it appears in Cessna172Muncs, whereas Cessna172UniqueIndeces locates its
%location in ops
%DateVals = datenum(ops.time, 'yyyy,mm,dd')
%DateNumCessna172Unique = datenum(ops.time(Cessna172UniqueIndeces));
%DateTimeCessna172Unique = datetime(ops.time(Cessna172UniqueIndeces), ...
 %   'Format','yyyy-MM-dd hh:mm:ss.SSS+00');
%TimeCessna172Unique = datetime(DateTimeCessna172Unique, 'Format', 'hh:mm:ss.SSS');
toc