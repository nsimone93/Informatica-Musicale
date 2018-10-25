# Informatica-Musicale

Develop by NIGRO SIMONE and MARTINI DAVIDE under the coordination of MICHELONI EDOARDO.

Project developed for "Informatica Musicale" course. 
The professors in charge of this course are Antonio Rodà, Giovanni De Poli, Sergio Canazza of University of Padua.

GOAL: detection and classification of audio in piano or other.

INPUT: number of seconds for the recording phase, or the audio file to analyze.

OUTPUT: plot that shows classification of audio.

Features used in this project:

	- Silence Ratio (sr).
	
	- Harmonicity of signal (peaks).


sr > 0.99 

	-> Silence window
sr = high value 	  

	-> Other sound window
sr = low value
	
	-> Piano window

peaks = high value	
	
	-> Piano window
peaks = low value 	

	-> Other sound window

Features tested for this project that was not useful:

	- Zero Crossing Rate.
	- Energy.
	- Centroid.
	- Inharmonicity.
	
These features don't give information for classification of signal. There is not an evident threshold that divide piano from other sounds.

Centroid and Inhermonicity features were compute by the use of MIRtoolbox version 1.6.1. We used 'mircentroid' and 'mirinharmonicity' functions.
