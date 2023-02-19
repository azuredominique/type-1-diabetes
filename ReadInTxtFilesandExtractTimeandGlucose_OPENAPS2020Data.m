%% Attempting to "Loopify" something to read in many filenames
%% Goal: Have a Matrix of all the Tempfiles from a given Folder
%Trying to Read in the file in matlab
%running line 43-47 on one file that was manually opened and resaved as txt
%took about 30 seconds

%% July 2020 OpenAPS File LIst. Create a list of all the ENTRIES files from the pull.
%Thank god only 153

%start of the list
%I am taking the largest entries file for each person
%must manually add .json to each one

% I did not include people if they had < 1 month of data or if I could not
% unzip their files
%I included the largest file from each person.
FileListEntriesOpenAPS72020={'entries_2018-03-01_to_2018-08-05.json'; ...
    'entries__to_2019-06-21.json'; 'entries__to_2018-02-01.json';'entries_2015-01-01_to_2018-01-03.json';...
    'entries_01884126.json';'entries_2019-01-01_to_2019-11-12.json';'entries__to_2018-12-17.json';...
    'entries_2016-01-01_to_2018-04-17.json';'entries__to_2017-10-04.json';...
    'entries_2018-07-25_to_2019-03-20.json';'entries_2018-04-01_to_2018-12-19.json';...
    'entries__to_2017-10-20.json';'entries_2018-10-19_to_2019-05-19.json';...
    'entries_13783771.json';'entries_2017-02-01_to_2018-12-18.json';'entries_2018-03-12_to_2018-06-29.json';...
    'entries__to_2019-09-25.json';'entries__to_2019-03-27.json';'entries__to_2019-07-07.json';...
    'entries__to_2018-03-27.json';'entries__to_2018-07-23.json';'entries__to_2019-08-31.json';...
    'entries__to_2017-11-25.json';'entries_22961398.json';'entries_2018-06-27_to_2019-08-05.json';...
    'entries_24587372.json';'entries_2016-01-01_to_2018-08-06.json';'entries_2017-06-05_to_2018-02-17.json';...
    'entries__to_2019-04-27.json';'entries__to_2019-03-10.json';'entries__to_2019-03-09.json';...
    'entries_2018-05-02_to_2018-11-04.json';'entries__to_2018-10-24.json';'entries__to_2019-03-05.json';...
    'entries_34148224.json';'entries_2018-07-15_to_2018-12-24.json';'entries__to_2018-07-10.json';...
    'entries_37875431.json';'entries__to_2017-11-25.json';'entries_2018-01-01_to_2018-10-11.json';'entries__to_2017-11-03.json';...
    'entries__to_2018-04-06.json';'entries_40237051.json';'entries__to_2019-12-25.json';'entries_2017-01-29_to_2019-09-22.json';...
    'entries__to_2020-01-26.json';'entries__to_2019-05-11.json';'entries_2018-10-28_to_2019-03-20.json';...
    'entries__to_2020-01-30.json';'entries__to_2019-03-05.json';'entries_2019-01-01_to_2019-06-17.json';'entries_46966807.json';...
    'entries__to_2019-07-16.json';'entries__to_2018-09-25.json';'entries_2018-07-10_to_2019-02-06.json';'entries_51336122.json';...
    '1584039280000_82114438_entries.json';'entries_52804089.json';'entries_2019-05-10_to_2019-08-10.json';...
    'entries_2019-05-01_to_2019-07-08.json';'entries_2018-10-24_to_2019-04-30.json';'entries__to_2018-10-06.json';...
    'entries__to_2019-08-17.json';'entries__to_2019-01-05.json';'entries__to_2018-07-03.json';'entries__to_2019-06-11.json';...
    'entries__to_2018-02-27.json';'entries_2017-10-29_to_2019-07-16.json';'entries__to_2018-03-23.json';...
    'entries__to_2020-01-23.json';'entries_67359234.json';'entries__to_2020-01-22.json';'entries_68267781.json';...
    'entries__to_2019-04-18.json';'entries__to_2019-10-01.json';'entries__to_2020-03-04.json';...
    'entries_2018-10-12_to_2019-01-20.json';'entries_71236754.json';'entries_71397255.json';...
    'entries_2019-02-01_to_2019-05-10.json';'entries_73521474.json';'entries_2016-11-01_to_2018-01-04.json';...
    'entries__to_2019-05-01.json';'entries_2017-10-15_to_2018-01-12.json';'entries__to_2018-07-14.json';...
    'entries_80373992.json';'entries_2018-11-29_to_2019-05-29.json';'entries_2014-12-14_to_2019-07-15.json';...
    'entries__to_2019-04-15.json';'entries_84081904.json';'entries__to_2019-02-14.json';'entries_84984656.json';...
    'entries_84984656.json';'entries__to_2017-10-09.json';'entries_87770496.json';'entries_88004055.json';'entries__to_2017-11-28.json';...
    'entries_89727223.json';'entries_2018-03-21_to_2019-08-27.json';'entries__to_2019-03-19.json';'entries__to_2019-11-11.json';...
    'entries__to_2018-09-12.json';'entries_94875538.json';'entries_2018-01-01_to_2018-03-01.json';'entries__to_2018-02-11.json';...
    'entries_96484928.json';'entries_2017-09-27_to_2018-04-09.json';'entries__to_2018-02-22.json';'entries__to_2017-10-28.json';...
    'entries__to_2019-06-21.json';'entries_98974339.json';'entries_99296581.json';'entries__to_2019-11-20.json';'entries__to_2018-10-28.json';...
    'entries__to_2018-02-02.json'};%8628 %next person to add is 2860
    


