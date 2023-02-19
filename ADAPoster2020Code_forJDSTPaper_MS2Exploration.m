%% Tidepool Data Viz for ADA 2020 Poster

%fixing SAPzinsulinvariable; got corrupted and was identical to HCL

%for i=1:99
%    zSAP100insulinnewfirstmonth(:,i)=zscore(SAP100Insulinfirstmonth(:,i));
%    disp(i)
%end

%That worked

%zSAPinsulinfirstmonth=zSAP100insulinnewfirstmonth;

%% Numbers for Lance

FORLANCESKEWNESSSAP=SkewnessSAP(SAPIndices)'
FORLANCESKEWNESSHCL=SkewnessHCLSAPIndices(SAPIndices)'
FORLANCE3ADIFFSAPNONT1DCR=(AUCSAPCR(SAPFullResolutionIndices)-mean(AUCNonDiaCR,2))'
FORLANCE3ADIFFHCLNONT1DCR=(AUCHCLCR(SAPFullResolutionIndices)-mean(AUCNonDiaCR,2))'

FORLANCE3ADIFFSAPNONT1DUR=(AUCSAPUR(SAPFullResolutionIndices)-mean(AUCNonDiaUR,2))'
FORLANCE3ADIFFHCLNONT1DUR=(AUCHCLUR(SAPFullResolutionIndices)-mean(AUCNonDiaUR,2))'

FORLANCECRCOHHCL=AUCHCLWCOHCR(SAPFullResolutionIndices)'
FORLANCECRCOHSAP=AUCSAPWCOHCR(SAPFullResolutionIndices)'
%% Sanity Check Rate variable
figure;
for i=141:150
    
subplot(2,10,i-140);
plot(zscore(HCL150insulinfirstmonth(:,i))); hold on;
plot(zscore(HCL150glucosefirstmonth(:,i)),'color','k');

%plot(zscore(SAP100Insulinfirstmonth(:,i)));hold on;
%plot(zscore(SAP100glucosefirstmonth(:,i)),'color','k');
%title(SAPIndices(i));
title(i);
disp(i)
ylim([-4 4]);
end


figure;
for i=1:50
    
subplot(2,25,i);
%plot(HCL150glucosefirstmonth(1:1440,i));
plot(SAP100glucwvltsforaveragingcirc(:,i));
%title(SAPIndices(i));
title(i);
disp(i)
end


figure;
plot(SAP100Insulinfirstmonth(:,SAPIndices(23)));



%toss out person 8. 
%find person 8 and look at basal schedule (has really high basal set and
%started setting some zero manual temps)
%basal changes within an hour <x% of time not looping formed different
%subgroups
%read in schedule basal variable--- right are you 90% close to your
%scheduld basal or are u fucking yourself with setting lots of temp basal
%How often does rate deviate from temp basal



%%
%Ben color map definition
Sm = -4:0.01:4;
smarrR = [(0.5:0.005:1) (1:-0.002:0.004) (0:0.005:1)];%{0.5+sin(Sm./1-3)./2;%(801:-1:1)./801;%(1.*Sm.^2+0.5.*Sm+0)./20+0.005; %0.5+sin(Sm./1.5-1.5)./2;
smarrG = [zeros(1,550) (0:0.004:1)]; %(3.^Sm)./81;%1./(1+2.^-Sm);
smarrB = [zeros(1,100) (0:0.0016:1) ones(1,75)];%(1.4.^Sm)./4;%(1:1:801)./801;
%hold on; %plot(smarrR,'r'); plot(smarrG,'g'); plot(smarrB,'b');
smarr = [smarrB' smarrG' smarrR'];
%Fig_bar = figure; colorbar = (1:0.1:100); imagesc(colorbar);colormap(smarr);
%set(gca,'XTick',[],'YTick',[]);
%print(Fig_bar,'-djpeg','-r600','Color_bar');

%SAP Indices 
SAPIndices=[3:49,51:58,61:69,71:75,77:82,84:86,88:90,92:99];
SAPGlucoseIndices=[1:14,16:19,21,22,24:35,36:45,47:67,69:71,83:98];
SAPInsulinIndices=[1,4:6,8:49,51:58,61:69,71:75,78:82,84:86,89:90,91:99];
SAPGlucoseInsulinIndices=[1,4:6,8:14,16:19,21,22,24:35,36:45,47,48,51:58,61:67,69,71:75,78:82,84:86,89:90,91:99];
SAPFullResolutionIndices=[3,4,6,11,16:20,21,22,24,25,27,28,33,34,36,37,39,40,43,45,49,51,53:55,61,66,67,74,78,79,80,81,85,89,90,92,94,95,96,98];
HCLFullResolutionIndices=[1:18,20:25,27:48,50:65,67:70,72:114,116:150];

%% Coherence Examples that didn't make it in. 
%% JUST baller. Exactly as we expect. Barely any circadian coherence, great 6-8 h coherence but with a quarter cycle lag of gluc ahead of ins

%just look at some of these for consistency.
wcoherence(PA50Array{3,2}(1:1440*118),PA50Array{4,2}(1:1440*118),minutes(1));
wcoherence(HCL150Array{3,1}(1:1440*118),HCL150Array{4,1}(1:1440*118),minutes(1));
%sap100 has no insulin yet. wcoherence(SAP100Array{3,1}(1:1440*118),HCL150Array{4,1}(1:1440*118),minutes(1));

%% histograms bottom left
%how to choose what to uncomment in order to run this loop
%this top loop created the variables for these histograms. This won't run
%because I don't have the whole giant cell array files read in, but it
%gives a sense of how I created the histogram data (saved in this data
%file) 
%figure;
%for a=101:116%3:100
%recorduration=length(HCL150Array{3,a}(:,:));
%subplot(2,5,a-110);
%histogram(SAP100Array{3,a}(:,:)./recorduration,'BinWidth',0.5,'FaceColor',[0.0 0.5 0]); hold on;
%NonDiabeticHistosGlucose(:,a)=hist(NonDiabeticCellArray{2,a}(:,:),[1:0.5:25]);%,'BinWidth',0.5,'FaceColor',[0.0 0.4 0.6]); hold on;
%NonDiabeticHistosGlucose(:,a)=NonDiabeticHistosGlucose(:,a)./sum(NonDiabeticHistosGlucose(:,a));
%HCLHistosGlucose(:,a)=hist(HCL150Array{3,a}(:,:),[1:0.5:25]);%,'BinWidth',0.5,'FaceColor',[0.0 0.4 0.6]); hold on;
%HCLHistosGlucose(:,a)=HCLHistosGlucose(:,a)./sum(HCLHistosGlucose(:,a));

%SAPHistosGlucose(:,a)=hist(SAP100Array{3,a}(:,:),[1:0.5:25]);%,'BinWidth',0.5,'FaceColor',[0.0 0.4 0.6]); hold on;
%SAPHistosGlucose(:,a)=SAPHistosGlucose(:,a)./sum(SAPHistosGlucose(:,a));

%Change Bin Size and Use Diff for Insulin??

%SAPHistosInsulin(:,a)=hist(diff(SAP100Array{4,a}(:,:)),[1:0.05:5]);%,'BinWidth',0.5,'FaceColor',[0.0 0.4 0.6]); hold on;
%SAPHistosInsulin(:,a)=SAPHistosInsulin(:,a)./sum(SAPHistosInsulin(:,a));
%HCLHistosInsulin(:,a)=hist(HCL150Array{4,a}(:,:),[1:0.5:25]);%,'BinWidth',0.5,'FaceColor',[0.0 0.4 0.6]); hold on;
%HCLHistosInsulin(:,a)=HCLHistosInsulin(:,a)./sum(HCLHistosInsulin(:,a));


%hold on; %set(gca,'xlim',[0 25]);%,'ylim',[ 0 3e5]);
%title('All Non Diabetic Individuals');
%disp(a)
%end


