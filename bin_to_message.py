import numpy as np
from math import floor

def bin_to_str(binary):
    """ take a list of binary (integer ones and zeros) and return its ascii
        string representation """
    output = []
    for i in range(floor(len(binary)/7)):
        start = i * 7
        char = binary[start:start+7]
        char = '0b' + ''.join([str(c) for c in char])
        output.append(int(char, 2))

    st = ''.join([chr(o) for o in output])
    return str(st)

file = open("received_message.txt", "r")

code = file.read()
code = code.split('\n')
code = code[0:-1]

for i in range(len(code)):
    code[i] = code[i][1:2]
    code[i] = int(code[i])

final_message = bin_to_str(code)
print(final_message)

file.close()