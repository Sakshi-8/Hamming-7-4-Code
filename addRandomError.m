%% addRandomError: randomly flip one bit in the encoded sequence 
function [output_vector] = addRandomError(input_vector)
	
	input_size = length(input_vector);
	output_vector = [];
	number_of_windows = numel(input_vector) / 7;

	seven_bit_windows = reshape(input_vector, 7, number_of_windows)';

	data_matrix = seven_bit_windows(:, 4:end);
	error_location = floor(rand(1)*numel(data_matrix))+1;
	data_matrix(error_location) = not(data_matrix(error_location));
	seven_bit_windows(:, 4:end) = data_matrix;

	output_vector = reshape(seven_bit_windows', 1, input_size);

end