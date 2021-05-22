%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CAS 4
%Code Author: Ellisa Booker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%Clear workspace
close all;
clear;
clc;

%load in audio
[x1,fs1] = audioread('Clip1.m4a');
[x2,fs2] = audioread('Clip2.m4a');

%List of main variables
Fc = 2000;
x1 = x1(1:5*fs1); %Takes 5 second of audio x1
x2 = x2(1:5*fs2); %Takes 5 second of audio x2
t1 = (1:length(x1))/fs1; %Time signal of x1
t2 = (1:length(x2))/fs2; %Time signal of x2

%Create 5th order bandlimit/lowpass filter (Only used fs1 since fs1=fs2)
[b, a] = butter(5, Fc/(fs1/2), 'low', 's');

% Uses filter coefficients to create a transfer function
H = tf(b,a);

% Simulates the time response of our data x given the transfer function H
% This is a simulation of the filter created above
filteredData1 = lsim(H,x1,t1);
filteredData2 = lsim(H,x2,t2);

%Normalize signals
Nx1 = (x1./max(x1)) + 1;
Nx2 = (x2./max(x2)) + 1;

%Upsample the normalized signals to 2.5x original Fs rate (48k * 2.5 =120kHz) 
upNx1 = resample(Nx1, 5, 2);
upNx2 = resample(Nx2, 5, 2);

%Create 2 carrier signals with matching time signals
t1Carr = (1:length(upNx1))/120000; %Time signal of x1 upsampled
t2Carr = (1:length(upNx2))/120000; %Time signal of x2 upsampled
carr1 = cos(2 * pi * 20000 .* t1Carr);
carr2 = cos(2 * pi * 30000 .* t2Carr);

%Amplitide modulation
dotNx1Carr1 = upNx1 .* carr1';
dotNx2Carr2 = upNx2  .* carr2';
modulatedSum = dotNx1Carr1 + dotNx2Carr2;
[A,f] = myFFT(modulatedSum,120000);

%Export audio signal
n_samples = t1Carr'; %t1Carr also = t2Carr. Transposed to fit dimensions of modulated sum
x = modulatedSum;
data = [n_samples, x];
save myFile.txt data -ascii;

%% Plotting Section

% Plot the original signal with respect to time
subplot(1,5,1);
plot(t1,x1);
xlabel('time (s)');
ylabel('Original x1 signal');

% Plot the upsampled signal with respect to time
subplot(1,5,2)
plot(t2,x2);
xlabel('time (s)');
ylabel('Original x2 signal');

subplot(1,5,3);
plot(t1Carr,carr1);
xlabel('time (s)');
ylabel('Resampled x1 signal');
 xlim([2 2.002])

% Plot the upsampled signal with respect to time
subplot(1,5,4)
plot(t2Carr,carr2);
xlabel('time (s)');
ylabel('Resampled x2 signal');
 xlim([2 2.002])
 
% Plot the modulated signal with respect to frequency
subplot(1,5,5)
stem(f,abs(A));
xlabel('Frequency');
ylabel('Modulated signal');

