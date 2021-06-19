%% decode: decode received bit sequence and detect and correct any error
function [output_vector] = decode(input_vector)
	
	output_vector = [];
	number_of_windows = numel(input_vector) / 7;


	seven_bit_windows = reshape(input_vector, 7, number_of_windows)';

	% q = 1
	% seven_bit_windows
	% seven_bit_windows(2, q) = not(seven_bit_windows(2, q))
	
	%				   p1  p2  p3  d1  d2  d3  d4
	decoder_matrix = [
						1	0	0	0	1	1	1	;
						0	1	0	1	0	1	1	;
						0	0	1	1	1	0	1	;
					 ];

	% [ 1 0 0 ; 0 1 0 ; 0 0 1; 0 1 1 ; 1 0 1 ; 1 1 0 ; 1 1 1; ] 
	% [4, 2, 1, 3, 5, 6, 7]

	result_vector = mod(decoder_matrix * seven_bit_windows', 2)';

	result_vector = result_vector * [4 ; 2 ; 1]; % summing all elements

	result_vector(result_vector == 4) = 9;
	result_vector(result_vector == 1) = 11;
	result_vector(result_vector == 3) = 12;

	result_vector = mod(result_vector, 8);

	seven_bit_windows = [ones(size(seven_bit_windows, 1), 1) seven_bit_windows]; % adding 1 column at start

	result_vector = [(0:8:rows(result_vector)*8-1)' result_vector];
	result_vector = result_vector * [1 ; 1]; % summing row and column

	padded_data = reshape(seven_bit_windows', numel(seven_bit_windows), 1)';
	padded_data(result_vector' + 1) = not(padded_data(result_vector' + 1));
	padded_data = reshape(padded_data, 8, numel(padded_data) / 8)';

	padded_data = padded_data(:, 5:end);


	output_vector = reshape(padded_data', numel(padded_data), 1)';
end
