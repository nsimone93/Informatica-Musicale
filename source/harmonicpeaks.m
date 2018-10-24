function peaks=harmonicpeaks(fftsig)
    %Harmonic peak
    pks = findpeaks(fftsig);                      %find all peaks
    max_valuepks=max(pks)*0.5;                    %peak of fundamental frequency = highest peak/2
    idmax_pks=find(pks>=max_valuepks,1,'first');  %find index of fundamental frequency
    peaks = 1;
    minv=0.95;                                    %sets a neighborhood in which to search for harmonics
    maxv=1.05;
    %analyze one peak at a time, verifying if it is a multiple of the fundamental
    for t=idmax_pks+1:length(pks)                 
        val_pks = pks(t);
        if(val_pks<(max_valuepks*0.01))           %if the peak is low, don't analyze it
            continue;
        end
        if(minv>0.93)                             %update neighborhood in which to search for harmonic
            if(t < 300) 
                minv=0.97;
                maxv=1.03;
            else
                if(t < 400) 
                minv=0.955;
                maxv=1.045;
                else
                    if(t < 500) 
                    minv=0.94;
                    maxv=1.06;
                    else
                        minv=0.92;
                        maxv=1.08;
                    end
                end
            end
        end
        %if the peak is multiple of the fundamental and therefore present in the neighborhood select it
        if(((t/idmax_pks) / fix(t/idmax_pks) >= minv)  && ((t/idmax_pks) / fix(t/idmax_pks) <= maxv))
            if(t<25)
                numel=1;        
            else
                numel=fix((maxv-minv)*t)-1;
            end
            out = 0;
            maxv=fix(maxv*t);
            if(maxv> length(pks))
                endfor = length(pks);
            else
                endfor = maxv;
            end
            minv=fix(minv*t);
            if(minv==endfor)
                continue;
            end
            %verify that the neighboring peaks are low
            for j=minv:endfor
                if(j==idmax_pks)
                    continue;
                end
                if(pks(j)>0.2*val_pks)
                    out = out +1;
                    if(out/numel >= 0.2)
                        break;
                    end
                end
            end
            %if at least 80% are low then the peak counts
            if(out/numel < 0.2)
                peaks=peaks+1;
                if(peaks>4)
                    break;
                end
            end
        end
    end
end 