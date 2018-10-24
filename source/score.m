function proptot=score(peaksnow, srnow)
%Check type of sound
flag = 0;
maxflag = 4;                            %maximum score expected

if(srnow<0.35) 
    flag = flag+2;                      %if low silence ratio is probably piano
end

if(peaksnow==2)  
    flag = flag + 1;                    %if high number of peaks is probably piano
else
    if(peaksnow>2)
        flag = flag + (peaksnow*2);     %if high number of peaks is piano
    end
end

if(flag>maxflag)                        %if the score has exceeded the limit set to the maximum value
        flag=maxflag;
end

proptot = flag*100/(maxflag);           %compute the probability of classification as a piano

%{
propwindow:
    -1 silence
    1 piano
    2 voice
%}
if(proptot>50)                          %if the probability is greater than 50 ranking as a piano
    proptot=1;
else
    proptot=2;                          %otherwise as other sound
end





