%% Figure and Stats Code for JDST: Multi-Timescale Rhythmicity of Blood Glucose and INsulin Delivery Reveals Key Advantages of Hybrid Closed Loop Therapy
%Azure D. Grant, Dana M. Lewis, Lance J. Kriegsfeld

%Figure Code by Azure Grant. Wavelet base code by Dr. Tanya Leise. Wavelet
%coherence tools by Dr. Aslak Grinsted.


%%  Some Individuals have data with Gaps. These Indices can be used to remove people with glucose gaps, insulin gaps, or both.

%Basic Data-Present SAP Indices for use in Histogram Skewness Stats
% This is for all data, not just the first month which is great. n = 89
SAPIndices=[3:49,51:58,61:69,71:75,77:82,84:86,88:90,92:99];

%Has High Resolution INsulin OR Glucose
SAPGlucoseIndices=[1:14,16:19,21,22,24:35,36:45,47:67,69:71,83:98];%SAPInsulinIndices=[1,4:6,8:49,51:58,61:69,71:75,78:82,84:86,89:90,91:99];

%Has high resolution glucose AND insulin
SAPFullResolutionIndices=[3,4,6,11,16:20,21,22,24,25,27,28,33,34,36,37,39,40,43,45,49,51,53:55,61,66,67,74,78,79,80,81,85,89,90,92,94,95,96,98];
HCLFullResolutionIndices=[1:18,20:25,27:48,50:65,67:70,72:114,116:150];

%% Figure 1 Compnoents: Hybrid Closed Loop Systems Reduce Hyperglycemia. 
%Plots Histograms for SAP and HCL (Part A), and NonT1D Glucose (Part B),
%and Median outlines (Part C)

