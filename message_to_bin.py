import numpy as np

string = input("\n Enter message              : ")

def str_to_bin(string):
    """ take a string and return a list of integers (1 or 0) representing that
        string in ASCII """
    ret = list(string)
    # convert to binary representation
    ret = ['{:07b}'.format(ord(x)) for x in ret]
    # split the binary into
    ret = [[bit for bit in x] for x in ret]
    # flatten it and convert to integers
    ret = [int(bit) for sublist in ret for bit in sublist]
    return ret

code = np.array([str_to_bin(string)], ndmin=1)

file = open("original_message.txt", "w")

for i in code:
    np.savetxt(file, i)

file.close()