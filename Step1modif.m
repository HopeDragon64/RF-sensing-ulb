% Step 1
% - Génération du pulse et affichage du graphe + TF
% - Génération et enregistrement du pulse audio

Fs = 48000;
fp = 8000;
Tp = 0.01;
n = 1024;

t = (0:n-1)/Fs;
x = cos(2*pi*fp.*t).*(t<=Tp);
figure(Name="Temporel");
plot(t,x);

f = (0:n-1)*Fs/n;
y = fft(x);
figure(Name="Fréquenciel");
plot(f,abs(y));

Y = fftshift(y);
F = Fs/n*(-n/2:n/2-1);
figure(Name="Fréquenciel centré");
plot(F,abs(Y));

% Si Tp grand -> plus "d'oscillations" et si petit -> lisse
% Si Fp trop grand, signal mal reconstitué en temporel (de même si trop petit) (à justifier/quantifier) 

nbr_rep = 100;
x_trans = repmat(x, 1, nbr_rep);

Transmitter = audioplayer(x_trans, Fs);
Receiver = audiorecorder(Fs, 16, 1);

play(Transmitter);  % Sert à entendre le son répété nbr_rep fois pour l'enregistrement (pas agréable !!)
record(Receiver);
% En mettant record avant play, on a un petit décalage au début dû au démarrage de l'audio 
% -> mieux de mettre play avant record (les 2 fonctionnent)

pause(3); % Tourne pdt 3 secondes (signal ne dure que 1024 x nbr_rep / Fs ~= 2,13s. Après ça, c'est du bruit inutile)
stop(Receiver);
stop(Transmitter);
s = getaudiodata(Receiver);

ts = (0:length(s)-1)/Fs;
figure(Name="Audio enregistré");
plot(ts,s);

