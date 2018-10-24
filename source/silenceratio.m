function sr=silenceratio(signal, samples)
    %Silence Ratio
    %classified as silence if amplitude close to 0
    silenceratio = find((abs(signal))<0.01, samples, 'first');
    %number of silent windows/number of total windows
    sr = length(silenceratio)/length(signal);           
end