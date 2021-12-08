clear all
clc

%%
fs=500e6; %Sampling frequency of the signals (500 MHz, high enough to consider the signal almost continuous)
ts=1/fs;  %Sampling time, the inverse of sampling frequency
t=[0:ts:0.03e-3]; %time axis
f1=682.5e3; %input frequency 1
f2=227.5e3; %input frequency 2
phase=0; %the phase shift (can be zero, pi, pi/2...MATLAB wants it in radians)
sig2=cos(2*pi*f1.*t);
sig1=cos(2*pi*f2.*t+phase);
figure
title('The two inputs in time domain')
plot(t,sig1,'LineWidth',1)
hold on
plot(t,sig2,'color',[1,0.5,0.5],'LineWidth',1)
xlabel('Time [s]'); ylabel('Amplitude')
legend('sig1','sig2')

nfft=2.^nextpow2(length(sig2))*16; %Length of the FFT
sig1f=fft(sig1,nfft);
sig2f=fft(sig2,nfft);
faxis=linspace(-fs/2,fs/2,length(sig1f));
grid minor

figure
plot(faxis,fftshift(abs(sig1f)),'LineWidth',1)
hold on
plot(faxis,fftshift(abs(sig2f)),'LineWidth',1,'color',[1,0.5,0.5])
xlim([0 1e6])
title('The two inputs in frequency domain')
xlabel('Frequency [Hz]'); ylabel('Amplitude')
legend('sig1','sig2')
grid minor

%%
vt=0.7; %A general value for the Vt of the diode, say 0.7 V, not crucial here
siglin=(sig1+sig2)./vt/2; %linear term of Taylor series approximation
sigsquare=((sig1+sig2).^2)./8/vt; %square term of Taylor series approximation
sigdiode=siglin+sigsquare; %sum them as Taylor series
figure
plot(t,sigdiode,'LineWidth',1,'color',[1,0.5,0.5])
title('The approx diode output in time domain')
xlabel('Time [s]'); ylabel('Amplitude')
grid minor

sigdiodef=fft(sigdiode,nfft);
figure
plot(faxis,fftshift(abs(sigdiodef)),'LineWidth',1,'color',[1,0.5,0.5])
xlim([0 2e6])
title('The approx diode output in frequency domain')
xlabel('Frequency [Hz]'); ylabel('Amplitude')
grid minor