%% I guess I'll need to make a stupid file list for device status too
%%  July 2020 OpenAPS File LIst. Create a list of all the ENTRIES files from the pull.
%Should be maybe a couple hundred
%Make a File List for devicestatus profile and treatments using a blank
%script and ctrl+f.

%% 
%Loop through files in list above and decode jsons from each one;

%This loops aim to flatten the entries file which contains many variables
%Here are the variable types within entries

%Entries, unlike treatments, seems to always have the SAME number of
%variables in each file - 9
%x_id = id of the person
%dateString = in zulu time. IDK where the timezone offset is
%direction = up down or flat
%sgv = blood glucose
%type = usually sgv but occasionally takes other values not sure why. 
%NSCLIENT_OD
%created_at = when this entry was created in mystery units
%date = in mystery units
%device = the person's device type

%Of these I want sgv dateString and device
%2 has a different file structure. it isn't a nested set of structures its
%one structure

%time and glucose
%3 and 11,12,13,16,21,26,36,38,40,41,43,52,56,57,59,60,61,62,65,68,71 don't work different structure
for a=[75:length(FileListEntriesOpenAPS72020)]; %just doing one so far as a test
fname=FileListEntriesOpenAPS72020{a,1}(:,:); %go sequentially through the file names defined above in file lists for entries, device status, profiles and treatments

%using json decode. output is % these val variables
%fname='entries_2018-03-01_to_2018-08-05.json';
val = jsondecode(fileread(fname)); %focusing on val first to make glucose timeseries

    %nothing to do here

%fname='devicestatus_2018-03-01_to_2018-08-05.json';
%valdevicestatus = jsondecode(fileread(fname));
%fname='profile_2018-03-01_to_2018-08-05.json';
%valprofile = jsondecode(fileread(fname));
%fname='treatments_2018-03-01_to_2018-08-05.json';
%valtreatments = jsondecode(fileread(fname));


%% Un-nesting  The structure here is stupidly nested. Use flattenStruct2Cell in order to
% create a cell matrix with variable names in column one and values in
% column two. 

%At the end of this process the variables are still stupidly layered.
%Within each cell there is a matrix (or another cell ?) containing the list
%of all variables present at that timepoint. Then the adjacent column i
%made has within each one of those cells values for all variables at that
%timepoint. so yeah, there's more munging to do. 

