%%Case 1
M = 1;
N = 200;
A = 1;
om_1 = pi/20;
om_21= pi/40;%guessed
om_22 = pi/60;%guessed
om_23 = pi/80;%guessed
Fs =20000; %sampling rate
fftLength = 256; % hack for now
freq = (0:fftLength-1).*(Fs/fftLength);
phi_1 = 90;
phi_21 = 180;
phi_22 = 270;
phi_23 = 45;
noise_std = 0.1047; %noise std deviation hack
%What is NF? Noise figure?
NF = 256;

n_vect =1: N ;
freq_bin = freq(2) - freq(1);
% Signal 1: single sinusoid + noise
x1 = A * cos ( om_1 * n_vect + phi_1 )+ noise_std * randn ( size ( n_vect ));
% Frequency estimation :
X1 =( abs ( fft ( x1 , NF )).^2)/ N ; % Periodogram of signal 1 ( up to scale 1/ N )
% ML frequency estimation
[~ , p1 ]= max ( X1 (1: end /2)); % Maximization ( rough )
% eom1 = freq ( p1 );
% Parabolic interpolation for refined freq . estimation
num1 = X1 ( p1 -1) - X1 ( p1 +1);
den1 = X1 ( p1 -1)+ X1 ( p1 +1) -2* X1 ( p1 );
eom1 = freq ( p1 )+.5* num1 / den1 * freq_bin ;
% Amplitude estimation :
% Projection onto the sine and the cosine ( of estimated frequency )
c1 = cos ( eom1 * n_vect );
s1 = sin ( eom1 * n_vect );
theta1 =[(2/ N)* dot(c1,x1),(2/ N)* dot(s1,x1)];
% ML amplitude estimation
eA1 = norm ( theta1 );
% Signal 2: two sinusoids + noise
x2 = A * cos ( om_21 * n_vect + phi_21 )+ A * cos ( om_22 * n_vect + phi_22 )+...
noise_std * randn ( size ( n_vect ));
% Frequency estimation :
X2 = abs ( fft ( x2 , NF )).^2; % Periodogram of signal 2 ( up to scale 1/ N )
% Signal 3: 3 sinusoids + noise
x3 = A * cos ( om_21 * n_vect + phi_21 )+ A * cos ( om_22 * n_vect + phi_22 )+...
+ A * cos ( om_23 * n_vect + phi_23 ) + noise_std * randn ( size ( n_vect ));
% ML frequency estimation
[~ , p2 ]= findpeaks ( X2 (1: end /2) , 'SortStr' , 'descend' );
eom_21 = freq ( p2 (1));
eom_22 = freq ( p2 (2));
% Amplitude estimation :
% Projection onto the sine and the cosine ( of estimated frequencies )
c_21 = cos ( eom_21 * n_vect );
s_21 = sin ( eom_21 * n_vect );
c_22 = cos ( eom_22 * n_vect );
s_22 = sin ( eom_22 * n_vect );
theta_21 =[(2/ N )* dot(c_21 , x3) ,(2/ N )* dot( s_21 , x2 )];
theta_22 =[(2/ N )* dot(c_22 , x3) ,(2/ N )* dot( s_22 , x2 )];
% ML amplitude estimation
eA_21 = norm ( theta_21 );
eA_22 = norm ( theta_22 );