%See Script called ADAPoster2020Code_MovingForward for generation of these
%variables

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
%print(Threepanelhisto,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\3panelhisto_SAPGlucoseIndices'); % If you want to save this figure at hires to your computer

%% Figure 1 Statistics
%Define overall skewness for median outlines

askewnesstest=skewness(medianoutlineHCL) %skewness of HCL is 1.29
askewnesstest2=skewness(medianoutlineNonDia) %skew of Non T1D is 3.5
askewnesstest3=skewness(medianoutlineSAP) % skewness of SAP is 0.9033

%Compute every individual's skewness metric; both with comparable indices
%to match the SAP group, and for all indices.

%define vectors where every individual gets one skewness metric
for i=SAPIndices
SkewnessSAP(1,i)=skewness(SAPHistosGlucose(:,i));
SkewnessHCLSAPIndices(1,i)=skewness(HCLHistosGlucose(:,i));
disp(i)
end;

for i=101:116
   SkewnessNonT1D(1,i-100)=skewness(NonDiabeticHistosGlucose(:,i));
   disp(i)
end

for i=1:150
    SkewnessHCL(1,i)=skewness(HCLHistosGlucose(:,i)); disp(i)
end

%Multiple Stats Agree on Outcome: All groups' skewnesses differ
%significantly

%Run the tests on all numbers for all groups using a kw
group=[ones(size(SkewnessHCL)), 2*ones(size(SkewnessSAP)), 3*ones(size(SkewnessNonT1D))];
[pSkewnesses,tblSkewnesses,statsSkewnesses]=kruskalwallis([SkewnessHCL,SkewnessSAP,SkewnessNonT1D],group);

%Source     SS      df       MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Groups    312214     2   156107     57.85    2.74863e-13
%Error    1053334   251     4196.5                       
%Total    1365548   253                                  

cSkewnesses=multcompare(statsSkewnesses,'CType','dunn-sidak');

%Col 1 and 2 are groups compared. Col 4 is diff between estimated group
%medians. Col 3 and 5 are uppare and lower lims for 95% Ci. Col 6 is p-val
%Columns 1 through 4
%  1.0000    2.0000   14.8414   37.8575
%   1.0000    3.0000 -155.3961 -110.0828
%  2.0000    3.0000 -194.6564 -147.9403

% Columns 5 through 6
 %  60.8736    0.0003
 % -64.7694    0.0000
 %-101.2241    0.0000
 
 %% Figure 2 HCL Improves Correlation of Glucose and Insulin Levels and Ultradian Rhythms

%Plots correlation of zscored SAP glucose and insulin, of zscored HCL
%glucose and insulin, of SAP glucose and insulin URs, and of HCL glucose
%and insulin URs.

%Plots every 100th point for ease of visualization. Stats utilize

%Uses indices of full resolution glucose and insulin for each group. Using
%all 150 individuals for HCL yields a similar results

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
t=scatter(SAP100glucwvltsforaveraging2to3(1:10:4300,i),SAP100Insulinwvltsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
ylim([0.01 2]); xlim([0.01 2]);
subplot(2,3,5)
 s=scatter(HCLglucwvltsforaveraging2to3(1:10:4300,i),HCLInsulinwvltsforaveraging2to3(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
 ylim([0.01 2]); xlim([0.01 2]);
%title('HCL Glucose UR Power: Insulin UR Power')
subplot(2,3,6)
t=scatter(SAP100glucwvltsforaveraging2to3(1:10:4300,i),SAP100Insulinwvltsforaveraging2to3(1:10:4300,i),10,[0.8 0.0 0.0],'filled'); hold on;
t.MarkerFaceAlpha=0.07;
t.MarkerEdgeAlpha=0.07;
 s=scatter(HCLglucwvltsforaveraging2to3(1:10:4300,i),HCLInsulinwvltsforaveraging2to3(1:10:4300,i),10,[0.0 0.3 1],'filled'); hold on;
 s.MarkerFaceAlpha=0.07;
 s.MarkerEdgeAlpha=0.07;
 ylim([0.01 2]); xlim([0.01 2]);

disp(i)
end
%print(ScattersGlucLevelRhythm,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\ScattersGlucLevelRhythm_SAPFullResolutionIndices'); % If you want to save this figure at hires to your computer


%% Statistics for Figure 2

%Statistics done on SAPFullResolutionIndices Population for each linear model
%HCL zlinear
fitlmzHCLglucose=reshape(zHCL150glucosefirstmonth(1:1440:41760,SAPFullResolutionIndices),[29*44,1]);
fitlmzHCLinsulin=reshape(zHCL150insulinfirstmonth(1:1440:41760,SAPFullResolutionIndices),[29*44,1]);
mdl=fitlm(fitlmzHCLglucose,fitlmzHCLinsulin)

 %                  Estimate       SE       tStat       pValue  
 %   (Intercept)    0.070667    0.030659    2.3049       0.02133
 %   x1              0.12336     0.02814    4.3838    1.2625e-05
%Number of observations: 1276, Error degrees of freedom: 1274
%Root Mean Squared Error: 1.09
%R-squared: 0.0149,  Adjusted R-Squared: 0.0141
%F-statistic vs. constant model: 19.2, p-value = 1.26e-05

%SAP zlinear 
clear x y
x=reshape(zSAP100glucosefirstmonth(1:1440:41760,SAPFullResolutionIndices),[29*44,1]);
 y=reshape(zSAP100insulinnewfirstmonth(1:1440:41760,SAPFullResolutionIndices),[29*44,1]);
 mdl=fitlm(x,y);
 
%                    Estimate       SE        tStat     pValue 
%   (Intercept)    0.014196      0.0305    0.46546    0.64168
%    x1             0.046111    0.029523     1.5619    0.11857
%Number of observations: 1276, Error degrees of freedom: 1274
%Root Mean Squared Error: 1.09
%R-squared: 0.00191,  Adjusted R-Squared: 0.00113
%F-statistic vs. constant model: 2.44, p-value = 0.119


 
%HCL URs %downsampling to decrease pseudoreplication. days treated as
%independent. Sampling once every 1440 data points for ~ 1 month
 fitlmHCLUR2to3glucose=reshape(HCLglucwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
fitlmHCLUR2to3insulin=reshape(HCLInsulinwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm( fitlmHCLUR2to3glucose,fitlmHCLUR2to3insulin);
 
%                    Estimate       SE       tStat       pValue  
%    (Intercept)    0.28994     0.011076    26.177    9.1004e-117
%    x1             0.15639     0.015869    9.8553     5.5984e-22
%Number of observations: 1056, Error degrees of freedom: 1054
%Root Mean Squared Error: 0.153
%R-squared: 0.0844,  Adjusted R-Squared: 0.0835
%F-statistic vs. constant model: 97.1, p-value = 5.6e-22

  %SAP URs %downsampling to decrease pseudoreplication. days treated as
 %independent. Sampling once every 1440 data points for ~ 1 month
 
fitlmSAPUR2to3glucose=reshape(SAP100glucwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
fitlmSAPUR2to3insulin=reshape(SAP100Insulinwvltsforaveraging2to3(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
mdl=fitlm(fitlmSAPUR2to3glucose,fitlmSAPUR2to3insulin);
 
%                    Estimate        SE        tStat       pValue  
%   (Intercept)      0.60223    0.028059     21.463    4.5419e-85
%    x1             -0.033271    0.021759    -1.5291       0.12654
%Number of observations: 1056, Error degrees of freedom: 1054
%Root Mean Squared Error: 0.304
%R-squared: 0.00221,  Adjusted R-Squared: 0.00127
%F-statistic vs. constant model: 2.34, p-value = 0.127


%% Statistics for Figure 2 Using Expanded Indices for SAPGlucoseIndices

%Statistics done on SAPFullResolutionIndices Population for each linear model
%HCL zlinear
fitlmzHCLglucose=reshape(zHCL150glucosefirstmonth(1:1440:41760,SAPGlucoseIndices),[29*82,1]);
fitlmzHCLinsulin=reshape(zHCL150insulinfirstmonth(1:1440:41760,SAPGlucoseIndices),[29*82,1]);
mdl=fitlm(fitlmzHCLglucose,fitlmzHCLinsulin)

%                  Estimate       SE       tStat       pValue  
%    (Intercept)    0.034615       0.022    1.5734       0.11576
%    x1              0.13054    0.020004    6.5257    8.2431e-11
%Number of observations: 2378, Error degrees of freedom: 2376
%Root Mean Squared Error: 1.07
%R-squared: 0.0176,  Adjusted R-Squared: 0.0172
%F-statistic vs. constant model: 42.6, p-value = 8.24e-11

%SAP zlinear 
clear x y
x=reshape(zSAP100glucosefirstmonth(1:1440:41760,SAPGlucoseIndices),[29*82,1]);
 y=reshape(zSAP100insulinnewfirstmonth(1:1440:41760,SAPGlucoseIndices),[29*82,1]);
 mdl=fitlm(x,y);
 
%                    Estimate       SE        tStat     pValue 
%    (Intercept)      0.060403    0.022172      2.7243    0.0064912
%    x1             -0.0038764    0.022525    -0.17209      0.8633
%Number of observations: 2378, Error degrees of freedom: 2376
%Root Mean Squared Error: 1.08
%R-squared: 1.25e-05,  Adjusted R-Squared: -0.000408
%F-statistic vs. constant model: 0.0296, p-value = 0.863


 
%HCL URs %downsampling to decrease pseudoreplication. days treated as
%independent. Sampling once every 1440 data points for ~ 1 month
clear  fitlmHCLUR2to3glucose fitlmHCLUR2to3insulin
 fitlmHCLUR2to3glucose=reshape(HCLglucwvltsforaveraging2to3(1:1440/3:11520,SAPGlucoseIndices),[24*82,1]);
fitlmHCLUR2to3insulin=reshape(HCLInsulinwvltsforaveraging2to3(1:1440/3:11520,SAPGlucoseIndices),[24*82,1]);
 mdl=fitlm( fitlmHCLUR2to3glucose,fitlmHCLUR2to3insulin);
 
%                    Estimate       SE       tStat       pValue  
%    (Intercept)    0.28264     0.0086259    32.766    2.8898e-188
%    x1             0.16075      0.012356     13.01     3.4968e-37
%Number of observations: 1968, Error degrees of freedom: 1966
%Root Mean Squared Error: 0.163
%R-squared: 0.0793,  Adjusted R-Squared: 0.0788
%F-statistic vs. constant model: 169, p-value = 3.5e-37

  %SAP URs %downsampling to decrease pseudoreplication. days treated as
 %independent. Sampling once every 1440 data points for ~ 1 month
 
fitlmSAPUR2to3glucose=reshape(SAP100glucwvltsforaveraging2to3(1:1440/3:11520,SAPGlucoseIndices),[24*82,1]);
fitlmSAPUR2to3insulin=reshape(SAP100Insulinwvltsforaveraging2to3(1:1440/3:11520,SAPGlucoseIndices),[24*82,1]);
mdl=fitlm(fitlmSAPUR2to3glucose,fitlmSAPUR2to3insulin);
 
%                    Estimate        SE        tStat       pValue  
%   (Intercept)     0.3883     0.010978    35.371    1.6192e-212
%    x1             0.13024      0.01171    11.122     6.5333e-28
%Number of observations: 1968, Error degrees of freedom: 1966
%Root Mean Squared Error: 0.321
%R-squared: 0.0592,  Adjusted R-Squared: 0.0587
%F-statistic vs. constant model: 124, p-value = 6.53e-28
%% Figure 3A HCL Use is Associated with Lower Amplitude Glucose Swings and Greater Glucose Insulin Coherence
% Composite UR Power Version
%HCLGlucURsMean=mean([HCLGluc2to3URMeanPower,HCLGluc3to4URMeanPower,HCLGluc4to5URMeanPower,Mean6to7URofHCLGlucose],2);
%HCLGlucURsSTD=mean([Std2to3URofHCLGlucose,HCLGluc3to4Stdev,Std4to5URofHCLGlucose,Std6to7URofHCLGlucose],2);
%SAPGlucURsMean=mean([SAPGluc2to3MeanPower,SAPGluc3to4MeanPower,SAPGluc4to5MeanPower,Mean6to7URofSAP100Glucose],2);
%SAPGlucURsSTD=mean([SAPGluc2to3Stdev,SAPGluc3to4Stdev,SAPGluc4to5Stdev,Std6to7URofSAP100Glucose],2);
%NonT1DGlucURsMean=mean([Mean2to3URofNonDiaGlucose,Mean4to5URofNonDiaGlucose,Mean6to7URofNonDiaGlucose],2);
%NonT1DGlucURsSTD=mean([Std2to3URofNonDiaGlucose,Std4to5URofNonDiaGlucose,Std6to7URofNonDiaGlucose],2);

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
plot(MeanCRofNonDiaGlucose,'--','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdCRofNonDiaGlucose);
a=fill([x fliplr(x)],[(MeanCRofNonDiaGlucose+StdCRofNonDiaGlucose)' flipud(MeanCRofNonDiaGlucose-StdCRofNonDiaGlucose)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')


%HCL UR Power Composite
plot(movmean(HCLGlucURsMean,60*8),'color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(HCLGlucURsMean);
a=fill([x fliplr(x)],[movmean(HCLGlucURsSTD+HCLGlucURsMean,60*8)' flipud(movmean(HCLGlucURsMean-HCLGlucURsSTD,60*8))'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

%SAP UR Power Composite
plot(movmean(SAPGlucURsMean,60*8),':','color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(SAPGlucURsSTD);
a=fill([x fliplr(x)],[movmean(SAPGlucURsSTD+SAPGlucURsMean,60*8)' flipud(movmean(SAPGlucURsMean-SAPGlucURsSTD,60*8))'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

%NonT1D UR Power Composite
plot(NonT1DGlucURsMean,'--','color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(NonT1DGlucURsMean);
a=fill([x fliplr(x)],[(NonT1DGlucURsSTD+NonT1DGlucURsMean)' flipud(NonT1DGlucURsMean-NonT1DGlucURsSTD)'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

xlabel('Days');ylabel('Glucose Wavelet Power');% title('Circadian and Ultradian Amplidue');
set(gca,'XTick',[(60*8/3)*5 (60*8/3)*10 (60*8/3)*15 (60*8/3)*20 (60*8/3)*25 (60*8/3)*30  (60*8/3)*35 (60*8/3)*36 (60*8/3)*37 (60*8/3)*38 (60*8/3)*39 (60*8/3)*40 (60*8/3)*41 (60*8/3)*42 (60*8/3)*43 (60*8/3)*44 (60*8/3)*45 (60*8/3)*46 (60*8/3)*47 (60*8/3)*48 (60*8/3)*49 (60*8/3)*50 (60*8/3)*51 (60*8/3)*52 (60*8/3)*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([-0.4 1.4]);xlim([2200 12960]);
%print(GlucoseAmplitudebyTherapyType,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\CRURAmplitudebyGroup_100620_SAPGlucoseIndicesOnly_composite bands'); % If you want to save this figure at hires to your computer

%% Statistics for Figure 3A

% Define Areas Under the Curve for Each Group
%for a =101:116
%     AUCNonDiaCR(a-100)=trapz(NonDiaglucwvltsforaveragingcirc(:,a));
%    AUCNonDiaUR(a-100)=trapz(NonDiaglucwvltsforaveraging2to3(:,a));
%    disp(a)
%end

%AUCNonDiaCRMean=mean(AUCNonDiaCR,2);
%AUCNonDiaURMean=mean(AUCNonDiaUR,2);
for a=1:150;%101:116 %Used only SAPGlucoseIndices %1:150; %
%    AUCSAPUR(a)=trapz(mean([SAP100glucwvltsforaveraging1to2(:,a),SAP100glucwvltsforaveraging2to3(:,a),SAP100glucwvltsforaveraging3to4(:,a),SAP100glucwvltsforaveraging4to5(:,a),SAP100glucwvltsforaveraging5to6(:,a)],2));
%    AUCSAPCR(a)=trapz(SAP100glucwvltsforaveragingcirc(:,a));
%    AUCSAPURMinusNonT1d(a)=AUCSAPUR(a)-AUCNonDiaURMean;
%    AUCSAPCRMinusNonT1d(a)=AUCSAPCR(a)-AUCNonDiaCRMean;
    AUCHCLUR(a)=trapz(mean([HCLglucwvltsforaveraging1to2(:,a),HCLglucwvltsforaveraging2to3(:,a),HCLglucwvltsforaveraging3to4(:,a),HCLglucwvltsforaveraging4to5(:,a),HCLglucwvltsforaveraging6to7(:,a)],2));
    %AUCHCLCR(a)=trapz(HCLglucwvltsforaveragingcirc(:,a));
    %AUCHCLURMinusNonT1d(a)=AUCHCLUR(a)-AUCNonDiaURMean;
    %AUCHCLCRMinusNonT1d(a)=AUCHCLCR(a)-AUCNonDiaCRMean;
   disp(a)
   
end

%AUCSAPCR(AUCSAPCR==0)=[];
%AUCSAPUR(AUCSAPCR==0)=[];

%HCL CRs are not different from NonT1D CRs - But HCL is Different from SAP
%and NonT1d is Different from SAP

group=[ones(size(AUCHCLCR)), 2*ones(size(AUCNonDiaCR)),3*ones(size(AUCSAPCR))];
[pAmplitudeHCLvsNonT1dvsSAP,tblAmplitudeHCLvsNonT1dvsSAP,statsAmplitudeHCLvsNonT1dvsSAP]=kruskalwallis([AUCHCLCR,AUCNonDiaCR,AUCSAPCR],group);
cSkewnesses=multcompare(statsAmplitudeHCLvsNonT1dvsSAP,'CType','dunn-sidak')

%Initial Table
%Source      SS       df       MS      Chi-sq   Prob>Chi-sq
%----------------------------------------------------------
%Groups    742685.9     2   371342.9   139.79   4.41605e-31
%Error     590846.1   249     2372.9                       
%Total    1333532     251                                                                

%cSkewnesses =

%  Columns 1 through 4

%    1.0000    2.0000  -11.5362   34.2358
%    1.0000    3.0000 -133.4251 -109.8848
%    2.0000    3.0000 -191.5058 -144.1206

%  Columns 5 through 6

%   80.0078    0.2063
%  -86.3445         0
%  -96.7355    0.0000


% HCL SAP NonDia URs
group=[ones(size(AUCHCLUR)), 2*ones(size(AUCNonDiaUR)),3*ones(size(AUCSAPUR))];
[pAmplitudeHCLvsNonT1dvsSAP,tblAmplitudeHCLvsNonT1dvsSAP,statsAmplitudeHCLvsNonT1dvsSAP]=kruskalwallis([AUCHCLUR,AUCNonDiaUR,AUCSAPUR],group);
cSkewnesses=multcompare(statsAmplitudeHCLvsNonT1dvsSAP,'CType','dunn-sidak')

%Source      SS       df       MS      Chi-sq   Prob>Chi-sq
%----------------------------------------------------------
%Groups    428275.1     2   214137.6   73.48    1.10789e-16
%Error    1104655.4   261     4232.4                       
%Total    1532930.5   263                                  


%cSkewnesses =
%  Columns 1 through 2

%    1.0000    2.0000
%    1.0000    3.0000
%    2.0000    3.0000

 % Columns 3 through 4

%   41.7219   89.6642
%  -86.1958  -62.5182
% -201.3353 -152.1824

%  Columns 5 through 6

%  137.6064    0.0000
%  -38.8407    0.0000
% -103.0295    0.0000


%% %% Figure 3B Circadian Coherence is Increased in HCL

MeanwcohcircSAPFullResolutionIndices=mean(movmean(SAPwcohsforaveragingcirc(:,SAPFullResolutionIndices),1440),2);
StdevwcohcircSAPFullResolutionIndices=mean(movstd(SAPwcohsforaveragingcirc(:,SAPFullResolutionIndices),1440),2);

circcohfullres=figure;
%SAP Circadian Coherence Mean and STDEV
plot(MeanwcohcircSAPFullResolutionIndices,':','color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(MeanwcohcircSAPFullResolutionIndices);
a=fill([x fliplr(x)],[(StdevwcohcircSAPFullResolutionIndices+MeanwcohcircSAPFullResolutionIndices)' flipud(MeanwcohcircSAPFullResolutionIndices-StdevwcohcircSAPFullResolutionIndices)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

%HCL Circadian Coherence Mean and STDEV
plot(HCLMeanwcohcirctest,'color',[0.1 0 0.8],'LineWidth',4);
hold on; 
x=1:length(StdevwcohcircHCLtest);
a=fill([x fliplr(x)],[(StdevwcohcircHCLtest+HCLMeanwcohcirctest)' flipud(HCLMeanwcohcirctest-StdevwcohcircHCLtest)'],[0.1 0 0.5]); alpha(0.1); set(a,'EdgeColor','none')

xlabel('Days');ylabel('Circadian and Ultradian Coherence');% title('Circadian and Ultradian Coherence of HCL Individuals');
set(gca,'XTick',[1440 1440*5 1440*10 1440*15 1440*20 1440*25 1440*30  1440*35 1440*36 1440*37 1440*38 1440*39 1440*40 1440*41 1440*42 1440*43 1440*44 1440*45 1440*46 1440*47 1440*48 1440*49 1440*50 1440*51 1440*52 1440*53]);
set(gca,'XTickLabel',[1 5 10 15 20 25 30 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53]);
axis tight
ylim([0 0.55]);
%print(circcohfullres,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\CoherencebygroupCRS_100620_SAPFullResIndicesOnly'); % If you want to save this figure at hires to your computer

%% Figure 3B Statistics

%Area Under the Curve Stats for Circadian Coherene

for a=HCLFullResolutionIndices%SAPFullResolutionIndices% previously; stuffiwant
    %AUCSAPWCOHCR(a)=trapz(SAPwcohsforaveragingcirc(1:1440:end,a));
    AUCHCLWCOHCR(a)=trapz(HCLwcohsforaveragingcirc(1:1440:end,a));
   disp(a)
end

AUCSAPWCOHCR(AUCSAPWCOHCR==0)=[];
AUCHCLWCOHCR(AUCHCLWCOHCR==0)=[];


group=[ones(size(AUCHCLWCOHCR)), 2*ones(size(AUCSAPWCOHCR))];
[pCohCR,tblCohCR,statsCohCR]=kruskalwallis([AUCHCLWCOHCR,AUCSAPWCOHCR],group);

%Source      SS      df      MS      Chi-sq   Prob>Chi-sq
%--------------------------------------------------------
%Groups    88994.4     1   88994.4   29.12    6.79885e-08
%Error    491645.6   189    2601.3                       
%Total    580640     190      

%% Supplemental Figure 2

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


print(SuppFigURScattersbyPeriod,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\SuppFigURScattersbyPeriod_SAPFullResolution_102320'); % If you want to save this figure at hires to your computer

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


%print(SuppFigURScattersbyPeriod,'-djpeg','-r1000','C:\Users\azure\Google Drive\Berkeley Grad School\JDRF Grant 2018\Figures\JDST 2020 Paper\SuppFigURScattersbyPeriod_SAPFullResolution_100620'); % If you want to save this figure at hires to your computer


%% Supplemental Figure 2 Statistics. Rhythms are Correlated Across the Spectrum in HCL, but not in SAP
%SAP Other Bands  p avg = 0.2587. See each result below

% 1 to 2
fitlmSAPUR1to2glucose=reshape(SAP100glucwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmSAPUR1to2insulin=reshape(SAP100Insulinwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmSAPUR1to2glucose,fitlmSAPUR1to2insulin); %r=0.0308 p-value = 9.17e-9

%3to4
fitlmSAPUR3to4glucose=reshape(SAP100glucwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmSAPUR3to4insulin=reshape(SAP100Insulinwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmSAPUR3to4glucose,fitlmSAPUR3to4insulin); %6.3e-5 p-value = 0.797
 
 %4to5
fitlmSAPUR4to5glucose=reshape(SAP100glucwvltsforaveraging4to5(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmSAPUR4to5insulin=reshape(SAP100Insulinwvltsforaveraging4to5(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmSAPUR4to5glucose,fitlmSAPUR4to5insulin); %r=0.00032 p-value = 0.561
 
 %5 to6
 fitlmSAPUR5to6glucose=reshape(SAP100glucwvltsforaveraging5to6(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmSAPUR5to6insulin=reshape(SAP100Insulinwvltsforaveraging5to6(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmSAPUR5to6glucose,fitlmSAPUR5to6insulin); %r=0.00474 p-value = 0.0253
 
 %6to7
 fitlmSAPUR6to7glucose=reshape(SAP100glucwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmSAPUR6to7insulin=reshape(SAP100Insulinwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmSAPUR6to7glucose,fitlmSAPUR6to7insulin); % r=0.00458 pval=0.0279
 
 %circadian
 
  fitlmSAPURcircglucose=reshape(SAP100glucwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmSAPURcircinsulin=reshape(SAP100Insulinwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmSAPURcircglucose,fitlmSAPURcircinsulin) %r=0.002 p=0.141
 
 %avg p for sap = 
 mean([9.17e-9 0.127 0.8 0.8 0.028 0.141])  %0.3538
 
 %avg r2 = 
 mean([0.031 0.002 6.3e-5 3.2e-4 0.005 0.002]) %0.0077
 
%HCL Other Bands Mean P   avg= 1.4430e-09

% 1 to 2
fitlmHCLUR1to2glucose=reshape(HCLglucwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmHCLUR1to2insulin=reshape(HCLInsulinwvltsforaveraging1to2(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmHCLUR1to2glucose,fitlmHCLUR1to2insulin); %r=0.0881 p-value = 6.5e-23

%3to4
fitlmHCLUR3to4glucose=reshape(HCLglucwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmHCLUR3to4insulin=reshape(HCLInsulinwvltsforaveraging3to4(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmHCLUR3to4glucose,fitlmHCLUR3to4insulin); %R=0.0431 p-value = 9.48e-12
 
 %4to5
fitlmHCLUR4to5glucose=reshape(HCLglucwvltsforaveraging4to5(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmHCLUR4to5insulin=reshape(HCLInsulinwvltsforaveraging4to5(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmHCLUR4to5glucose,fitlmHCLUR4to5insulin); %r=0.0408 p-value = 3.43e-11
 
 
 %6to7
 fitlmHCLUR6to7glucose=reshape(HCLglucwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmHCLUR6to7insulin=reshape(HCLInsulinwvltsforaveraging6to7(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmHCLUR6to7glucose,fitlmHCLUR6to7insulin); %r=0.03 pval=7.17e-9
 
 mean([0.0408, 0.03]) %0.0354
 mean([3.43e-11, 7.17e-9]) %3.602e-9
 
 %circadian
 
  fitlmHCLURcircglucose=reshape(HCLglucwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 fitlmHCLURcircinsulin=reshape(HCLInsulinwvltsforaveragingcirc(1:1440/3:11520,SAPFullResolutionIndices),[24*44,1]);
 mdl=fitlm(fitlmHCLURcircglucose,fitlmHCLURcircinsulin) %r=0.083 p=1.13e-21
 
 mean([0.088 0.084 0.043 0.035 0.083])
 mean([6.5e-23 5.6e-22 9.48e-12 3.6e-9 1.13e-21 1.26e-5])
 
 
 
 
 %% Extra Periodicities of Amplitude Mean for Fun
 
 %HCL UR Power 2-3
plot(movmean(HCLGluc2to3URMeanPower,60*8),'color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(Std2to3URofHCLGlucose);
a=fill([x fliplr(x)],[movmean(Std2to3URofHCLGlucose+HCLGluc2to3URMeanPower,60*8)' flipud(movmean(HCLGluc2to3URMeanPower-Std2to3URofHCLGlucose,60*8))'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

%SAP UR Power 2-3
plot(movmean(SAPGluc2to3MeanPower,60*8),':','color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(SAPGluc2to3MeanPower);
a=fill([x fliplr(x)],[movmean(SAPGluc2to3Stdev+SAPGluc2to3MeanPower,60*8)' flipud(movmean(SAPGluc2to3MeanPower-SAPGluc2to3Stdev,60*8))'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')

%NonT1D UR Power 2-3
plot(NonT1DGlucURsMean,'--','color',[0.4 0 0.3],'LineWidth',4);
hold on; 
x=1:length(NonT1DGlucURsMean);
a=fill([x fliplr(x)],[(NonT1DGlucURsSTD+NonT1DGlucURsMean)' flipud(NonT1DGlucURsMean-NonT1DGlucURsSTD)'],[0.5 0 0.7]); alpha(0.1); set(a,'EdgeColor','none')





