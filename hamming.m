% % This file performs hamming (7, 4) encoding. Decode function is called to detect any error in the transmitted signal and correct it.
% % Hamming (7, 4) Code

clear all;	clc; 

% ===============================================================================
% ======================= take input string from the user =======================
% ===============================================================================

% input data as a string and convert to binary values
system("python message_to_bin.py");

% load data from .txt file
data = load("original_message.txt")';

% convert data to multiple of 4 (for 7, 4 hamming code)
l = length(data);
nearest_num = ceil(l/4);
extra = nearest_num*4 - l;
input_data = [data zeros(1, extra)];

% generate hamming codes
fprintf("\n Generating Hamming Codes\n")
transmitted_data = encode(input_data);

% ============================================================================
% ======================= print data with single error =======================
% ============================================================================

% introduce error in transmitted signal
transmitted_error_data = addRandomError(transmitted_data);

error_data = decode_error(transmitted_error_data);
error_data = error_data(1:l);
error_data = error_data';
save -ascii received_message.txt error_data;

fprintf("\n Introducing Error in a random bit\n")
fprintf("\n Message with error         : ");
system("python bin_to_message.py");

% ================================================================================
% ======================= print data with error correction =======================
% ================================================================================ 

% decodes data 
decoded_data = decode(transmitted_error_data);
final_data = decoded_data(1:l);
save_data = final_data';
save -ascii received_message.txt save_data;

fprintf("\n Correcting error\n")
fprintf("\n Data with error correction : ")
system("python bin_to_message.py");
fprintf("\n\n")
