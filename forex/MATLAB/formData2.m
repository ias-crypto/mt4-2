close all;clear;clc;
format bank;

%%
[YMD2003, HHMM2003, O2003, H2003, L2003, C2003, V2003] = read_csv('GU_H1\GBPUSD_H1_2003.csv');
[YMD2004, HHMM2004, O2004, H2004, L2004, C2004, V2004] = read_csv('GU_H1\GBPUSD_H1_2004.csv');
[YMD2005, HHMM2005, O2005, H2005, L2005, C2005, V2005] = read_csv('GU_H1\GBPUSD_H1_2005.csv');
[YMD2006, HHMM2006, O2006, H2006, L2006, C2006, V2006] = read_csv('GU_H1\GBPUSD_H1_2006.csv');
[YMD2007, HHMM2007, O2007, H2007, L2007, C2007, V2007] = read_csv('GU_H1\GBPUSD_H1_2007.csv');
[YMD2008, HHMM2008, O2008, H2008, L2008, C2008, V2008] = read_csv('GU_H1\GBPUSD_H1_2008.csv');
[YMD2009, HHMM2009, O2009, H2009, L2009, C2009, V2009] = read_csv('GU_H1\GBPUSD_H1_2009.csv');
[YMD2010, HHMM2010, O2010, H2010, L2010, C2010, V2010] = read_csv('GU_H1\GBPUSD_H1_2010.csv');
[YMD2011, HHMM2011, O2011, H2011, L2011, C2011, V2011] = read_csv('GU_H1\GBPUSD_H1_2011.csv');
[YMD2012, HHMM2012, O2012, H2012, L2012, C2012, V2012] = read_csv('GU_H1\GBPUSD_H1_2012.csv');
[YMD2013, HHMM2013, O2013, H2013, L2013, C2013, V2013] = read_csv('GU_H1\GBPUSD_H1_2013.csv');
[YMD2014, HHMM2014, O2014, H2014, L2014, C2014, V2014] = read_csv('GU_H1\GBPUSD_H1_2014.csv');


YMD = [YMD2003', YMD2004', YMD2005', YMD2006', YMD2007', YMD2008', YMD2009', YMD2010', YMD2011', YMD2012', YMD2013', YMD2014'];
HHMM = [HHMM2003', HHMM2004', HHMM2005', HHMM2006', HHMM2007', HHMM2008', HHMM2009', HHMM2010', HHMM2011', HHMM2012', HHMM2013', HHMM2014'];
O = [O2003', O2004', O2005', O2006', O2007', O2008', O2009', O2010', O2011', O2012', O2013', O2014'];O=O';
H = [H2003', H2004', H2005', H2006', H2007', H2008', H2009', H2010', H2011', H2012', H2013', H2014'];H=H';
L = [L2003', L2004', L2005', L2006', L2007', L2008', L2009', L2010', L2011', L2012', L2013', L2014'];L=L';
C = [C2003', C2004', C2005', C2006', C2007', C2008', C2009', C2010', C2011', C2012', C2013', C2014'];C=C';
V = [V2003', V2004', V2005', V2006', V2007', V2008', V2009', V2010', V2011', V2012', V2013', V2014'];V=V';

%% splt to train and test data
oriLen = length(YMD);
trainPercent = 0.9;
trainLen = round(oriLen*trainPercent);
testLen = oriLen-trainLen;

train_ymd  = YMD(1:trainLen);
train_hhmm = HHMM(1:trainLen);
train_o    = O(1:trainLen);
train_h    = H(1:trainLen);
train_l    = L(1:trainLen);
train_c    = C(1:trainLen);
train_v    = V(1:trainLen);

test_ynd  = YMD(trainLen+1:trainLen+testLen);
test_hhmm = HHMM(trainLen+1:trainLen+testLen);
test_o    = O(trainLen+1:trainLen+testLen);
test_h    = H(trainLen+1:trainLen+testLen);
test_l    = L(trainLen+1:trainLen+testLen);
test_c    = C(trainLen+1:trainLen+testLen);
test_v    = V(trainLen+1:trainLen+testLen);

%% clear no use data
clear YMD HHMM O H L C V;
clear YMD2003 HHMM2003 O2003 H2003 L2003 C2003 V2003;
clear YMD2004 HHMM2004 O2004 H2004 L2004 C2004 V2004;
clear YMD2005 HHMM2005 O2005 H2005 L2005 C2005 V2005;
clear YMD2006 HHMM2006 O2006 H2006 L2006 C2006 V2006;
clear YMD2007 HHMM2007 O2007 H2007 L2007 C2007 V2007;
clear YMD2008 HHMM2008 O2008 H2008 L2008 C2008 V2008;
clear YMD2009 HHMM2009 O2009 H2009 L2009 C2009 V2009;
clear YMD2010 HHMM2010 O2010 H2010 L2010 C2010 V2010;
clear YMD2011 HHMM2011 O2011 H2011 L2011 C2011 V2011;
clear YMD2012 HHMM2012 O2012 H2012 L2012 C2012 V2012;
clear YMD2013 HHMM2013 O2013 H2013 L2013 C2013 V2013;
clear YMD2014 HHMM2014 O2014 H2014 L2014 C2014 V2014;