% Old Alternate version in blue and green
% SapandHCLHisto=figure;
% for d=3:100
%    bar([1:0.5:25],HCLHistosGlucose(:,d),'FaceColor',[0.0 0.4 0.6],'EdgeAlpha',0.05); alpha(0.05);hold on;
%     bar([1:0.5:25],SAPHistosGlucose(:,d),'FaceColor',[0.0 0.5 0.0],'EdgeAlpha',0.05); alpha(0.05);hold on;
%     disp(d);
% end
%print(SapandHCLHisto,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDST Grant 2018\JDST Paper Figures Based on ADA 2020 Poster\SAP and HCL Histo Blue and Green Version'); % If you want to save this figure at hires to your computer


% Old Alternate version in blue and yellow
% SapandHCLHisto=figure;
% for d=3:100
%    bar([1:0.5:25],HCLHistosGlucose(:,d),'FaceColor',[0.0 0.8 0.6],'EdgeAlpha',0.05); alpha(0.05);hold on;
%     bar([1:0.5:25],SAPHistosGlucose(:,d),'FaceColor',[0.5 0.5 0.0],'EdgeAlpha',0.05); alpha(0.05);hold on;
%     disp(d);
% end
%print(SapandHCLHisto,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDST Grant 2018\JDST Paper Figures Based on ADA 2020 Poster\SAP and HCL Histo Blue and Yellow Version'); % If you want to save this figure at hires to your computer

%blue and pink

%making outlines (the variables bellow are commented out -- they define the
%median and max outlines blotted in the histogram figure


%median outline definitions
%medianoutlineSAP=nanmedian(SAPHistosGlucose,2);
%medianoutlineHCL=nanmedian(HCLHistosGlucose,2);
%medianoutlineNonDia=nanmedian(NonDiabeticHistosGlucose(:,101:116),2);

%max outline
%maxoutlineSAP=max(SAPHistosGlucose,[],2);
%maxoutlineHCL=max(HCLHistosGlucose,[],2);
%maxoutlineNonDia=max(NonDiabeticHistosGlucose(:,101:116),[],2);

%median outline insulin
%medianoutlineSAPInsulin=nanmedian(SAPHistosInsulin,2);
%medianoutlineHCLInsulin=nanmedian(HCLHistosInsulin,2);

%max outline insulin
%maxoutlineSAPInsulin=max(SAPHistosInsulin,[],2);
%maxoutlineHCLInsulin=max(HCLHistosInsulin,[],2);


%Bottom Right Figure   Discussing currently what stats mightbe good. A KS
%test is a place to start (common in spike train dist differentiation).
%Skewness test may work better

%more notes on figure improvement ideas: could add a zoom of the right tail
%ofr bottom left figure A) (10-25), could add small individual panel of HCL
%and SAP dist separately in corner of A)

%Glucose Median Outline 
GlucoseMedianOutlineHCLSAPNonT1D=figure; hold on;plot([1:0.5:25],medianoutlineHCL,'color',[0.0 0.4 1],'LineWidth',5);
plot([1:0.5:25],medianoutlineSAP,'color',[0.8 0 0.0],'LineWidth',5);
plot([1:0.5:25],medianoutlineNonDia,'color',[0.0 0.7 0.0],'LineWidth',5);
ylim([0 0.45]);
print(GlucoseMedianOutlineHCLSAPNonT1D,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\GlucoseMedianOutlines'); % If you want to save this figure at hires to your computer

%Max outines
GlucoseMaxOutlineHCLSAPNonT1D=figure; hold on;
plot([1:0.5:25],maxoutlineHCL,'color',[0.0 0.4 1],'LineWidth',3);
plot([1:0.5:25],maxoutlineSAP,'color',[1 0 0.0],'LineWidth',3);
plot([1:0.5:25],maxoutlineNonDia,'color',[0.0 0.7 0.0],'LineWidth',3);


% %Insulin Median Outline
% figure; hold on;plot([1:0.5:25],medianoutlineHCLInsulin,'color',[0.0 0.4 0.6],'LineWidth',5);
% plot([1:0.5:25],medianoutlineSAPInsulin,'color',[0.8 0 0.0],'LineWidth',5);
% plot([1:0.05:5],medianoutlineSAPInsulin,'color',[0.8 0 0.0],'LineWidth',5);

%% Glucose Histogram Figure and Stats
HCLSAPHisto=figure;  %notes about person 68
for d=SAPGlucoseIndices;
   bar([1:0.5:25],HCLHistosGlucose(:,d),'FaceColor',[0.0 0.4 1],'EdgeAlpha',0.05); alpha(0.05);hold on;
    bar([1:0.5:25],SAPHistosGlucose(:,d),'FaceColor',[0.8 0 0.0],'EdgeAlpha',0.05); alpha(0.05);hold on;
    disp(d);
end
ylim([0 0.45]);
print(HCLSAPHisto,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\HCLSAPHisto_SAPGlucoseIndices_100620'); % If you want to save this figure at hires to your computer


%Bottom Left Figure B)
NonT1DHisto=figure;
for d=101:116
   bar([1:0.5:25],NonDiabeticHistosGlucose(:,d),'FaceColor',[0.0 0.5 0.0],'EdgeAlpha',0.05); alpha(0.05);hold on;
    disp(d);
end
print(NonT1DHisto,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\NonT1DHisto'); % If you want to save this figure at hires to your computer


%max is cool but median is better
%hold on;plot([1:0.5:25],maxoutlineHCL,'color',[0.0 0.4 0.6],'LineWidth',2);
%plot([1:0.5:25],maxoutlineSAP,'color',[0.8 0 0.0],'LineWidth',2);
%max outline

%Version 1 Printing all Histos Over one Another
Threepanelhisto=figure;

subplot(1,3,1);
for d=SAPGlucoseIndices;
   bar([1:0.5:25],HCLHistosGlucose(:,d),'FaceColor',[0.0 0.4 1],'EdgeAlpha',0.05); alpha(0.05);hold on;
    bar([1:0.5:25],SAPHistosGlucose(:,d),'FaceColor',[0.8 0 0.0],'EdgeAlpha',0.05); alpha(0.05);hold on;
    disp(d);
end
ylim([0 0.45]);

subplot(1,3,2);
for d=101:116
   bar([1:0.5:25],NonDiabeticHistosGlucose(:,d),'FaceColor',[0.0 0.5 0.0],'EdgeAlpha',0.05); alpha(0.05);hold on;
    disp(d);
end
ylim([0 0.45]);

subplot(1,3,3); hold on;plot([1:0.5:25],medianoutlineHCL,'color',[0.0 0.4 1],'LineWidth',5);
plot([1:0.5:25],medianoutlineSAP,'color',[0.8 0 0.0],'LineWidth',5);
plot([1:0.5:25],medianoutlineNonDia,'color',[0.0 0.7 0.0],'LineWidth',5);
ylim([0 0.45]);
print(Threepanelhisto,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\3panelhisto_SAPGlucoseIndices'); % If you want to save this figure at hires to your computer



%stats idea--- one could get an idea of skew for each person and then
%compare skew by groups with a ttest, ranksum whatever...
%test for skewness function
askewnesstest=skewness(medianoutlineHCL) %skewness of HCL is 1.29
askewnesstest2=skewness(medianoutlineNonDia) %skew of Non T1D is 3.5
askewnesstest3=skewness(medianoutlineSAP) % skewness of SAP is 0.9033

%I need to make a vector of each individual's median skewness. Then I can
%compare those. 

%define vectors where every individual gets one skewness metric
for i=SAPGlucoseIndices
SkewnessSAP(1,i)=skewness(SAPHistosGlucose(:,i));
SkewnessHCLSAPIndices(1,i)=skewness(HCLHistosGlucose(:,i));
disp(i)
end;

for i=1:150
   SkewnessHCL150(1,i)=skewness(HCLHistosGlucose(:,i));
   disp(i)
end

[pskewness,tblskewness,statsskewness]=kruskalwallis([SkewnessHCLSAPIndices', SkewnessSAP']); % p =0.0002 chisq=13.47, df 186, ms 36487.04
[h,p,ci,stats]=ttest(SkewnessHCLSAPIndices,SkewnessSAP); %p=0.002 t=3.19 df=89 sd = 0.90

%% Bingo HCL and SAP Correlation of URs in Glucose and INsulin, and of Raw or ZScored Glucose and Insulin %Scatter Plots for bottom middle

%BINGO Ultradian power of glucose vs. insulin for HCL and for SAP. Can't do for non-diabetes because we have no insulin
%stats idea: send for HCL  2 col vector of gluc wvlt and insulin
figure; 
for i=SAPIndices
 s=scatter(HCLglucwvltsforaveraging1to2(1:10:4300,i),HCLInsulinwvltsforaveraging1to2(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging1to2(1:10:4300,i),SAP100Insulinwvltsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
title('HCL Glucose UR Power: Insulin UR Power')
disp(i)
end
ylim([0.01 2]); xlim([0.01 2]);

%correlation of zscored glucose and zscored insulin showing positive correlation
figure; 
for i=SAPIndices
s=scatter(zHCL150glucosefirstmonth(1:100:43000,i),zHCL150insulinfirstmonth(1:100:43000,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.1;
s.MarkerEdgeAlpha=0.1;
%t=scatter(zSAP100glucosefirstmonth(1:100:43000,i),zSAP100insulinfirstmonth(1:100:43000,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.1;
%t.MarkerEdgeAlpha=0.1;
%title('')
disp(i)
end
ylim([-4 5]); xlim([-4 5]);

% PLOT ALL 6 At Once as a Panel. 

ScattersGlucLevelRhythm=figure; 
for i=SAPFullResolutionIndices
subplot(2,3,1)    
t=scatter(zSAP100glucosefirstmonth(1:100:43000,i),zNEWSAP100insulinfirstmonth(1:100:43000,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.1;
t.MarkerEdgeAlpha=0.1;
ylim([-4 5]); xlim([-4 5]); 

subplot(2,3,2)    
s=scatter(zHCL150glucosefirstmonth(1:100:43000,i),zHCL150insulinfirstmonth(1:100:43000,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.1;
s.MarkerEdgeAlpha=0.1; 
ylim([-4 5]); xlim([-4 5]);

subplot(2,3,3);
s=scatter(zHCL150glucosefirstmonth(1:100:43000,i),zHCL150insulinfirstmonth(1:100:43000,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.1;
s.MarkerEdgeAlpha=0.1;
t=scatter(zSAP100glucosefirstmonth(1:100:43000,i),zNEWSAP100insulinfirstmonth(1:100:43000,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.1;
t.MarkerEdgeAlpha=0.1;
ylim([-4 5]); xlim([-4 5]);

subplot(2,3,4);
t=scatter(SAP100glucwvltsforaveraging2to3(1:10:4300,i),SAP100Insulinwvltsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
subplot(2,3,5)
 s=scatter(HCLglucwvltsforaveraging2to3(1:10:4300,i),HCLInsulinwvltsforaveraging1to2(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
 ylim([0.01 2]); xlim([0.01 2]);
%title('HCL Glucose UR Power: Insulin UR Power')
subplot(2,3,6)
t=scatter(SAP100glucwvltsforaveraging2to3(1:10:4300,i),SAP100Insulinwvltsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
 s=scatter(HCLglucwvltsforaveraging2to3(1:10:4300,i),HCLInsulinwvltsforaveraging1to2(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
 ylim([0.01 2]); xlim([0.01 2]);

disp(i)
end
print(ScattersGlucLevelRhythm,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\ScattersGlucLevelRhythm_SAPFullResolutionIndices'); % If you want to save this figure at hires to your computer



% Stats Linear Correlation

%HCL zlinear
x=reshape(zHCL150glucosefirstmonth(1:1440:41760,:),[29*150,1]);
y=reshape(zHCL150insulinfirstmonth(1:1440:41760,:),[29*150,1]);
mdl=fitlm(x,y);

% %mdl results z HCL raw values

% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                          Estimate                   SE                    tStat                   pValue       
%                    ____________________    ____________________    ____________________    ____________________
% 
%     (Intercept)    1.93408984419260e-02    1.61658132165368e-02    1.19640739274045e+00    2.31602851954724e-01
%     x1             1.21017910288459e-01    1.49577609512315e-02    8.09064342470956e+00    7.63097279569741e-16
% 
% 
% Number of observations: 4350, Error degrees of freedom: 4348
% Root Mean Squared Error: 1.06
% R-squared: 0.0148,  Adjusted R-Squared: 0.0146
% F-statistic vs. constant model: 65.5, p-value = 7.63e-16

[R,P,RL,RU] = corrcoef(x,y) 



%SAP zlinear
x=reshape(zSAP100glucosefirstmonth(1:1440:41760,:),[29*99,1]);
 y=reshape(zSAP100insulinfirstmonth(1:1440:41760,:),[29*99,1]);
 mdl=fitlm(x,y);
 
 % mdl results for z SAP raw values. Looks good; HCL is significant, SAP is
% not
% Estimated Coefficients:
%                          Estimate                    SE                     tStat                   pValue       
%                    _____________________    ____________________    _____________________    ____________________
% 
%     (Intercept)     1.69217387651825e-02    2.54044619613347e-02     6.66093176503293e-01    5.05405098713072e-01
%     x1             -2.40406653077965e-02    2.52666781060386e-02    -9.51477088001170e-01    3.41442391821376e-01
% 
% 
% Number of observations: 2871, Error degrees of freedom: 2869
% Root Mean Squared Error: 1.36
% R-squared: 0.000315,  Adjusted R-Squared: -3.3e-05
% F-statistic vs. constant model: 0.905, p-value = 0.341
 
 %HCL URs %downsampling to decrease pseudoreplication. days treated as
 %independent. Sampling once every 1440 data points for 1 week for all
 %people
 x=reshape(HCLglucwvltsforaveraging1to2(1:1440:11520,:),[8*150,1]);
 y=reshape(HCLInsulinwvltsforaveraging1to2(1:1440:11520,:),[8*150,1]);
 mdl=fitlm(x,y);
 
% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                          Estimate                   SE                    tStat                   pValue       
%                    ____________________    ____________________    ____________________    ____________________
% 
%     (Intercept)    2.84920982872523e-01    1.28011901664815e-02    2.22573822564215e+01    3.96905988821465e-92
%     x1             2.61814980742957e-01    1.96093576525460e-02    1.33515327417654e+01    5.21718004390572e-38
% 
% 
% Number of observations: 1200, Error degrees of freedom: 1198
% Root Mean Squared Error: 0.205
% R-squared: 0.13,  Adjusted R-Squared: 0.129
% F-statistic vs. constant model: 178, p-value = 5.22e-38



 
 %SAP URs %downsampling to decrease pseudoreplication. days treated as
 %independent. Sampling once every 1440 data points for 1 week for all
 %people
 
 x=reshape(SAP100glucwvltsforaveraging1to2(1:1440:11520,:),[8*99,1]);
 y=reshape(SAP100Insulinwvltsforaveraging1to2(1:1440:11520,:),[8*99,1]);
 mdl=fitlm(x,y);
 

%  Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                          Estimate                   SE                    tStat                   pValue       
%                    ____________________    ____________________    ____________________    ____________________
% 
%     (Intercept)    3.37948586007964e-01    1.60374742097222e-02    2.10724320793042e+01    1.44742066903186e-78
%     x1             2.64480161596132e-02    1.90445743768330e-02    1.38874283227806e+00    1.65302354766540e-01
% 
% 
% Number of observations: 792, Error degrees of freedom: 790
% Root Mean Squared Error: 0.309
% R-squared: 0.00244,  Adjusted R-Squared: 0.00117
% F-statistic vs. constant model: 1.93, p-value = 0.165

%% Adding Stats for 2 to 3 Periodicity
 x=reshape(HCLglucwvltsforaveraging2to3(1:1440:11520,:),[8*150,1]);
 y=reshape(HCLInsulinwvltsforaveraging2to3(1:1440:11520,:),[8*150,1]);
 mdl=fitlm(x,y);
 
% Estimated Coefficients:
%                   Estimate       SE       tStat       pValue  
%                   ________    ________    ______    __________%%
%
%    (Intercept)    0.23958     0.011566    20.714    1.0406e-81
%    x1             0.23705     0.016263    14.576    1.9963e-44


%Number of observations: 1200, Error degrees of freedom: 1198
%Root Mean Squared Error: 0.169
%R-squared: 0.151,  Adjusted R-Squared: 0.15
%F-statistic vs. constant model: 212, p-value = 2e-44

 
 x=reshape(SAP100glucwvltsforaveraging2to3(1:1440:11520,:),[8*99,1]);
 y=reshape(SAP100Insulinwvltsforaveraging2to3(1:1440:11520,:),[8*99,1]);
 mdl=fitlm(x,y);
 
% Estimated Coefficients:
%                   Estimate       SE       tStat       pValue  
%                   ________    ________    ______    __________%
%
%    (Intercept)    0.40406     0.018519    21.819    5.6982e-83
%    x1              0.1378      0.01985    6.9421     8.065e-12


%Number of observations: 792, Error degrees of freedom: 790
%Root Mean Squared Error: 0.349
%R-squared: 0.0575,  Adjusted R-Squared: 0.0563

%Using SAP Full Res Indices

 x=reshape(HCLglucwvltsforaveraging2to3(1:1440:11520,SAPFullResolutionIndices),[8*44,1]);
 y=reshape(HCLInsulinwvltsforaveraging2to3(1:1440:11520,SAPFullResolutionIndices),[8*44,1]);
 mdl=fitlm(x,y);
 
%Estimated Coefficients:
%                   Estimate       SE       tStat       pValue  
%                   ________    ________    ______    __________

%    (Intercept)     0.3198     0.019738    16.202    1.8962e-44
%    x1              0.1215     0.027543    4.4113    1.3697e-05


%Number of observations: 352, Error degrees of freedom: 350
%Root Mean Squared Error: 0.15
%R-squared: 0.0527,  Adjusted R-Squared: 0.05
%F-statistic vs. constant model: 19.5, p-value = 1.37e-05
 

 x=reshape(SAP100glucwvltsforaveraging2to3(1:1440:11520,SAPFullResolutionIndices),[8*44,1]);
 y=reshape(SAP100Insulinwvltsforaveraging2to3(1:1440:11520,SAPFullResolutionIndices),[8*44,1]);
 mdl=fitlm(x,y);
 
% Estimated Coefficients:
%                   Estimate        SE        tStat        pValue  
                   
%    (Intercept)      0.61856    0.054556      11.338    1.3665e-25
%    x1             -0.028126    0.042202    -0.66647       0.50555


%Number of observations: 352, Error degrees of freedom: 350
%Root Mean Squared Error: 0.342
%R-squared: 0.00127,  Adjusted R-Squared: -0.00159

%F-statistic vs. constant model: 0.444, p-value = 0.506

 
%% Supplemental Scatters at different periodicities

%what about longer timescales to match the coherence assessment?
SuppFigURScattersbyPeriod=figure; 
for i=SAPFullResolutionIndices
    subplot(2,3,1)
 s=scatter(HCLglucwvltsforaveraging1to2(1:20:4300,i),HCLInsulinwvltsforaveraging1to2(1:20:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging1to2(1:10:4300,i),SAP100Insulinwvltsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
title('1 to 2 h')

 subplot(2,3,2)
 s=scatter(HCLglucwvltsforaveraging2to3(1:20:4300,i),HCLInsulinwvltsforaveraging2to3(1:20:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging2to3(1:10:4300,i),SAP100Insulinwvltsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
title('2 to 3 h')

 subplot(2,3,3)
 s=scatter(HCLglucwvltsforaveraging3to4(1:20:4300,i),HCLInsulinwvltsforaveraging3to4(1:20:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging3to4(1:10:4300,i),SAP100Insulinwvltsforaveraging3to4(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
title('3 to 4 h')


 subplot(2,3,4)
 %s=scatter(HCLglucwvltsforaveraging5to6(1:20:4300,i),HCLInsulinwvltsforaveraging5to6(1:20:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 %s.MarkerFaceAlpha=0.07;
 %s.MarkerEdgeAlpha=0.07;
  s=scatter(HCLglucwvltsforaveraging6to7(1:10:4300,i),HCLInsulinwvltsforaveraging6to7(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging5to6(1:20:4300,i),SAP100Insulinwvltsforaveraging5to6(1:20:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
u=scatter(SAP100glucwvltsforaveraging6to7(1:20:4300,i),SAP100Insulinwvltsforaveraging6to7(1:20:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;

t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
u.MarkerFaceAlpha=0.07;
u.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
title('5 to 7 h')

 subplot(2,3,5)
 s=scatter(HCLglucwvltsforaveragingcirc(1:20:4300,i),HCLInsulinwvltsforaveragingcirc(1:20:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveragingcirc(1:10:4300,i),SAP100Insulinwvltsforaveragingcirc(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
title('circadian')

disp(i)
end
ylim([0.01 2]); xlim([0.01 2]);

for i=SAPFullResolutionIndices
subplot(2,3,6)
s=scatter(HCLglucwvltsforaveraging1to2(1:10:4200,i),HCLInsulinwvltsforaveraging1to2(1:10:4200,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging1to2(1:10:4200,i),SAP100Insulinwvltsforaveraging1to2(1:10:4200,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);

s=scatter(HCLglucwvltsforaveraging2to3(1:10:4200,i),HCLInsulinwvltsforaveraging2to3(1:10:4200,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging2to3(1:10:4200,i),SAP100Insulinwvltsforaveraging2to3(1:10:4200,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);

s=scatter(HCLglucwvltsforaveraging3to4(1:10:4200,i),HCLInsulinwvltsforaveraging3to4(1:10:4200,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging3to4(1:10:4200,i),SAP100Insulinwvltsforaveraging3to4(1:10:4200,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);

s=scatter(HCLglucwvltsforaveraging6to7(1:10:4200,i),HCLInsulinwvltsforaveraging6to7(1:10:4200,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveraging5to6(1:20:4200,i),SAP100Insulinwvltsforaveraging5to6(1:20:4200,i),10,[0.8 0.0 0.0],'filled'); hold on;
u=scatter(SAP100glucwvltsforaveraging6to7(1:20:4200,i),SAP100Insulinwvltsforaveraging6to7(1:20:4200,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
u.MarkerFaceAlpha=0.07;u.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);  

s=scatter(HCLglucwvltsforaveragingcirc(1:10:4200,i),HCLInsulinwvltsforaveragingcirc(1:10:4200,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;
s.MarkerEdgeAlpha=0.07;
t=scatter(SAP100glucwvltsforaveragingcirc(1:10:4200,i),SAP100Insulinwvltsforaveragingcirc(1:10:4200,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
disp(i)

end


print(SuppFigURScattersbyPeriod,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\SuppFigURScattersbyPeriod_SAPFullResolution_100620'); % If you want to save this figure at hires to your computer

%STAT FOR OVERLAY OF ALL PERIODS

 x1=reshape(SAP100glucwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y1=reshape(SAP100Insulinwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 x2=reshape(SAP100glucwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y2=reshape(SAP100Insulinwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 x3=reshape(SAP100glucwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y3=reshape(SAP100Insulinwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]); 
 x4=reshape(SAP100glucwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y4=reshape(SAP100Insulinwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]); 
 x5=reshape(SAP100glucwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y5=reshape(SAP100Insulinwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]); 

 xallperiodsSAP=[x1; x2; x3; x4; x5];
 yallperiodsSAP=[y1; y2; y3; y4; y5];
 mdl=fitlm(xallperiodsSAP(1:5:end),yallperiodsSAP(1:5:end));
 
%Estimated Coefficients:
%                   Estimate       SE       tStat       pValue  
%                   ________    ________    ______    __________%%
%
%    (Intercept)    0.18841     0.020058    9.3932    3.4842e-20
%    x1             0.22123     0.019807    11.169    1.8731e-27
%Number of observations: 1056, Error degrees of freedom: 1054
%Root Mean Squared Error: 0.337
%R-squared: 0.106,  Adjusted R-Squared: 0.105
%F-statistic vs. constant model: 125, p-value = 1.87e-27

% 
 
  x1=reshape(HCLglucwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y1=reshape(HCLInsulinwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 x2=reshape(HCLglucwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y2=reshape(HCLInsulinwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 x3=reshape(HCLglucwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y3=reshape(HCLInsulinwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]); 
 x4=reshape(HCLglucwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y4=reshape(HCLInsulinwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]); 
 x5=reshape(HCLglucwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 y5=reshape(HCLInsulinwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]); 

 xallperiodsHCL=[x1; x2; x3; x4; x5];
 yallperiodsHCL=[y1; y2; y3; y4; y5];
 mdl=fitlm(xallperiodsHCL(1:5:end),yallperiodsHCL(1:5:end));
 
%Estimated Coefficients:
%                   Estimate       SE        tStat       pValue  
%                   ________    _________    ______    __________
%
%    (Intercept)     0.1217     0.0094216    12.917    1.5382e-35
%    x1             0.34851       0.01745    19.972    1.6397e-75
%
%
%Number of observations: 1056, Error degrees of freedom: 1054
%Root Mean Squared Error: 0.166
%R-squared: 0.275,  Adjusted R-Squared: 0.274
%F-statistic vs. constant model: 399, p-value = 1.64e-75


 

 %% Fixing WCOH 5 to 9
 %Meanwcoh5to9fixed=Meanwcoh5to9;
 %Meanwcoh5to9fixed(1440*23:1440*25)=Meanwcoh5to9(1440*16:1440*18);
 %Stdevwcoh5to9fixed=Stdevwcoh5to9;
 %Stdevwcoh5to9fixed(1440*23:1440*25)=Stdevwcoh5to9(1440*16:1440*18);

%% Supplemental Coherences Test on all bands -- potentially for a supplemetn
SupplementalCoherences=figure;
%SAP
subplot(2,3,1); plot(movmean(SAPMeanwcoh1to2,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh1to2SAP);
a=fill([x fliplr(x)],[(Stdevwcoh1to2SAP+SAPMeanwcoh1to2)' flipud(SAPMeanwcoh1to2-Stdevwcoh1to2SAP)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%need to remake 1 to h variable for 1 to 2
%HCL
plot(movmean(HCLMeanwcoh1to2,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh1to2HCL);
a=fill([x fliplr(x)],[(Stdevwcoh1to2HCL+HCLMeanwcoh1to2)' flipud(HCLMeanwcoh1to2-Stdevwcoh1to2HCL)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');

title('1 to 2 h');xlabel('Days');ylabel('1 to 2 h Ultradian Coherence'); %title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);


subplot(2,3,2); plot(movmean(SAPMeanwcoh2to3,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh2to3SAP);
a=fill([x fliplr(x)],[(Stdevwcoh2to3SAP+SAPMeanwcoh2to3)' flipud(SAPMeanwcoh2to3-Stdevwcoh2to3SAP)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%need to remake 1 to h variable for 1 to 2
%HCL

plot(movmean(HCLMeanwcoh2to3,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh2to3HCL);
a=fill([x fliplr(x)],[(Stdevwcoh2to3HCL+HCLMeanwcoh2to3)' flipud(HCLMeanwcoh2to3-Stdevwcoh2to3HCL)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
title('2 to 3 h');
xlabel('Days');ylabel('2 to 3 Ultradian Coherence');% title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);


subplot(2,3,3); plot(movmean(SAPMeanwcoh3to4,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh3to4SAP);
a=fill([x fliplr(x)],[(Stdevwcoh3to4SAP+SAPMeanwcoh3to4)' flipud(SAPMeanwcoh3to4-Stdevwcoh3to4SAP)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%HCL
plot(movmean(HCLMeanwcoh3to4,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh3to4HCL);
a=fill([x fliplr(x)],[(Stdevwcoh3to4HCL+HCLMeanwcoh3to4)' flipud(HCLMeanwcoh3to4-Stdevwcoh3to4HCL)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
title('3 to 4');
xlabel('Days');ylabel('3 to 4 h Ultradian Coherence'); %title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);



subplot(2,3,4);  plot(movmean(SAPMeanwcoh4to5,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh4to5SAP);
a=fill([x fliplr(x)],[(Stdevwcoh4to5SAP+SAPMeanwcoh4to5)' flipud(SAPMeanwcoh4to5-Stdevwcoh4to5SAP)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%HCL
plot(movmean(HCLMeanwcoh4to5,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh4to5HCL);
a=fill([x fliplr(x)],[(Stdevwcoh4to5HCL+HCLMeanwcoh4to5)' flipud(HCLMeanwcoh4to5-Stdevwcoh4to5HCL)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
title('4 to 5');
xlabel('Days');ylabel('4 to 5 h Ultradian Coherence'); %title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);


subplot(2,3,5); plot(movmean(SAPMeanwcoh5to9,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh5to9SAP);
a=fill([x fliplr(x)],[(Stdevwcoh5to9SAP+SAPMeanwcoh5to9)' flipud(SAPMeanwcoh5to9-Stdevwcoh5to9SAP)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%need to remake 1 to h variable for 1 to 2
%HCL
plot(movmean(HCLMeanwcoh5to9,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh5to9HCL);
a=fill([x fliplr(x)],[(Stdevwcoh5to9HCL+HCLMeanwcoh5to9)' flipud(HCLMeanwcoh5to9-Stdevwcoh5to9HCL)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
title('5 to 9');
xlabel('Days');ylabel('5 to 9 h Ultradian Coherence');% title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);



subplot(2,3,6);
plot(movmean(SAPMeanwcohcirc,1440),':','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdevwcohcircSAP);
a=fill([x fliplr(x)],[(StdevwcohcircSAP+SAPMeanwcohcirc)' flipud(SAPMeanwcohcirc-StdevwcohcircSAP)'],[0.1 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%need to remake 1 to h variable for 1 to 2
%HCL
plot(movmean(HCLMeanwcohcirc,1440),'color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdevwcohcircHCL);
a=fill([x fliplr(x)],[(StdevwcohcircHCL+HCLMeanwcohcirc)' flipud(HCLMeanwcohcirc-StdevwcohcircHCL)'],[0.1 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
title('circadian');
xlabel('Days');ylabel('Circadian Coherence'); %title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);

print(SupplementalCoherences,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\SupplementalCoherences'); % If you want to save this figure at hires to your computer

%% HCL Coherence of CRs and URs is Higher than SAP Coherence!! Average CR and UR Bands ACROSS HCL and SAP 5 to 9 Hour Band
Coherenceexamplefig=figure;
%SAP
plot(movmean(Meanwcoh5to9fixed,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh5to9fixed);
a=fill([x fliplr(x)],[(Stdevwcoh5o9fixed+Meanwcoh5to9fixed)' flipud(Meanwcoh5to9fixed-Stdevwcoh5to9fixed)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%HCL
plot(movmean(HCLMeanwcoh5to9,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(HCLStdevwcoh5to9);
a=fill([x fliplr(x)],[(HCLStdevwcoh5to9+HCLMeanwcoh5to9)' flipud(HCLMeanwcoh5to9-HCLStdevwcoh5to9)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');



%SAP
plot(Meanwcohcirc,':','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(Stdevwcohcirc);
a=fill([x fliplr(x)],[(Stdevwcohcirc+Meanwcohcirc)' flipud(Meanwcohcirc-Stdevwcohcirc)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

%HCL
plot(HCLMeanwcohcirc,'color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(HCLStdevwcohcirc);
a=fill([x fliplr(x)],[(HCLStdevwcohcirc+HCLMeanwcohcirc)' flipud(HCLMeanwcohcirc-HCLStdevwcohcirc)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

xlabel('Days');ylabel('Circadian and Ultradian Coherence'); title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);

%% HCL Coherence vs SAP CR and 2 to 3 h UR w Fixed Variables

Coherenceexamplefig=figure;
%SAP
plot(movmean(Meanwcoh2to3SAP,1440),':','color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh2to3SAP);
a=fill([x fliplr(x)],[(Stdevwcoh2to3SAP+Meanwcoh2to3SAP)' flipud(Meanwcoh2to3SAP-Stdevwcoh2to3SAP)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');
ylim([0 0.55]);

%HCL
plot(movmean(HCLMeanwcoh2to3,1440),'color',[0.5 0 0],'LineWidth',4);
hold on; 
x=1:length(Stdevwcoh2to3HCL);
a=fill([x fliplr(x)],[(Stdevwcoh2to3HCL+HCLMeanwcoh2to3)' flipud(HCLMeanwcoh2to3-Stdevwcoh2to3HCL)'],[0.5 0 0.5]); alpha(0.025); set(a,'EdgeColor','none');

%SAP

plot(MeanwcohcircSAPtest,':','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdevwcohcircSAPtest);
a=fill([x fliplr(x)],[(StdevwcohcircSAPtest+MeanwcohcircSAPtest)' flipud(MeanwcohcircSAPtest-StdevwcohcircSAPtest)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

%HCL
plot(HCLMeanwcohcirctest,'color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdevwcohcircHCLtest);
a=fill([x fliplr(x)],[(StdevwcohcircHCLtest+HCLMeanwcohcirctest)' flipud(HCLMeanwcohcirctest-StdevwcohcircHCLtest)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

xlabel('Days');ylabel('Circadian and Ultradian Coherence');% title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);
print(Coherenceexamplefig,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\CoherencebygroupCRS_100620'); % If you want to save this figure at hires to your computer


%% Circadian COherence Figure 3 Using FullResolution Indices Only
MeanwcohcircSAPFullResolutionIndices=mean(SAPwcohsforaveragingcirc(:,SAPFullResolutionIndices),2);
StdevwcohcircSAPFullResolutionIndices=mean(movstd(SAPwcohsforaveragingcirc(:,SAPFullResolutionIndices),1440),2);

circcohfullres=figure;
%SAP

plot(MeanwcohcircSAPFullResolutionIndices,':','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(MeanwcohcircSAPFullResolutionIndices);
a=fill([x fliplr(x)],[(StdevwcohcircSAPFullResolutionIndices+MeanwcohcircSAPFullResolutionIndices)' flipud(MeanwcohcircSAPFullResolutionIndices-StdevwcohcircSAPFullResolutionIndices)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

%HCL
plot(HCLMeanwcohcirctest,'color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdevwcohcircHCLtest);
a=fill([x fliplr(x)],[(StdevwcohcircHCLtest+HCLMeanwcohcirctest)' flipud(HCLMeanwcohcirctest-StdevwcohcircHCLtest)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

xlabel('Days');ylabel('Circadian and Ultradian Coherence');% title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);
print(circcohfullres,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\CoherencebygroupCRS_100620_SAPFullResIndicesOnly'); % If you want to save this figure at hires to your computer



%% STATs for Individual Coherences
%stats idea to send for lance  send auc values defined below. also in
%figure instead of stars indicating that all groups are different from one
%another maybe add vertical lines at side of figure specifying wall groups
%are different
for a=SAPFullResolutionIndices% previously; stuffiwant
    AUCSAPWCOHUR(a)=trapz(SAPwcohsforaveraging5to9(1:1440:end,a)');
    AUCSAPWCOHCR(a)=trapz(SAPwcohsforaveragingcirc(1:1440:end,a));
    AUCHCLWCOHUR(a)=trapz(HCLwcohsforaveraging5to9(1:1440:end,a));
    AUCHCLWCOHCR(a)=trapz(HCLwcohsforaveragingcirc(1:1440:end,a));
   disp(a)
end

figure;
for c=stuffiwant
    plot(SAPwcohsforaveraging5to9(:,c),'color','k'); hold on;
    plot(HCLwcohsforaveraging5to9(:,c),'color','b'); hold on;
end
    
%for stuffiwant 5 to 9
%allidx=1:99; stuffidontwant=[1,2,15,20,35,38,50,51,55,59,60,68,70,71,72,76,77,83,87,91,99]; binarizewhatidontwant=ismember(allidx,stuffidontwant);stuffiwant=allidx(~binarizewhatidontwant);


[p,tbl,stats] =anova1([AUCSAPWCOHUR(SAPFullResolutionIndices);AUCHCLWCOHUR(SAPFullResolutionIndices)]'); %Previously stuffiwant as indices

% Source      SS      df      MS        F       Prob>F   
% -------------------------------------------------------
% Columns    689.41     1   689.413   86.75   1.21018e-16
% Error     1223.86   154     7.947                      
% Total     1913.28   155  

%USING ONLY HIGHRESOLUTIONINDICES

%Source      SS      df     MS       F       Prob>F   
%-----------------------------------------------------
%Columns   338.713    1   338.713   44.3   2.50542e-09
%Error     657.493   86     7.645                     
%Total     996.205   87                                                     

[p,tbl,stats] =anova1([AUCSAPWCOHCR(SAPFullResolutionIndices);AUCHCLWCOHCR(SAPFullResolutionIndices)]');%Previously stuffiwant as indices

% Source      SS      df      MS        F       Prob>F   
% -------------------------------------------------------
% Columns    402.21     1   402.206   34.24   2.83489e-08
% Error     1809.11   154    11.747                      
% Total     2211.32   155                                

%Using Only HIGHRESOLUTION INDICES

%Source      SS      df     MS       F     Prob>F
%------------------------------------------------
%Columns    161.8     1   161.802   15.7   0.0002
%Error      886.07   86    10.303                
%Total     1047.87   87                          


%add t values and degrees of freedom
[h,p,ci,stats]=ttest(AUCSAPWCOHUR(SAPFullResolutionIndices)',AUCHCLWCOHUR(SAPFullResolutionIndices)');

%first stats using stuffiwant indices (I think equivalent to SAPIndices but
%plot to chec)
%    tstat: -9.196876236196582e+00
%        df: 77
%        sd: 4.037518495586114e+00
%        ci =[ -5.114754015621349e+00 -3.294114491412724e+00]
%        p = 5.008157603559361e-14

%Using only HIGHRESOLUTIONINDICES
%  tstat: -6.1869
%       df: 43
%       sd: 4.2069
%       ci =[ -5.2028   -2.6448]
%       p =1.9550e-07

[h,p,ci,stats]=ttest(AUCSAPWCOHCR(SAPFullResolutionIndices)',AUCHCLWCOHCR(SAPFullResolutionIndices)');

%%first stats using stuffiwant indices (I think equivalent to SAPIndices but
% tstat: -5.778618070033954e+00
%        df: 77
%        sd: 4.908124209514982e+00
%        ci = -4.317994987588422e+00
%             -2.104772946540908e+00
%        p = 1.519773328583596e-07

%Using only HIGHRESOLUTIONINDICES
% tstat: -3.8584
%       df: 43
%       sd: 4.6623
%p = 3.7765e-04
%ci =[-4.1294   -1.2945]

%% STATS For Individual UR Powers Area Under Curve Using Trapz to get one AUC # for each individual
%for each group, for URs and CRs and Compare them

for a=SAPFullResolutionIndices;%101:116
    AUCSAPUR(a)=trapz(SAP100glucwvltsforaveraging6to7(:,a));
    AUCSAPCR(a)=trapz(SAP100glucwvltsforaveragingcirc(:,a));
    AUCHCLUR(a)=trapz(HCLglucwvltsforaveraging6to7(:,a));
    AUCHCLCR(a)=trapz(HCLglucwvltsforaveragingcirc(:,a));
    %AUCNonDiaCR(a-100)=trapz(NonDiaglucwvltsforaveragingcirc(:,a));
    %AUCNonDiaUR(a-100)=trapz(NonDiaglucwvltsforaveraging6to7(:,a));
   disp(a)
end

[p,tbl,stats] =anova1([AUCSAPCR(SAPFullResolutionIndices);AUCHCLCR(SAPFullResolutionIndices)]');
%For all Indices
% Source        SS        df        MS          F       Prob>F   
% ---------------------------------------------------------------
% Columns   1.50129e+09     1   1.50129e+09   86.87   2.46804e-17
% Error     3.38727e+09   196    1.7282e+07                      
% Total     4.88857e+09   197

%For HiResIndicesOnly
%Source        SS        df       MS          F        Prob>F   
%---------------------------------------------------------------
%Columns   3.56391e+08    1   3.56391e+08   100.11   4.43443e-16
%Error     3.06147e+08   86   3.55985e+06                       
%Total     6.62538e+08   87                                     


[p,tbl,stats] =anova1([AUCSAPUR;AUCHCLUR]');

% Source        SS        df        MS          F        Prob>F   
% ----------------------------------------------------------------
% Columns    2.2505e+09     1    2.2505e+09   104.63   5.95354e-20
% Error     4.21592e+09   196   2.15098e+07                       
% Total     6.46642e+09   197                                     

[p,tbl,stats] =anova1([AUCSAPCR(1:16);AUCNonDiaCR]');

% Source        SS        df       MS          F     Prob>F
% ---------------------------------------------------------
% Columns   2.93598e+08    1   2.93598e+08   11.02   0.0024
% Error     7.99126e+08   30   2.66375e+07                 
% Total     1.09272e+09   31                               

[p,tbl,stats] =anova1([AUCSAPUR(1:16);AUCNonDiaUR]');

% Source        SS        df       MS          F       Prob>F   
% --------------------------------------------------------------
% Columns   7.18287e+08    1   7.18287e+08   25.96   1.77855e-05
% Error      8.2991e+08   30   2.76637e+07                      
% Total      1.5482e+09   31                                    

[p,tbl,stats] =anova1([AUCHCLCR(1:16);AUCNonDiaCR]');
% Source        SS        df       MS         F     Prob>F
% --------------------------------------------------------
% Columns   1.48912e+06    1   1.48912e+06   0.37   0.5469
% Error     1.20325e+08   30   4.01083e+06                
% Total     1.21814e+08   31      

[p,tbl,stats] =anova1([AUCHCLUR(1:16);AUCNonDiaUR]');

% Source        SS        df       MS          F     Prob>F
% ---------------------------------------------------------
% Columns   6.33139e+07    1   6.33139e+07   19.83   0.0001
% Error     9.57844e+07   30   3.19281e+06                 
% Total     1.59098e+08   31                               


%ttests instead

[h,p,ci,stats]=ttest(AUCSAPCR(stuffiwant)',AUCHCLCR(stuffiwant)');

%     tstat: 1.004320431034863e+01
%        df: 77
%        sd: 5.566142136251220e+03
%        ci = 5.074672919589549e+03 7.584615197674614e+03
%        p =   1.195846885481822e-15

%WITH FULLRESOLUTION INDICES

[h,p,ci,stats]=ttest(AUCSAPCR(SAPFullResolutionIndices)',AUCHCLCR(SAPFullResolutionIndices)');

 %  tstat: 9.8148
 %      df: 43
 %      sd: 2.7202e+03
%p = 1.5179e-12
%ci =[1.0e+03 *    3.1979    4.8519];

[h,p,ci,stats]=ttest(AUCSAPUR(stuffiwant)',AUCHCLUR(stuffiwant)');

%     tstat: 1.297100160781107e+01
%        df: 77
%        sd: 5.570627845614170e+03
%        ci =6.925468939328035e+03 9.437433959790436e+03
%        p = 4.642904475177186e-21

[h,p,ci,stats]=ttest(AUCHCLCR(1:16)',AUCNonDiaCR');
%    tstat: 5.237966691696527e-01
%        df: 15
%        sd: 3.294708793603590e+03
%        ci = -1.324187017226160e+03 2.187065763212922e+03
%        p =6.080729303752126e-01


%% Not buying the stats on what is and isn't different from NonT1D

%HCL CRs not different from NONT1D CRs
clear p
for i=1:length(AUCHCLCR)-15
[h,p(i),ci,stats]=ttest2(AUCHCLCR(i:i+15)',AUCNonDiaCR');
%p =    0.2068 ci =   1.0e+03 *   -2.4676    0.5567 stats =   struct with fields:    tstat: -1.2904       df: 30       sd: 2.0943e+03
%mean p=0.37
disp(i)
end

%HCL URs not different from NonT1D URs
clear p
for i=1:length(AUCHCLCR)-15
[h,p(i),ci,stats]=ttest2(AUCHCLUR(i:i+15)',AUCNonDiaUR');
%p =    0.2068 ci =   1.0e+03 *   -2.4676    0.5567 stats =   struct with fields:    tstat: -1.2904       df: 30       sd: 2.0943e+03
%mean p=0..13
disp(i)
end

clear p
for i=1:length(AUCSAPCR)-15
[h,p(i),ci,stats]=ttest2(AUCSAPCR(i:i+15)',AUCNonDiaCR');
%p =    0.2068 ci =   1.0e+03 *   -2.4676    0.5567 stats =   struct with fields:    tstat: -1.2904       df: 30       sd: 2.0943e+03
%mean p=0.37
disp(i)
end

for i=1:length(AUCHCLCR)-15
[h,p(i),ci,stats]=ttest2(AUCHCLUR(i:i+15)',AUCNonDiaUR');
%p =    0.2068 ci =   1.0e+03 *   -2.4676    0.5567 stats =   struct with fields:    tstat: -1.2904       df: 30       sd: 2.0943e+03
%mean p=0..13
disp(i)
end
%% Figure 3 A HCL is Associated with Lower Amplitude Glucose Swings
%Remaking as this figure doesn't seem to currently be in the script
%Presumably Calculated in non-zscored glucose

%prior variable names to use in circadian part of figure (inclusive
%indices) are

MeanCRofNonDiaGlucose
MeanCRofSAP100Glucose
MeanCRofHCLGlucose

StdCRofNonDiaGlucose
StdCRofSAP100Glucose
StdCRofHCLGlucose

Mean2to3URofHCLGlucose
Mean2to3URofSAP100Glucose
Mean2to3URofNonDiaGlucose

Std2to3URofHCLGlucose
Std2to3URofSAP100Glucose
Std2to3URofNonDiaGlucose

%calculate variables with new indices
HCLGlucCircMeanPower=mean(HCLglucwvltsforaveragingcirc(:,HCLFullResolutionIndices),2);
HCLGlucCircStdev=mean(movstd(HCLglucwvltsforaveragingcirc(:,HCLFullResolutionIndices),1440),2);

SAPGlucCircMeanPower=mean(SAP100glucwvltsforaveragingcirc(:,SAPGlucoseIndices),2);
SAPGlucCircStdev=mean(movstd(SAP100glucwvltsforaveragingcirc(:,SAPGlucoseIndices),1440),2);

HCLGluc2to3URMeanPower=mean(HCLglucwvltsforaveraging2to3(:,HCLFullResolutionIndices),2);
HCLGluc2to3Stdev=mean(movstd(HCLglucwvltsforaveraging2to3(:,HCLFullResolutionIndices),60*3),2);

SAPGluc2to3MeanPower=mean(SAP100glucwvltsforaveraging2to3(:,SAPGlucoseIndices),2);
SAPGluc2to3Stdev=mean(movstd(SAP100glucwvltsforaveraging2to3(:,SAPGlucoseIndices),60*3),2);

%Mean across bands is maybe better

HCLGlucURsMean=mean([HCLGluc2to3URMeanPower,HCLGluc3to4URMeanPower,HCLGluc4to5URMeanPower,Mean6to7URofHCLGlucose],2);
HCLGlucURsSTD=mean([Std2to3URofHCLGlucose,HCLGluc3to4Stdev,Std4to5URofHCLGlucose,Std6to7URofHCLGlucose],2);
SAPGlucURsMean=mean([SAPGluc2to3MeanPower,SAPGluc3to4MeanPower,SAPGluc4to5MeanPower,Mean6to7URofSAP100Glucose],2);
SAPGlucURsSTD=mean([SAPGluc2to3Stdev,SAPGluc3to4Stdev,SAPGluc4to5Stdev,Std6to7URofSAP100Glucose],2);
NonT1DGlucURsMean=mean([


GlucoseAmplitudebyTherapyType=figure;

%HCL CR Power
plot(HCLGlucCircMeanPower,'color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(HCLGlucCircMeanPower);
a=fill([x fliplr(x)],[(HCLGlucCircStdev+HCLGlucCircMeanPower)' flipud(HCLGlucCircMeanPower-HCLGlucCircStdev)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

%SAP CR Power
plot(SAPGlucCircMeanPower,':','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(SAPGlucCircStdev);
a=fill([x fliplr(x)],[(SAPGlucCircStdev+SAPGlucCircMeanPower)' flipud(SAPGlucCircMeanPower-SAPGlucCircStdev)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

%NonT1D CR Power
plot(StdCRofNonDiaGlucose,'--','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdCRofNonDiaGlucose);
a=fill([x fliplr(x)],[(StdCRofNonDiaGlucose+StdCRofNonDiaGlucose)' flipud(StdCRofNonDiaGlucose-StdCRofNonDiaGlucose)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')


%HCL UR Power 2 to 3 (Like in Scatters)
plot(movmean(HCLGlucURsMean,60*8),'color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(HCLGlucURsMean);
a=fill([x fliplr(x)],[movmean(HCLGlucURsSTD+HCLGlucURsMean,60*8)' flipud(movmean(HCLGlucURsMean-HCLGlucURsSTD,60*8))'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

%SAP UR Power 2 to 3 (Like in Scatters)
plot(movmean(SAPGlucURsMean,60*8),':','color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(SAPGlucURsSTD);
a=fill([x fliplr(x)],[movmean(SAPGlucURsSTD+SAPGlucURsMean,60*8)' flipud(movmean(SAPGlucURsMean-SAPGlucURsSTD,60*8))'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

%NonT1D UR Power 2 to 3 (Like in Scatters)
plot(Mean2to3URofNonDiaGlucose,'--','color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(Mean2to3URofNonDiaGlucose);
a=fill([x fliplr(x)],[(Std2to3URofNonDiaGlucose+Mean2to3URofNonDiaGlucose)' flipud(Mean2to3URofNonDiaGlucose-Std2to3URofNonDiaGlucose)'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')



xlabel('Days');ylabel('Glucose Wavelet Power');% title('Circadian and Ultradian Amplidue');
set(gca,'XTick',[(1440/3)*5 (1440/3)*10 (1440/3)*15 (1440/3)*20 (1440/3)*25 (1440/3)*30  (1440/3)*35 (1440/3)*36 (1440/3)*37 (1440/3)*38 (1440/3)*39 (1440/3)*40 (1440/3)*41 (1440/3)*42 (1440/3)*43 (1440/3)*44 (1440/3)*45 (1440/3)*46 (1440/3)*47 (1440/3)*48 (1440/3)*49 (1440/3)*50 (1440/3)*51 (1440/3)*52 (1440/3)*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([-0.4 1.4]);xlim([2200 12960]);
print(GlucoseAmplitudebyTherapyType,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\CRURAmplitudebyGroup_100620_SAPGlucoseIndicesOnly_composite bands'); % If you want to save this figure at hires to your computer



%% Stats for Figure 3A Circadian and Ultradian Amplitude distances and overall differences
%Because my groups have different n values I need to do a kruskal wallis
%instead of an anova I think; or simply do the distance metric instead to
%account for the big diff in nvalue

%Need to REDO THIS TO USE TRAPZ AND GENERATE 1 NUMBER PER INDIVIDUAL RATHER
%THAN SO MANY

%HCLGlucURsCompsiteBand=mean([HCLGluc2to3URMeanPower,HCLGluc3to4URMeanPower,HCLGluc4to5URMeanPower,Mean6to7URofHCLGlucose],2);
%HCLGlucURsSTD=mean([Std2to3URofHCLGlucose,HCLGluc3to4Stdev,Std4to5URofHCLGlucose,Std6to7URofHCLGlucose],2);
%SAPGlucURsCompositeBand=mean([SAPGluc2to3MeanPower,SAPGluc3to4MeanPower,SAPGluc4to5MeanPower,Mean6to7URofSAP100Glucose],2);
%SAPGlucURsSTD=mean([SAPGluc2to3Stdev,SAPGluc3to4Stdev,SAPGluc4to5Stdev,Std6to7URofSAP100Glucose],2);

%HCL

%HCL vs SAP Anova and ttest on 2 to 3 h power
HCLURPowersforANOVA=reshape(HCLglucwvltsforaveraging2to3(:,SAPGlucoseIndices),[12960*82,1]);
SAPURPowersforANOVA=reshape(SAP100glucwvltsforaveraging2to3(:,SAPGlucoseIndices),[12960*82,1]);

[p,tbl,stats] =anova1([HCLURPowersforANOVA(1:(60*3)/3:end),SAPURPowersforANOVA(1:(60*3)/3:end)]); 

%Columns     54.02       1   54.0192   226.61   4.69844e-51
%Error     8443.73   35422    0.2384                       
%Total     8497.75   35423                                     

[h,p,ci,stats]=ttest(HCLURPowersforANOVA(1:(60*3)/3:end),SAPURPowersforANOVA(1:(60*3)/3:end)) %p =   3.8613e-50ci= [ -0.0883   -0.0679]
 %tstat: -14.9363
 %      df: 17711
 %      sd: 0.6959


HCLCRPowersforANOVA=reshape(HCLglucwvltsforaveragingcirc(:,SAPGlucoseIndices),[12960*82,1]);
SAPCRPowersforANOVA=reshape(SAP100glucwvltsforaveragingcirc(:,SAPGlucoseIndices),[12960*82,1]);

[p,tbl,stats] =anova1([HCLCRPowersforANOVA(1:(1440/3):end),SAPCRPowersforANOVA(1:(1440/3):end)]); 
%Source      SS       df      MS         F         Prob>F   
%-----------------------------------------------------------
%Columns    197.31      1   197.308   1083.26   1.03825e-212
%Error      806.17   4426     0.182                         
%Total     1003.48   4427                                       


[h,p,ci,stats]=ttest(HCLCRPowersforANOVA(1:(1440/3):end),SAPCRPowersforANOVA(1:(1440/3):end)) %p =   1.0407e-193 ci =[  -0.4473  -0.3970] 
%stats =     tstat: -32.9113        df: 2213      sd: 0.6036


%Distance of Each Individual from Mean NonT1D 
HCLURDistancefromNonT1DforANOVA=reshape((HCLglucwvltsforaveraging2to3(:,SAPGlucoseIndices)-Mean2to3URofNonDiaGlucose),[12960*82,1]);
SAPURDistancefromNonT1DforANOVA=reshape((SAP100glucwvltsforaveraging2to3(:,SAPGlucoseIndices)-Mean2to3URofNonDiaGlucose),[12960*82,1]);

[p,tbl,stats] =anova1([HCLURDistancefromNonT1DforANOVA(1:(60*3)/3:end),SAPURDistancefromNonT1DforANOVA(1:(60*3)/3:end)]); 
%Source      SS       df       MS        F        Prob>F   
%----------------------------------------------------------
%Columns     54.02       1   54.0192   226.55   4.85308e-51
%Error     8446.15   35422    0.2384                       
%Total     8500.17   35423                                 

[h,p,ci,stats]=ttest(HCLURDistancefromNonT1DforANOVA(1:(60*3)/3:end),SAPURDistancefromNonT1DforANOVA(1:(60*3)/3:end)) 
%p =   3.8613e-50  ci =[   -0.0883   -0.0679] stats =     tstat: -14.9363       df: 17711       sd: 0.6959

%CRs
HCLCRDistancefromNonT1DforANOVA=reshape((HCLglucwvltsforaveragingcirc(:,SAPGlucoseIndices)-MeanCRofNonDiaGlucose),[12960*82,1]);
SAPCRDistancefromNonT1DforANOVA=reshape((SAP100glucwvltsforaveragingcirc(:,SAPGlucoseIndices)-MeanCRofNonDiaGlucose),[12960*82,1]);

[p,tbl,stats] =anova1([HCLCRDistancefromNonT1DforANOVA(1:(60*3)/3:end),SAPCRDistancefromNonT1DforANOVA(1:(60*3)/3:end)]); 
%Columns   1572.4        1   1572.4    8534.49     0   
%Error     6526.17   35422      0.18                   
%Total     8098.57   35423                             

[h,p,ci,stats]=ttest(HCLCRDistancefromNonT1DforANOVA(1:(60*3)/3:end),SAPCRDistancefromNonT1DforANOVA(1:(60*3)/3:end)) 

%p =  0    ci =   -0.4303  -0.4125  stats =  struct with fields:   tstat: -92.8819   df: 17711   sd: 0.6038


FORLANCEHCLCRPowersforAnova=HCLCRPowersforANOVA(1:1440/3:end);
FORLANCESAPCRPowersforAnova=SAPCRPowersforANOVA(1:1440/3:end);

FORLANCEHCLURPowersforAnova=HCLURPowersforANOVA(1:60:end);
FORLANCESAPURPowersforAnova=SAPURPowersforANOVA(1:60:end);

%% Need to Define High TIR Indices and Low TIR Indices - What script had I done this in before??


%% Does High Coherence Associate with Improved Glycemia?

%scatter zscored glucose against CR and UR coherence
SAPCoherenceIndices=[3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,36,37,38,39,40,41,42,43,44,45,46,47,48,49,51,52,53,54,55,56,57,58,61,62,63,64,65,66,67,68,69,71,72,73,74,75,78,79,80,81,82,84,85,86,88,89,90,92,93,94,95,96,97,98]
SAP23CoherenceIndices=[3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,20,21,23,25,26,27,28,29,30,31,32,33,34,36,37,39,40,41,42,43,44,45,46,47,48,49,51,52,53,54,56,57,58,61,62,63,64,65,66,67,69,71,72,73,74,75,78,79,80,81,82,84,85,86,88,89,90,92,93,94,95,96,97]


%Glucose vs. Circadian Coherence Looks Like Nothing For All Indices. 
figure; 
for i=NewHighTIRHCLIndices;%HCLLowTIROnly;%HCLHighTIROnly';%SAP23CoherenceIndices %1:150%;HCLFullResolutionIndices;%
    hold on;
    %subplot(2,3,1)
 %s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLwcohsforaveraging1to2(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 %s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAPwcohsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
title('HCL Glucose : Glucose-Insulin Coherence 1 to 2')

   %subplot(2,3,2)
 %s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLwcohsforavg2to3(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 %s.MarkerFaceAlpha=0.07;
 %s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAPwcohsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
title('HCL Glucose : Glucose-Insulin Coherence 2 to 3')

   %subplot(2,3,5)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLwcohsforaveragingcirc(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAPwcohsforaveragingcirc(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
title('HCL Glucose : Circadian Coherence')
disp(i)


end
%ylim([0.01 2]); xlim([0.01 2]);


for i=HCLLowTIROnly';%SAP23CoherenceIndices %1:150%
   % subplot(2,3,1)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLwcohsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
 
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAPwcohsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
title('HCL Glucose : Glucose-Insulin Coherence 1 to 2')

  % subplot(2,3,2)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLwcohsforavg2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAPwcohsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
title('HCL Glucose : Glucose-Insulin Coherence 2 to 3')
hold on;
   %subplot(2,3,5)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLwcohsforaveragingcirc(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAPwcohsforaveragingcirc(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;
title('HCL Glucose : Circadian Coherence')
disp(i)


end

%% zscored glucose vs glucose wavelet power

%vs the wavelet power of glucose
figure; 
for i=VeryGoodHCLIndices;%HCLHighTIROnly';%SAP23CoherenceIndices %1:150%
   % subplot(2,3,1)
 s=scatter(zHCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging1to2(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(zSAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 1 to 2')

  %subplot(2,3,2)
 s=scatter(zHCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging2to3(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(zSAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 2 to 3')

 %subplot(2,3,3)
 s=scatter(zHCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging3to4(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(zSAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging3to4(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 3 to 4')

%subplot(2,3,4)
 s=scatter(zHCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging4to5(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(zSAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging4to5(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 4 to 5')

%subplot(2,3,5)
 s=scatter(zHCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging5to6(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(zSAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging5to6(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 5 to 6')

%subplot(2,3,6)
 s=scatter(zHCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveragingcirc(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(zSAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveragingcirc(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 5 to 6')
disp(i)
end

%% Non-NormalizedGlucose vs WaveletPower Broad Spectrum Plotting by Glycemia
figure; 
for i=VeryGoodHCLIndices; %HCLLowTIROnly'; %SAP23CoherenceIndices %1:150%
   % subplot(2,3,1)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging1to2(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging1to2(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 1 to 2')

  %subplot(2,3,2)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging2to3(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 2 to 3')

 %subplot(2,3,3)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging3to4(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging3to4(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 3 to 4')

%subplot(2,3,4)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging4to5(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging4to5(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 4 to 5')

%subplot(2,3,5)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveraging5to6(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveraging5to6(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 5 to 6')

%subplot(2,3,6)
 s=scatter(HCL150glucosefirstmonth(1:10:4300,i),HCLglucwvltsforaveragingcirc(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;s.MarkerEdgeAlpha=0.07;
%t=scatter(SAP100glucosefirstmonth(1:10:4300,i),SAP100glucwvltsforaveragingcirc(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
%t.MarkerFaceAlpha=0.07;t.MarkerEdgeAlpha=0.07;title('zGlucose : Glucose wvlts 5 to 6')

title('Raw Glucose vs. Glucose Wvlt Power');
disp(i)
end





