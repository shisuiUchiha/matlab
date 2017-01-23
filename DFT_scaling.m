function dft_magnitude = DFT_scaling( dft_output )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dft_output = fftshift(dft_output);
dft_phase = angle(dft_output);
dft_magnitude = abs(dft_output);            
dft_magnitude = 10*log(dft_output+1);
%imshow(dft_phase)
end

