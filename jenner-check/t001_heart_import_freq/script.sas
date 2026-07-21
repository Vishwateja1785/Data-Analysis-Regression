/* Heart Failure Prediction dataset — same DATA step as the repo's
   "Data Analysis & Regression.sas", reading a small inline sample of
   heart.csv instead of the external file so the run is self-contained.
   The repo's infile used delimiter=',' missover; we keep that by pointing
   infile at the inline datalines with the same options. */
data heart;
title "Heart Failure Prediction dataset";
infile datalines delimiter=',' missover;
input Age Sex $ ChestPainType $ RestingBP Cholesterol FastingBS RestingECG $ MaxHR ExerciseAngina $ Oldpeak ST_Slope $ HeartDisease;
datalines;
40,M,ATA,140,289,0,Normal,172,N,0,Up,0
49,F,NAP,160,180,0,Normal,156,N,1,Flat,1
49,F,ATA,124,201,0,Normal,164,N,0,Up,0
31,M,ASY,120,270,0,Normal,153,Y,1.5,Flat,1
35,M,ATA,150,264,0,Normal,168,N,0,Up,0
40,F,ASY,150,392,0,Normal,130,N,2,Flat,1
50,F,ATA,110,202,0,Normal,145,N,0,Up,0
47,M,ASY,160,291,0,ST,158,Y,3,Flat,1
55,M,ASY,140,229,0,Normal,110,Y,0.5,Flat,0
53,M,ASY,120,246,0,Normal,116,Y,0,Flat,1
39,M,ATA,190,241,0,Normal,106,N,0,Up,0
54,M,NAP,120,237,0,Normal,150,Y,1.5,Flat,1
38,M,NAP,145,292,0,Normal,130,N,0,Up,0
61,M,ASY,105,0,1,Normal,110,Y,1.5,Up,1
49,M,ASY,140,185,0,Normal,130,N,0,Up,0
56,M,ASY,140,0,1,Normal,121,Y,1.8,Up,1
46,F,ASY,130,238,0,Normal,90,N,0,Up,0
63,M,ASY,140,0,1,LVH,149,N,2,Up,1
57,F,TA,130,308,0,Normal,98,N,1,Flat,0
46,M,ASY,115,0,0,Normal,113,Y,1.5,Flat,1
29,M,ATA,140,263,0,Normal,170,N,0,Up,0
73,F,NAP,160,0,0,ST,121,N,0,Up,1
43,F,ATA,120,266,0,Normal,118,N,0,Up,0
38,M,ASY,150,0,1,Normal,120,Y,0.7,Flat,1
45,M,ASY,120,225,0,Normal,140,N,0,Up,0
54,M,ASY,180,0,1,Normal,150,N,1.5,Flat,1
48,F,ATA,133,308,0,ST,156,N,2,Up,0
64,M,ASY,120,0,1,ST,106,N,2,Flat,1
;
run;

/* derived indicator variables — verbatim from the repo */
data heart;
set heart;
Sex_Male=(Sex='M');
CP_ASY = (ChestPainType = 'ASY');
CP_ATA = (ChestPainType = 'ATA');
CP_NAP = (ChestPainType = 'NAP');
ECG_LVH = (RestingECG = 'LVH');
ECG_Normal = (RestingECG = 'Normal');
Angina_Yes = (ExerciseAngina = 'Y');
Slope_Down = (ST_Slope = 'Down');
Slope_Flat = (ST_Slope = 'Flat');
label Age="age of the patient"
      Sex_Male="sex of the patient [1: male]"
      CP_ASY = "chest pain type [1: Asymptomatic]"
      CP_ATA = "chest pain type [1: Atypical Angina]"
      CP_NAP = "chest pain type [1: Non-Anginal Pain]"
      RestingBP= "resting blood pressure"
      Cholesterol= "serum cholesterol"
      FastingBS= "fasting blood sugar [1: if FastingBS > 120 mg/dl, 0: otherwise]"
      ECG_LVH= "resting electrocardiogram results [1: LVH]"
      ECG_Normal= "resting electrocardiogram results [1: Normal]"
      MaxHR= "maximum heart rate achieved"
      Angina_Yes= "exercise-induced angina [1: Yes]"
      Oldpeak= "oldpeak = ST  [Numeric value measured in depression]"
      Slope_Down= "slope of the peak exercise ST segment [1: Down]"
      Slope_Flat= "slope of the peak exercise ST segment [1: flat]"
      HeartDisease= "output class [1: heart disease, 0: Normal]";
run;

/* the repo's PROC PRINT / PROC CONTENTS / PROC FREQ checks */
proc print data=heart;
run;

proc contents data=heart;
run;

proc freq data = heart;
tables HeartDisease;
run;
