%% encode: encode input bit sequence using 7, 4 hamming code
function [output_bits] = encode(input_bits)
	
	output_bits = []; % vector containing encoded bit sequence

	num_windows = length(input_bits) / 4; % assumes length to be multiple of four
	four_bit_windows = reshape(input_bits, 4, num_windows)';
				
    %   				p1  p2  p3  d1  d2  d3  d4
	encoder_matrix = [
					            0	1	1	1	0	0	0	;
	                   	1	0	1	0	1	0	0	;
	                   	1	1	0	0	0	1	0	;
	                   	1	1	1	0	0	0	1	;
	                 ];

	output_bits = mod(four_bit_windows * encoder_matrix, 2);

	output_bits = reshape(output_bits', numel(output_bits), 1)';

end