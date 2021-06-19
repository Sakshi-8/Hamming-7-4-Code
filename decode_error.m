%% decode: decode received bit sequence and detect and correct any error
function [output_vector] = decode_error(input_vector)
	
	output_vector = [];
	number_of_windows = numel(input_vector) / 7;


	seven_bit_windows = reshape(input_vector, 7, number_of_windows)';

	%				    p1  p2  p3  d1  d2  d3  d4
	decoder_matrix = [
						0	0	0	1	0	0	0	;
						0	0	0	0	1	0	0	;
						0	0	0	0	0	1	0	;
						0	0	0	0	0	0	1	;
					 ];

	% [ 1 0 0 ; 0 1 0 ; 0 0 1; 0 1 1 ; 1 0 1 ; 1 1 0 ; 1 1 1; ] 
	% [4, 2, 1, 3, 5, 6, 7]

	result_vector = mod(decoder_matrix * seven_bit_windows', 2)';
	result_vector = result_vector';
	result_vector = reshape(result_vector, 1, number_of_windows*4);

	output_vector = result_vector;
end