%I'm so confused because now jsondecode seems to be doing the work for me
%and val is a structure very long with all time points in each column
for b=1:length(val)
try [ entryvalues{b,1} entryvarnames{b,1}] =flattenStruct2Cell(val{b,1});
disp(b)
flatentries{1,a}=[ entryvarnames entryvalues ] ;
catch
    %Nothing to do, catching errors and moving on
end
end

clear val entryvarnames entryvalues
disp(a)
end
%Here are the variable types within entries

%Entries, unlike treatments, seems to always have the SAME number of
%variables in each file - 9
%x_id = id of the person
%dateString = in zulu time. IDK where the timezone offset is
%direction = up down or flat
%sgv = blood glucose
%type = usually sgv but occasionally takes other values not sure why. 
%NSCLIENT_OD
%created_at = when this entry was created in mystery units
%date = in mystery units
%device = the person's device type


%so now im aiming to take flatentries, this 2 column nested cell matrix
%containing one row per timepoint, and within each cell another cell matrix
%(for entries 9 variables long) having variable names (macro column 1), or
%variable values (macro column 2)
%because the entries file actually has the same fucking variables in every
%row, I can index and pull out data into actual matrices that I can plot.

%loopifying this into another cell matrix for all the individuals will be %its own pf
for i=1:1440*10; %doing first 10 days as a test (but measures aren't every minute so this might be a lot longer if every 5-15 min)
% x_id=flatentries{2,1}(1,1); %xid is the id of the person. I want to save this for reference
% device=flatentries{2,1}(1,9); %also a single string of the device title. Saving for ref. to compare devices in the future
%  direction(i)=flatentries{i,2}(1,3); %is glucose trending up down or steady. I don't care for right now but might as well save
 %for some reason the dates in flat entries are entered backwards: most
 %recent entries are at the top. So I'm going to have to reverse the
 %metrics to plot with the past first and the present last
 for j=[2:7,1]
 if strcmp(cell2mat(flatentries{i,1}(1,j)),'dateString') == 1 %finding the index for each cell where dateString is stored. Since it's not fucking consistent
 dateString(i,1)=flatentries{i,2}(1,j);  %make a cell array with each cell (row) containing that datetime string. Still backwards
 else %choosing to leave blanks/not make entries when there is no associated date
 end
 end
 
 for j=[4:7,1:3]
 if strcmp(cell2mat(flatentries{i,1}(1,j)),'sgv') == 1 %same for glucose. find the index of each cell that glucose resides.
 sgv(i)=cell2mat(flatentries{i,2}(1,j)); %sgv; idk what it stand for but its the glucose value
 else %just moving on when we don't have a good match
 end
 end
 disp(i)
end

figure;plot(sgv); %Ok--- all that and we have a glucose value!

%will need to add timezone offset as a variable for date. which should be
%within prifle

for i = 1
DateTimeVariable=dateString; %most direct way to get the time column
GlucoseVariable=sgv;%most direct way to get the gllucose value. note it often begins with lots of zeros

%format the date time variable
YearVariable=extractBetween(DateTimeVariable,1,4);
MonthVariable=extractBetween(DateTimeVariable,6,7);
DayVariable=extractBetween(DateTimeVariable,9,10);
HourVariable=extractBetween(DateTimeVariable,12,13);
MinuteVariable=extractBetween(DateTimeVariable,15,16);
SecondVariable=extractBetween(DateTimeVariable,18,19);

%the loop below transforms the datetime from a file to matlab readable
for t=1:length(DateTimeVariable)
    DateVector(t,:)=[YearVariable(t),MonthVariable(t),DayVariable(t),HourVariable(t),MinuteVariable(t),SecondVariable(t)];
    
    DateNumber(t,:)=datenum(str2num(YearVariable{t}(:,:)),str2num(MonthVariable{t}(:,:)),str2num(DayVariable{t}(:,:)),str2num(HourVariable{t}(:,:)),str2num(MinuteVariable{t}(:,:)),str2num(SecondVariable{t}(:,:)));
    
    %FormattedDateTime(t,1)=datestr(DateVector(t,:),formatOut); %this one
    %didn't work
end

%matching datetime to glucose
Tempfile{:,i}=[fliplr(DateNumber) fliplr(GlucoseVariable)']; %for some bloody reason time goes from end to beginning
end


%this should be 6/14-8/4. So like 55 days. data look to be spaced roughly
%every 5 minutes. So that's like 720000 minutes, which is about what i have
figure;plot(Tempfile{1,1}(:,1),Tempfile{1,1}(:,2)); %this is "pre" this will not be properly aligned by time

%and this looks about right after interpolation. 
set(gca,'XTickLabel', [1:2:60],'fontsize',10)
set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
set(gca,'FontSize',6);


%% Ok that fucking works. Lets clean that data

for i=1

MATLABDate=Tempfile{1,1}(:,1);
matrix=[MATLABDate, Tempfile{1,1}(:,2)]; 
[~,idx2] = unique(matrix(:,1));   %which rows have a unique first value?
matrix2 = matrix(idx2,:);  %only use those
MATLABDate=matrix2(:,1); Tempfile=matrix2(:,2);
idx = isfinite(MATLABDate) & isfinite(Tempfile(:,1));
MATLABDate=MATLABDate(idx); Tempfile=Tempfile(idx);% will this result in mismatching lenghts or did the & above correct for this
tempfit=fit(MATLABDate,Tempfile,'linearinterp');
ending=MATLABDate(end); start=MATLABDate(1); interval=(start:1/1440:ending); TempString=feval(tempfit, interval); 
figure; plot(TempString); %test plot
%and this looks about right after interpolation. but the data look really
%all over the place. should read in more people to check.
set(gca,'XTickLabel', [1:2:60],'fontsize',10)
set(gca,'XTick', [  1 1440*2 1440*4 1440*6 1440*8 1440*10 1440*12 1440*14 1440*16 1440*18 1440*20 1440*22 1440*24 1440*26 1440*28 1440*30 1440*32 1440*34 1440*36 1440*38 1440*40 1440*42 1440*44 1440*46 1440*48 1440*50 1440*52 1440*54 1440*56 1440*58 1440*60 1440*62 1440*64 1440*66 1440*68 1440*70 1440*72 ],'fontsize',10);
set(gca,'FontSize',6);

    
    
   %clear TempString TempString2
   
figure; plot(TempString,'color','k'); %test plot
end
%a=input('What is the lower limit ');
%b=input('What is the upper limit '); 

%TempString(TempString<a)=a;
%TempString(TempString>b)=b; 

TempString2=TempString;
Deriv=abs(diff(TempString));%previously TempString2
    for k=1:length(Deriv)-60
       if Deriv(k)>=0.4 %0.5 ;
           disp(k); 
           TempString2(k,1)=median(TempString(k:k+60));
       elseif Deriv(k)<=0.05 
           disp(k); 
           TempString2(k,1)=median(TempString(k:k+60));
       else
           disp('cats');
  end
    end
%end
hold on;plot(TempString2,'color','b','LineWidth',2);

end


%% Reading in other files
%Entries, unlike treatments, seems to always have the SAME number of
%variables in each file - 9
%x_id
%dateString
%direction
%sgv
%type
%NSCLIENT_OD
%created_at
%date
%device


for i=1:length(valtreatments)
[ flatvaltreatments{i,1} cellnamestack{i,1}] =flattenStruct2Cell(valtreatments{i,1});
disp(i)
end
%now i've made two matrices. flat cells w variable names and flat cells w
%values. Now I want to put them together and then extract each variable
%into its own cell.
flatvaltreatmentsandlabels=[ cellnamestack flatvaltreatments ] ;

% In the entries file SGV is the blood glucose variable 
% In the treatments file insulin is the insulin variable
% In the treatments file date and created_at are the date values
% In the treatments file eventType tells  you how to make a correction
%Import sgv, time, insulin and time, eventType, carbs, isSMB, and device

%DeviceStatus Variable Names are:
%x_id, 
%reason
%units
%insulin,
%NSCLIENT_ID,
%created_at
%enteredBy
%notes,
%eventType,
%targetBottom
%targetTop
%date,
%isSMB,
%carbs
%duration

% these jsons read in in a very inefficient way - they keep info for each
% variable at each timepoint in a 1x1 structure. I need to know I can take
% this data into a format i can used it before I make a giant matrix where
% each file is 1 cell per timepoint, each cell containing a structure with
% the variables I need inside

% date is the date

%% Below is for the Tidepool Data

%%This is SAP 100 pt 1
FileList = ['train_07d808c00b707b2dc65962ebff546b7317104516f352b4180d40b4ecdfed8b99.csv'; ...
'train_07f024f9b2df04a3556a231aca535df04709564d261534d4815c3cb1ba33a5ef.csv'; ...
'train_0ae3c54f576290d8c4b188adddac94c64b69e4421c279121b4141dd7835f82e7.csv'; ...
'train_10005260d3ff0ed5ebefa82372e10d0616b0968477c2d5f0821054f0e11e4a19.csv'; ...
'train_160102103a951851ef4f652ec2b2051b325148d5ca0736f6a17c5ad927b2952d.csv'; ...
'train_1fd6ccfe3e7e3634f81d9c53ca7f9324a9298b4f682839ab8be675b50199fd09.csv'; ...
'train_24b7a7a140092b0d2b1c4754efdd06a832493da1a9af866b304d16113de7abeb.csv'; ...
'train_2868b266cbd84932c19b09551ea74432effd6d41ffba23443689a3dd30048b86.csv'; ...
'train_2e2a57855655604fee26ccd104c2173cdabcce707ed82138697d817f3f5eafc7.csv'; ...
'train_2e63dee36bbe685c07b4018b2557d047004ecba7cd871584f0566985a89a7193.csv'; ...
'train_2fdfec9546854c214ba413ec6c3ed369a5c9c3e7bf71c5a9058bbe7444f537f8.csv'; ...
'train_301e2b3f992a2ee94fcbd13a207de095e06a99c680f707f2d84a8d60f328c998.csv'; ...
'train_36456004b763622d7646bf0f42e77a1189ec044daa9ed25b69ab0f002dd7aa94.csv'; ...
'train_376036c828808b881c9ba4e01ff31720e5ab269f73b8886a146f6028458c905f.csv'; ...
'train_4023423e51054602b7a44930e9e8d8eb9332e62e8135747781b8be96915c4f67.csv' ; ...
'train_415a516b05a7a984c62439486f0b5111f6e7216e2bfd6be436023789f5c91212.csv'; ...
'train_416c497cc0567b7f3c4401611a76f1d5cd859efa56e1bc62cdff14d675a108a0.csv'; ...
'train_473e220c7530e604e8077a7b4dac00df438ae924450caf02783eedf46c5e5d48.csv'; ...
'train_4a5949b7f5219add8998157f4f6d3f1fbcd8996f512f865d2600e5e64a90f03b.csv'; ...
'train_546b36db400ce2fb8630e3a4c48d814e31b064adc77b072470c73fae3e04c5c0.csv'; ...
'train_54b090098b2de35fed70af533c1f74be8ae9808b47a444838648c4778e48134b.csv'; ...
'train_55659c31e89c3c27ee3926d946af025a1c273033f5a7a9ec4c75a29527942169.csv'; ...
'train_6367669fedb402ee1117b11f40c7c748b153e73966fe42502dbad2cdb4407cf6.csv'; ...
'train_65a71e48e64827646838032c8d29d3ac91ac36da94de018be6f668559ff4f9c2.csv'; ...
'train_66dd9b046580f6826669a3461fef894d6edfce184881f70c53b9b4aba9268dd6.csv'; ...
'train_67eafd4fdfae29871749f7ba338e04aabb8bdc83e2d560cc41bc81e43ce49424.csv'; ...
'train_6deb1b5679a43ca785749154d93d17de6ccdf929b87b49b598f4753b75df6493.csv'; ...
'train_6fe50b9e99a575d7cca29bd011fb4b145923e8b6388e051cc626a07df7541c68.csv'; ...
'train_717ce79f0b589d8fa09ea253ab4a5da981e369f1807bc9f60a75ec49a200061c.csv'; ...
'train_77526fa44a35cc27ac5ea22bdad963752c938d08947a76ef7cc10d38bff9cd2b.csv' ; ...
'train_7e3b20f55dc6a64cef8e25e7537fe75bf9551586e3038cf718cee7b4bba7a3da.csv' ; ...
'train_7f174b2c1a00b63569e9725ca0400dcf8ea2652ac4761236df07a1153c27a49e.csv' ; ...
'train_80a5c60283c2b095d69cca4f64c26e2564958a07e2f0e19fafd073ed47d2b5e7.csv' ; ...
'train_8103ebf9541dd56bd0fdd7517a600b6f169bd6de70d1ca8697713632c9a78103.csv' ; ...
'train_85605cc137c255c800d2c48d843900650a979a7f3473273ba52d1266cadb804e.csv' ; ...
'train_85e54f7ad714033bdf3e12afeedaabb2d52f7b34bce3dc45320b46e30cd9a350.csv' ; ...
'train_86488137f56fcd0c630c46d00b3afb570dd04d581e927f205a0f08de653d6770.csv' ; ...
'train_94d6eef718e67b0c9690641b90f67944f4884a248ed7f563fb9faef9543dc3ff.csv' ; ...
'train_9518e98aecadf17e9a11b40bcac02f5143f442c919bb009c087610edce6b9582.csv' ; ...
'train_9518fd8122be548e04c3564e90b0f985040275b3e49c9f06dac4b1ed148c2e8f.csv' ; ...
'train_994546ec227675c3ea9a477ce6c90900a60f88a32cd471da187f83389a1076c0.csv' ; ...
'train_9ba04d8d1268e53dc5b21adecfc106dcbf7198ed768fa3d944dc87663a9e6dc4.csv' ; ...
'train_9d5e8b8787fba9bc77a902739c86e2d5bd31a24cede9bc739c711a7e2e61ef49.csv' ; ...
'train_aa7d0e72dd55982f0a007c707fb3772125ad88bc27b4ff3f4c619edacc06c476.csv' ; ...
'train_abfc04caa79b02e8b7f51c16a864ac8c0102e2d8c786b1dab674425140dabb86.csv' ; ...
'train_b09b5120b5a7049bf7ca0c9fa89b9a04ddf831674035439f3422d3cc6b58860e.csv' ; ...
'train_b251f16178ce26240640826fae64062c1ec3c51663f0aa7b33478dd15069618e.csv' ; ...
'train_b5b859946a87bf5a8d7bd221661488b9642233980b02f702adc6c9a4b3f6b6bf.csv' ; ...
'train_bee626f800a0f686cb262bbd23093e7906f7d111c0392234202b5cdc831f9c1f.csv' ; ...
'train_c45f5895bf3472672f39b0fb125e2ebc466f232e7b26af9bc694a8b31ed489d0.csv' ; ...
'train_c4995e26671bb199994aeef0c0a8bf5239d6a75f43cdc72cba61d03e7dcbfc80.csv' ; ...
'train_c69a10e993c0452f04f80f5d3dd58ebac53b1448be3ba8cb2f2a1b9d341051bf.csv' ; ...
'train_cc74ad036ecb04a4dc0e0c967b74b84e62fe5cabe4c8108274272eca2f05d980.csv' ; ...
'train_d3e2921d627e64d750361d865f4f6a172143a587883e669dfc25ff195ba7ee6a.csv' ; ...
'train_d4727451ea7021dbfa6fd9d62fa57afccaa0d4e1ba73f0e35f559d18364feba4.csv' ; ...
'train_db8c8f072224883cc005847040ba847b3ccd21da6490baf9251cd814f0c49b67.csv' ; ...
'train_e038ba0a0105c517fbe578271602b6fd4f03dcaaa3d88e7931bc338861051f78.csv' ; ...
'train_e0d4c09a2c38269fa27362dc752d721a6fb820a6f0448d67dfc80cad6aee71bc.csv' ; ...
'train_ee1008c8cb66f2c06ffa55e5d80e15ac66c6578da0315b3c34aeb311f200025c.csv' ; ...
'train_ee6ffcc30cdeed81b998b84b770d8d4ab7681a13670a545536da7a9371b7a757.csv' ; ...
'train_f086ce14b9e88da3057b628cd382720679262dff89747bd7ddead11f79ee8817.csv' ; ...
'train_f0a425662446b900863305ee4bff3d7ef0d4bf89b2b6aaa574c8f7039eaef64b.csv' ; ...
'train_f4030841972eef3bacb847dcf5f62987be3cef3a5fbd274aa6a4f71659e92fc3.csv' ; ...
'train_f945009b76d237c14445d6de9a9478f407d9e9c85fc93e342d02fe5b42812cce.csv'];



%This is SAP100 pt 2
FileListSap100pt2=['train_0a1f3ac86f7620ee531a6131bdc7844f57b6f70a3a7d451f0b0e40a8dff14dc9.csv' ; ...
'train_1a8e657efe33c1d3551bb8e89d53241f88327603f956e230e4987705b46f685b.csv' ; ...
'train_1ccbd3f6986ee4cb0f725de16579f9b840fc0a7e5cacd18515c6603b46f70f24.csv' ; ...
'train_2e10168b4b0e1968ec2d3b5775699c5111ecba855d96bdccacbd576de4937d5b.csv' ; ...
'train_2eff7c6e22b3159f47ec8846cbedc02cd25217e5a900d0a37646cf0f9262cf39.csv' ; ...
'train_30c42de0c3018c4f42c92256c68477da7ce32c5c08ead65200fe1940d0842274.csv' ; ...
'train_54dae8fc28f17000d0ab89b6a589d9e2e7b3dcf818bda39b22c11c6206a0a3b1.csv' ; ...
'train_55c5eac723fb563a3f67906b98fe8a90485afd889e9946241a633f51f35e875b.csv' ; ...
'train_5a7979edd89bdb0c711381a27d70916f6a9b11cb0c7b182c80550718917ed320.csv' ; ...
'train_65d013a5477dada4f1c10b7ea92befaeefd04c1f8faf7ee104adfe51c48a33a8.csv' ; ...
'train_669338c27c9fde311943744a522cefc0b2b6d5ac40ede15557ee18ebea6e69f6.csv' ; ...
'train_777eb0f5a6877c8058352063e1e22400f10bed58e05a610c1be6d32f6f947c6b.csv' ; ...
'train_83ce9ebcbeb53a3dfc0899d3bad758902b7f29453a6baf7ebdd46bed2442a8cc.csv' ; ...
'train_9036ac5808b094bc027a31a39e9e8514dad2ad43074fd528283ba3f8ca586fee.csv' ; ...
'train_99399ae8b4a495f28f8f82fe55b548563716fbf31e59286adf63e357b70fc837.csv' ; ...
'train_a71abd4e08ab19da1e090bc24f209bc92ec2b55fb028c1b5d100759b26ce34c1.csv' ; ...
'train_b3eb85475c907ebaa2a20b2a12f0d01f3e82a099dbe9ce50e497cfc2cb47a3e3.csv' ; ...
'train_b8f98c7fb599335bb374b0b036724bfc714404581d5fa2b75e714b5f642010e6.csv' ; ...
'train_ba7f6ddc4c2644e4c08078fe335e57f0d4a8595636e1c6295220fa6b70e6fbdd.csv' ; ...
'train_baf43b5cdb97c109223bbde6063c6632a4781a27d01f3c40024b2948bc1dc729.csv' ; ...
'train_c3e1f727f9f9b1e47bd3ee85f78321ddd8a508d6e0765edba1f689023fe6f605.csv' ; ...
'train_cc5ecefec5975974e2362083806d04671ac38783faf1a6edcc3456bf0e40fbfa.csv' ; ...
'train_ced97802f9e98a099af9e17747741a14df923483f595959a0b419e802f42643a.csv' ; ...
'train_d5894931a34262b5d46bf9c82d98cd1ccadc9392c3f0d0c82322b14ceadb44ba.csv' ; ...
'train_dbcb6083fae7a69dd4475687e85061031aaa1d1d45826676cf2ee504648eef49.csv' ; ...
'train_dbfd8940e6e751c028be481af65c15adb149d7c7bf2db12aa33b3c106a201e02.csv' ; ...
'train_e09716a3c053b0bbfa9bdaf4befecae8edc81ff9f63b193b16b08dc446a58977.csv' ; ...
'train_e0e0c1b4e8c754ee772f5226162800723cfedd98eff97ae50c8e58b037071610.csv' ; ...
'train_e350eda6da44c7cecca73bfac0d5c7bc74a2ab28602dd57eb58076571a394eda.csv' ; ...
'train_e9f834f4c3701dc1364a7692f1ead4babaf990211742009c28fa72cd7c74b087.csv' ; ...
'train_ed0d568a49546d64a23613a87ba5bc766477fe187781ef90b779fd5695c85c52.csv' ; ...
'train_f8ac6861f2848add8df7b32788c05b54b063dec9d24d5726fd1a22b59a6fb90d.csv' ; ...
'train_fa6d14d94cca2cb2c33b9acd791a8fdbbc174c584396b26077a3cc1db1de1556.csv' ; ...
'train_fc2b12608d03f91a22838fa8f7b7a03314c3071d8b373dd94c214e9f3c012992.csv']
              
for i = 1
Tbl=readtable(FileListSap100pt2(i,:));
DateTimeVariable=Tbl.time; %most direct way to get the time column
GlucoseVariable=Tbl.value; %most direct way to get the gllucose value. note it often begins with lots of zeros
VarNames=Tbl.Properties.VariableNames; %Recover Variable Names
ColIdx=find(strcmp(VarNames,'time')); %Return Column Index for Variable Name 'time'


%format the date time variable
YearVariable=extractBetween(DateTimeVariable,1,4);
MonthVariable=extractBetween(DateTimeVariable,6,7);
DayVariable=extractBetween(DateTimeVariable,9,10);
HourVariable=extractBetween(DateTimeVariable,12,13);
MinuteVariable=extractBetween(DateTimeVariable,15,16);
SecondVariable=extractBetween(DateTimeVariable,18,19);

%the loop below transforms the datetime from a file to matlab readable
for t=1:length(DateTimeVariable)
    DateVector(t,:)=[YearVariable(t),MonthVariable(t),DayVariable(t),HourVariable(t),MinuteVariable(t),SecondVariable(t)];
    
    DateNumber(t,:)=datenum(str2num(YearVariable{t}(:,:)),str2num(MonthVariable{t}(:,:)),str2num(DayVariable{t}(:,:)),str2num(HourVariable{t}(:,:)),str2num(MinuteVariable{t}(:,:)),str2num(SecondVariable{t}(:,:)));
    
    %FormattedDateTime(t,1)=datestr(DateVector(t,:),formatOut); %this one
    %didn't work
end

%matching datetime to glucose
Tempfile{:,i}=[GlucoseVariable,DateNumber];
end