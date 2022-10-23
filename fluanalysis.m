tic
clear
load flu.mat
flu2=dataset2struct(flu);
flu3=struct2table(flu2);
flu3.DateNumber=datenum(flu3.Date);
flu3.DateTime=datetime(flu3.Date);
%flu3.DateTimeAlt=datetime(flu3.DateNumber,'ConvertFrom','datenum');
flu3.NEFLUZONE(flu3.NE>=1)=flu3.DateNumber(flu3.NE>=1);
%flu3.NEFLUZONE(flu3.NE<1)={'LOW'};
flu3.MIDATLFLUZONE(flu3.MidAtl>=1)=flu3.DateNumber(flu3.MidAtl>=1);
%flu3.MIDATLFLUZONE(flu3.MidAtl<1)={'LOW'};
NEResultStruct.Location=[];
NEResultStruct.StartDate=[];
NEResultStruct.EndDate=[];
NEResultTable=struct2table(NEResultStruct);
MidAtlResultStruct.Location=[];
MidAtlResultStruct.StartDate=[];
MidAtlResultStruct.EndDate=[];
MidAtlResultTable=struct2table(NEResultStruct);
%ResultTable.Location(find(diff(flu3.MIDATLFLUZONE)==7))="MIDATL"
NERange=find(diff(flu3.NEFLUZONE)==7);
NECons=flu3.NEFLUZONE(NERange);
%NELocation(1:10,1)=(1:10,1);
h=size(NECons)-1;
for i=1:h
    j(i,:)=(h+2-i);
    k=j(:,1);
    if NECons(i+1)-NECons(i)~=7
        NEResultTable.StartDate(i)=min(NECons(i+1)); 
        NEResultTable.Location(i)=1;
        %ResultTable.EndDate(i)=max(flu3.NEFLUZONE(j(i,1)));
    elseif i==1 
        NEResultTable.StartDate(i)=min(NECons(i));
        NEResultTable.Location=1;
        %ResultTable.EndDate(i)=max(flu3.NEFLUZONE(j(i,1)));
        %ResultTable.Location(i)={'NE'}
    end
    if NECons(k)-NECons(k-1)~=7
        NEResultTable.EndDate(i)=max(flu3.NEFLUZONE((i:k)+1));
    elseif i==h(1,1) && NECons(i)-NECons(i-1)==7;
        NEResultTable.EndDate(i)=max(flu3.NEFLUZONE);
%     elseif NECons(k)-NECons(k-1)==7 & ResultTable.StartDate(i)~=0
%         ResultTable.EndDate(i)=max(flu3.NEFLUZONE)
% %     elseif flu3.NEFLUZONE(j(i,1))-flu3.NEFLUZONE(j(i,1)-1)==7
%         ResultTable.EndDate(i)=0
    end
%      ResultTable=ResultTable(any(ResultTable{:,:},2),:);
%      ResultTable.Location=num2cell(ResultTable.Location);
%      if NECons(i+1)-NECons(i)~=7
%         ResultTable.Location(i)={'NE'};
%      elseif i==1
%          ResultTable.Location(i)={'NE'}'
%      end
end
%
%MIDATL
MidAtlRange=find(diff(flu3.MIDATLFLUZONE)==7);
MidAtlCons=flu3.MIDATLFLUZONE(MidAtlRange);
h=size(MidAtlCons)-1;
for i=1:h
    j(i,:)=(h+2-i);
    k=j(:,1);
    if MidAtlCons(i+1)-MidAtlCons(i)~=7
        MidAtlResultTable.StartDate(i)=min(MidAtlCons(i+1));
        MidAtlResultTable.Location(i)=2;
    elseif i==1
        MidAtlResultTable.StartDate(i)=min(MidAtlCons(i));
        MidAtlResultTable.Location=2;
    end
    if MidAtlCons(k)-MidAtlCons(k-1)~=7
        MidAtlResultTable.EndDate(k)=MidAtlCons(k);
    elseif i==h(1,1) && MidAtlCons(i)-MidAtlCons(i-1)==7;
        MidAtlResultTable.EndDate(i)=max(flu3.MIDATLFLUZONE)
    end
end
NEResultTable=NEResultTable(any(NEResultTable{:,:},2),:);
MidAtlResultTable=MidAtlResultTable(any(MidAtlResultTable{:,:},2),:);
ResultTable=vertcat(NEResultTable,MidAtlResultTable);
LocationHolderDouble=ResultTable.Location;
LocationHolderString(LocationHolderDouble==1)={'NE'};
LocationHolderString(LocationHolderDouble==2)={'MidAtl'};
LocationHolderString(LocationHolderDouble==0)={'ERROR'};
LocationHolderVert=LocationHolderString';
%LocationHolder(ResultTable.Location==1)={'NE'};
ResultTable.Location=num2cell(ResultTable.Location);
ResultTable.Location=LocationHolderVert;
% for i=1:2
%     j(i,:)=(h+2-i);
%     k=j(:,1);
%     if NECons(i+1)-NECons(i)~=7
%           ResultTable.Location(i)={'NE'};
%     elseif i==1
%         ResultTable.Location={'NE'}'
%     end
% end
ResultTable.StartDate=datetime(ResultTable.StartDate,'ConvertFrom','datenum');
ResultTable.EndDate=datetime(ResultTable.EndDate,'ConvertFrom','datenum');
%NEConsecutive=find(diff(NERange)
%ResultTable.StartDate(flu3.NEFLUZONE~=0)=flu3.NEFLUZONE(flu3.NEFLUZONE~=0);
% Test that checks whether the DateTime methods both worked:
%
% flu3.Test(flu3.DateTime==flu3.DateTimeAlt)={"true"};
% flu3.Test(flu3.DateTime~=flu3.DateTimeAlt)={"false"};
%
%For loop that runs a test check whether the DateTime methods work:
%
% for i=1:size(flu3,1);
%     if flu3.DateTime(i)==flu3.DateTimeAlt(i);
%         flu3.Test(i)={"true"};
%     end
% end
%
% Alternate long way of running DateNum and DateTime:
%
% flu4=table2cell(flu3);
% a(:,1)=flu4(:,1);
% flu3.DateNumber=datenum(a);
% %flu3.DateTime=datetime(flu3.DateNumber,'ConvertFrom','datenum');
% flu3.DateTime=datetime(a,'InputFormat','MM/dd/uuuu');
b=flu3.DateNumber;
c=flu3.DateTime;
toc