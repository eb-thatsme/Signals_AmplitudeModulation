# Signals_AmplitudeModulation
In this MATLAB project, I use amplitude modulation to modulate a pair of audio signals. Project specifications are as follows:

(1) Find yourself two audio clips you would like to use for this project.  Load the audio into Matlaband then extract just the first five seconds of both signals (both should have theexactsame numberof samples; five seconds worth).  The easiest way to load audio into Matlab is with[x,fs] = audioread(filename);If the signal is in stereo (two columns) you should only use one of the columns (mono).

(2) Bandlimit (lowpass filter) the audio to 2kHz.  Using thebutter,tf, andlsimcommands thatwere used in Computer Assignment 3, create a 5th order Butterworth filter with a cutoff frequencyof  2kHz  and  use  it  to  filter  both  the  audio  clips  from  step  (1).   Bandlimiting  reduces  the  audioquality  of  the  signals  but  makes  it  so  that  we  can  use  carrier  frequencies  that  are  more  closelyspaced together (more on that later).

(3) Normalize both signals from step (2) so that each ranges between -1 and 1.  You do this bydividing each signal through by the value of its greatest sample.

(4) Add 1 to the audio signals from step (3).  This will make it so that the signals range between 0and 2.

(5) Upsample both the audio signals created in step (4).  Using theresamplecommand, changethe sampling frequency of both signals to 120kHz.  This is a necessary step because we need moresamples per second in order to support the high-frequency carrier signals that will be introducedin the next step.

(6) Using a sampling frequency of 120kHz,  create twocarriersignals.  A carrier signal is just acosine at a high frequency.  In our case, create one carrier signal at 20kHz and the other at 30kHz.Both carriers should be exactly the same number of samples as the audio signals created in step(5).  This will necessarily require you create a matching time signal, also sampled at 120kHz.

(7) Amplitude modulation: Take one of the upsampled audio signals from step (5) and dot-multiplyit with one of the carrier signals from step (6). Take the other audio signal and dot-multiply with theother carrier.  Finally, add these two products together.  This produces a signal that simultaneouslycontains two audio signals, one modulated at 20kHz and the other at 30kHz.

(8) UsemyFFTto examine the frequency content of the signal from step (7).  Do you see both ofyour audio signals?  Are they where you expect them to be?
