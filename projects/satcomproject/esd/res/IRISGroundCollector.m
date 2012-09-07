% Mason Nixon
% November 4, 2011
% Desc: Antenna design for ground collector
clc
clear all
% Fixed parameters
c = 3e8;        % Speed of light (m/s^2)
f = 24.125e9;   % frequency in Hz. 
                % ISM band: 24.000 GHz to 24.250 GHz, center 24.125 GHz
Pt = 10e9;      % Power received given as 10 GW (pg. 5 of 9
 
% Variable Parameters
R = 20.2e6;   % Distance in meters. MEO = 20,200km, 2,000km < MEO < 35,786km
effT = 0.76;     % Antenna efficiency of transmitting antenna
effR = 0.76;     % Antenna efficiency of receiving antenna
antRadT = 100;  % Transmit antenna radius in meters
antRadR = 2512; % Receive antenna radius in meters     
 
% Calculations
areaT = pi*antRadT^2; % Effective antenna area(here we assume = physical area) m^2
areaR = pi*antRadR^2; % Effective antenna area m^2
lamda = c/f;
DmaxT = (areaT*(4*pi))/lamda^2;
DmaxR = (areaR*(4*pi))/lamda^2;
Gt = DmaxT*effT; % Antenna gain of transmitter in dBi
Gr = DmaxR*effR; % Antenna gain of receiver in dBi
dB = @(x) 10*log10(x);
Pt = dB(Pt); % Convert to dBW
Gt = dB(Gt);
Gr = dB(Gr);
CL = 9.6;       % Losses in dB
PrIdeal = Pt + Gt + Gr + 20*log10(lamda/(4*pi*R)) - CL;
% Note: The Friis transmission equation assumes a matched impedance
% condition between transmitter circuitry and transmitting antenna (i.e.
% none of Pt is reflected) and between the receiver circuitry and receiving
% antenna. It also assumes the antenna polarizations are aligned. p.470
% Wentworth Also, of course, we are in the far field of the antenna.
PrIdealW = 10^(PrIdeal/10); % Convert back to Watts
fprintf('The power received must be %3.3e Gigawatts for the given parameters.\n', PrIdealW/1e9)
