function plotsig(signal, propwindow, len, samples)
    figure
    plot(signal)
    i=1;
    while (i<=len)
        iend=i;
        k=i;
        %count consecutive window with same value to plot
        while(k<=len)
           if(propwindow(i)==propwindow(k))
              iend = k; 
           else
               break;
           end
            k=k+1;
        end
        %i = start first window in block
        %iend = end last window in block
        if(iend~=len)
            v=[(samples*(i-1)) -1; samples*iend -1; samples*iend 1; (samples*(i-1)) 1];
        else
            %last window can be smaller than samples
            iend=length(signal)-samples*(len-1);
            v=[(samples*(i-1)) -1; samples*(len-1)+iend -1; samples*(len-1)+iend 1; (samples*(i-1)) 1];
        end
        f = [1 2 3 4];
        if(propwindow(i) == -1)
            %silence window
            patch('Faces',f,'Vertices',v,'FaceColor','white')
        else
            if(propwindow(i) == 1)
                %piano window
                patch('Faces',f,'Vertices',v,'FaceColor','red')
            else
                %other window
                patch('Faces',f,'Vertices',v,'FaceColor','green')
            end
        end
        %go to next block of winwdos
        if(i==iend)
            i=i+1;
        else
            if(iend<len)
                i=iend+1;
            else
                i=iend;
            end
        end
        %show signal in plot
        hold on;
        plot(signal,'b')
        set(gca,'color','none') 
        axis([1 length(signal) -1 1])
        title('Signal')
        grid on
    end
end