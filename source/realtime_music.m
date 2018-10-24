close all;
clear all;
clc;
%# sampling frequency in Hz
Fs = 88200;                    
samples = 8000;
seconds = input('Insert seconds of record: ');
if(seconds > 0)
    %record audio
    recorder = audiorecorder(Fs,8,1);
    disp('Start recording');
    recordblocking(recorder,seconds);
    signal = getaudiodata(recorder);
    disp('End recording');
    filename = sprintf('./Test_sound/rec%d.wav',fix(now)+fix(Fs/seconds));
    audiowrite(filename,signal,Fs);
else                           
    %use an audio from the dataset
    %Speech files
    signal = audioread('./Test_sound/nst.wav');
    %signal = audioread('./Test_sound/voce1.wav');
    %signal = audioread('./Test_sound/voce3.wav');
    %signal = audioread('./Test_sound/voce4.wav');

    %Piano files
    %signal = audioread('./Test_sound/einaudi_1.wav');
    %signal = audioread('./Test_sound/einaudi_2.wav');
    %signal = audioread('./Test_sound/bethoven.wav');

    %Note
    %signal = audioread('./Test_sound/a1.wav');
    %signal = audioread('./Test_sound/a1s.wav');
    %signal = audioread('./Test_sound/b1.wav');
    %signal = audioread('./Test_sound/c1.wav');
    %signal = audioread('./Test_sound/c1s.wav');
    %signal = audioread('./Test_sound/c2.wav');
    %signal = audioread('./Test_sound/d1.wav');
    %signal = audioread('./Test_sound/d1s.wav');
    %signal = audioread('./Test_sound/e1.wav');
    %signal = audioread('./Test_sound/f1.wav');
    %signal = audioread('./Test_sound/f1s.wav');
    %signal = audioread('./Test_sound/g1.wav');
    %signal = audioread('./Test_sound/g1s.wav'); 
    
    %Undefined
    %signal = audioread('./Test_sound/church_bell.wav');
    %signal = audioread('./Test_sound/colored_noise.wav');
    %signal = audioread('./Test_sound/birds.wav');
    %signal = audioread('./Test_sound/diner.wav');
    
    %Laboratory tests
    %signal = audioread('./Test_sound/prova.wav');
    %signal = audioread('./Test_sound/prova2.wav');
    %signal = audioread('./Test_sound/prova3.wav');
    %signal = audioread('./Test_sound/lab1.wav');
    %signal = audioread('./Test_sound/lab2.wav');
    %signal = audioread('./Test_sound/lab3medie.wav');
    %signal = audioread('./Test_sound/lab3alte.wav');
    %signal = audioread('./Test_sound/lab4.wav');
    %signal = audioread('./Test_sound/provaa3.wav');
    %signal = audioread('./Test_sound/lab5suoni.wav');
    %signal = audioread('./Test_sound/provaveloce.wav');
    %signal = audioread('./Test_sound/lab6cluster.wav');
    
    %Check size signal
    [m, n] = size (signal);
    if(n==2)
        signal(:,2)=[];
    end
end

l = fix(length(signal)/samples)+1;
peaks=zeros([l 1]);                 %array that will contain the peaks
sr=zeros([l 1]);                    %array that will contain the silence ratio
propwindow=zeros([l 1]);            %array that will be used to plot the classification
windows=1;
for i=1:length(signal)
    if(windows==l)
        sig=signal(((windows-1)*samples)+1:length(signal));
    else
        if(mod(i,samples)==0)
            sig=signal(((windows-1)*samples)+1:windows*samples);
        else
            continue;
        end
    end
    fftsig = fft(sig,Fs);                               %fft of signal
    fftsig(fix(length(fftsig)/2)+1:length(fftsig))=[];
    fftsig=abs(fftsig);
    
    %Store data
    %compute the silence ratio
    sr(windows)=silenceratio(sig, samples);             
    if(sr(windows) > 0.99) 
        %if SR is high skip next step and set number of peaks to 0  
        propwindow(windows)=-1;                             
        peaks(windows)=0;
        windows=windows+1;  
        continue;
    end
    peaks(windows)=harmonicpeaks(fftsig);                   %compute the number of peaks
    propwindow(windows)=score(peaks(windows),sr(windows));  %compute the score
    windows=windows+1;
end
plotsig(signal, propwindow, l, samples);                    %final plot with classification