FFT_N = 1024;
if trainLen < FFT_N || testLen < FFT_N
    fprintf('input original data length err.\n');
end

realTrainLen = trainLen - FFT_N;
real_train_o = zeros(realTrainLen, FFT_N);
real_train_h = zeros(realTrainLen, FFT_N);
real_train_l = zeros(realTrainLen, FFT_N);
real_train_c = zeros(realTrainLen, FFT_N);

filtPercent=0.90;
fftFiltLen = round(filtPercent*FFT_N);
fftFiltRange = round((FFT_N-fftFiltLen)/2)+1: ...
               round(FFT_N-(FFT_N-fftFiltLen)/2);
fftFiltRec = ones(FFT_N,1);
fftFiltRec(fftFiltRange) = 0;

% fftFiltGas = zeros(FFT_N,1);
% r=20;
% sigma = 20;                         
% fftFiltGas(1:r+1) = exp(-(1:r+1).^ 2 / (2 * sigma ^ 2)); 
% fftFiltGas(end-r+1:end) = fliplr(fftFiltGas(2:r+1));
lev=5;
for i=1:realTrainLen
    % time start at train_o(1024)
%     fftTmp = fft(train_o(i:i+FFT_N-1), FFT_N);
%     real_train_o(i,:) = ifft(fftTmp.*fftFiltRec, FFT_N);
    
%     real_train_o(i,:)=wden(train_o(i:i+FFT_N-1),'heursure','s','one',lev,'sym8');  
%     real_train_o(i,:)=wden(train_o(i:i+FFT_N-1),'heursure','s','sln',lev,'sym8'); 
    real_train_o(i,:)=wden(train_o(i:i+FFT_N-1),'sqtwolog','s','sln',lev,'sym8'); 


    fftTmp = fft(train_h(i:i+FFT_N-1));
    fftTmp(fftFiltRange)=0;
    real_train_h(i,:) = real(ifft(fftTmp));
    
    fftTmp = fft(train_l(i:i+FFT_N-1));
    fftTmp(fftFiltRange)=0;
    real_train_l(i,:) = real(ifft(fftTmp));
    
    fftTmp = fft(train_c(i:i+FFT_N-1));
    fftTmp(fftFiltRange)=0;
    real_train_c(i,:) = real(ifft(fftTmp));
end

%% Train FFT
filtPercent=0.8;
fftFiltLen = round(filtPercent*trainLen);
fftFiltRange = round((trainLen-fftFiltLen)/2) : ...
               round(trainLen-(trainLen-fftFiltLen)/2);
fftTmp = fft(train_o);
fftTmp(fftFiltRange)=0;
train_o = real(ifft(fftTmp));

fftTmp = fft(train_h);
fftTmp(fftFiltRange)=0;
train_h = real(ifft(fftTmp));

fftTmp = fft(train_l);
fftTmp(fftFiltRange)=0;
train_l = real(ifft(fftTmp));

fftTmp = fft(train_c);
fftTmp(fftFiltRange)=0;
train_c = real(ifft(fftTmp));

%% Test FFT
filtPercent=0.8;
fftFiltLen = round(filtPercent*testLen);
fftFiltRange = round((testLen-fftFiltLen)/2) : ...
               round(testLen-(testLen-fftFiltLen)/2);
fftTmp = fft(test_o);
fftTmp(fftFiltRange)=0;
test_o = real(ifft(fftTmp));

fftTmp = fft(test_h);
fftTmp(fftFiltRange)=0;
test_h = real(ifft(fftTmp));

fftTmp = fft(test_l);
fftTmp(fftFiltRange)=0;
test_l = real(ifft(fftTmp));

fftTmp = fft(test_c);
fftTmp(fftFiltRange)=0;
test_c = real(ifft(fftTmp));

%% ȥ��С������
train_o = train_o * 100000;
train_h = train_h * 100000;
train_l = train_l * 100000;
train_c = train_c * 100000;

test_o = test_o * 100000;
test_h = test_h * 100000;
test_l = test_l * 100000;
test_c = test_c * 100000;

%% ����
PRD = 5;
dim = 6;

%% 
fprintf('����ѵ������:\n');
saveData(train_h, train_l, train_c, PRD, dim, trainLen, ...
         'trainImages', 'trainLabels');

fprintf('\n������������:\n');
saveData(test_h, test_l, test_c, PRD, dim, testLen, ...
         'testImages', 'testLabels');










