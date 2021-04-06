import sys
import copy
import heapq
import operator #for sorting lists of classes by attribute
import bitstring
import math
import numpy as np
from timeit import default_timer as timer
from datetime import timedelta

"""
The program takes in a rtf file type and compresses it to .huf using Huffman tree & prefix rule. 
Then the program decompresses the compressed file to retrieve the original file by using the previous coded Huffman tree to decode. 
There are six main methods in this program, two of them are main methods for calling compression (encode) and decompression (decode).
Notes: 
byte-read 'rb' & byte-rite 'wb' are used instead regular read & write.
padding is used to handle the case where encoded bitstring is not divisible to 8 (as in 8 bits = 1 byte).
Character map (Huffman tree) is printed in console.
Compression ratio is printed in console at the end of program.
"""

class HuffmanNode:
    """Huffman encoding tree node"""

    character = -1      #the character represented
    index = -1          #index of character (integer)
    count = -1          #character frequency (count) in the file
    left = []           #left child node
    right = []          #right child node
    code = bitstring.BitString()    #bitstring code for the character

    #constructor
    def __init__(self,character):
        self.character = character;
        self.index = int.from_bytes(self.character, sys.byteorder)
        self.count = 0

    #for printing
    def __repr__(self):
        return str("Huffman Node") + str(self.__dict__)

    #for printing
    def __str__(self):
        return str("Huffman Node") + str(self.__dict__)

    #comparison operator required for heapq comparison
    def __lt__(self, other):
        return self.count < other.count

    #print function (non-recursive)
    def print(self):
        print("Huffman Node: ")
        print("\tCharacter = ", self.character)
        print("\tIndex = ", self.index)
        print("\tCount = ", self.count)
        has_left = (self.left != [])
        has_right = (self.right != [])
        print("\tHas left child = ", has_left)
        print("\tHas right child = ", has_right)
        print("\tCode = ", self.code)


def getfilecharactercounts(filename):
    """ Read a file and count characters """

    f = open(filename,"rb")
    nodes = [];

    #for every character of interest (and then some) create a huffman node
    for i in range(0,256):
        nodes.append(HuffmanNode(bytes([i]))) #works in python 3

    #loop over file reading a character at a time and increment the count
    #of that character in the list of huffman nodes
    while True:
        c = f.read(1)
        if c:
            index = int.from_bytes(c, sys.byteorder)
            nodes[index].count += 1
        else:
            #print("End of file")
            break

    f.close()

    #mark and delete any characters that don't occur in the file
    #i.e., nodes should be as long as the number of unique characters in the file (not 256 things long)
    #Hint: Eliminate zero counts, sorting may help.

    nodes.sort(key=operator.attrgetter('count'))
    nodes = [item for item in nodes if item.count != 0]
    # for item in nodes:
    #     print(item)   #test print
    # print(len(nodes))
    return nodes


def createhuffmantree(huffmannodes):
    """ Create the huffman tree
        Using heapq functionality to build the tree from a priority queue"""

    node_heap = copy.deepcopy(huffmannodes)  #first create a copy
    heapq.heapify(node_heap)                 #create heap

    #Create the Huffman Node Tree using the Min Priority Queue (heap)
    for item in range(len(node_heap)-1):
        nodeleft = heapq.heappop(node_heap)
        noderight = heapq.heappop(node_heap)

        nodeparent = HuffmanNode(bytes([0]))
        nodeparent.count = nodeleft.count + noderight.count
        nodeparent.left = nodeleft
        nodeparent.right = noderight

        heapq.heappush(node_heap, nodeparent)

    return heapq.heappop(node_heap) #final node is the tree we want


def codehuffmantree(huffmantreenode, nodecode):
    """ Traverse Huffman Tree to produce Prefix Codes"""
    #huffmantreenode.print()
    #print("Nodecode = ", nodecode)

    if (huffmantreenode.left == [] and huffmantreenode.right == []):
        huffmantreenode.code = nodecode     #no children - assign code
    else:
        leftcode = copy.copy(nodecode)      #append 0 to left
        leftcode.append(bitstring.Bits('0b0'))
        codehuffmantree(huffmantreenode.left,leftcode)
        rightcode = copy.copy(nodecode)     #append 1 to right
        rightcode.append(bitstring.Bits('0b1'))
        codehuffmantree(huffmantreenode.right,rightcode)


def listhuffmancodes(huffmantreenode, codelist):
    """ Create a list of Prefix Codes from the Huffman Tree"""
    if (huffmantreenode.left == [] and huffmantreenode.right == []):
        codelist[huffmantreenode.index] = huffmantreenode.code
    else:
        listhuffmancodes(huffmantreenode.left,codelist)
        listhuffmancodes(huffmantreenode.right,codelist)


def huffmanencodefile(filename):
    """ Read and Encode a File using Huffman Codes"""

    counts = getfilecharactercounts(filename) #get the counts from the file

    huffmantree = createhuffmantree(counts) #create and encode the characters
    codehuffmantree(huffmantree,bitstring.BitString())

    codelist = [None]*256
    listhuffmancodes(huffmantree, codelist) #get the codes for each character

    for i in range(0,256):
        if codelist[i] != None:
            print("ascii decimal =", i, "character ", chr(i), " maps to code ", codelist[i].bin)


    #encode the file
    with open(filename, 'rb') as f:
        filecode = bitstring.BitString()
        while True:
            c = f.read(1)
            index = int.from_bytes(c, sys.byteorder)
            if c:
                filecode.append(codelist[index])
            else:
                break #eof


    #write the file
    #Write the bitstring (and any additional information necessary) to file

    #INCORRECT COMPRESSION - DO NOT USE - UNCOMMENT FOR UNDERSTANDING PURPOSE ONLY:
    #These codes write string characters "1" and "0" to encoded file instead of encoded hex byte-type data (because of 'wb' write-byte)
    #The encoded file will result in bigger size than original file
    # with open(filename + "WRONG_COMPRESSED.huf", 'wb') as coded_file:
    #     coded_file.write(bytearray(filecode.bin,"utf8"))

    def pad_encoded_text(encoded_text):
        extra_padding = 8 - len(encoded_text) % 8
        for i in range(extra_padding):
            encoded_text += "0"                     #pad at the end

        padding_information = "{0:08b}".format(extra_padding)
        encoded_text = padding_information + encoded_text   #pad at front, for retrieving info when decoding
        return encoded_text

    def get_byte_array(padded_encoded_text):
        if(len(padded_encoded_text) % 8 != 0):
            print("Encoded text not padded properly")
            exit(0)

        the_byte = bytearray()
        for i in range(0, len(padded_encoded_text), 8):
            byte = padded_encoded_text[i:i+8]
            the_byte.append(int(byte, 2))
        return the_byte

    with open(filename + "COMPRESSED.huf", 'wb') as coded_file:
        encoded_text = filecode.bin                             #bitstring
        padded_encoded_text = pad_encoded_text(encoded_text)    #padded bitstring
        byte_encoded_text = get_byte_array(padded_encoded_text) #bytearray() for passing into write()
        coded_file.write(bytes(byte_encoded_text))


    return huffmantree



def huffmandecodefile(filename, huffmantree):
    """ Decode a Huffman-Coded File"""
    # huffmantreecopy = huffmantree
    """ functions for decompression: """
    # print(huffmantree)

    def remove_padding(padded_encoded_text):
        padding_infomation = padded_encoded_text[:8]    #retrieving padding information
        extra_padding = int(padding_infomation, 2)

        padded_encoded_text = padded_encoded_text[8:]   #remove padding bits at front
        encoded_text = padded_encoded_text[:-1*extra_padding]   #removing padding bits at end

        return encoded_text

    def decode_text(encoded_text, huffmantree):
        decoded_text = ""
        current_node = huffmantree

        for bit in encoded_text:
            if bit == '0':
                current_node = current_node.left
            else:
                current_node = current_node.right

            if(current_node.left == [] and current_node.right == []):
                decoded_text += chr(current_node.index)
                current_node = huffmantree

        return decoded_text


    with open(filename, 'rb') as f:
        bitstring = ""
        while True:
            byte = f.read(1)
            if byte:
                byte = list(byte)[0]                # byte to decimal (or integer)
                bits = bin(byte)[2:].rjust(8, '0')  # decimal to bitstring. remove "0b" and adjust for enough 8 bits of 1 byte
                bitstring += bits;
            else:
                break #eof

    with open(filename + "DECOMPRESSED.rtf", 'wb') as decoded_file:
        encoded_text = remove_padding(bitstring)                    #bitsting
        decompressed_text = decode_text(encoded_text, huffmantree)  #actual ascii chars as concatenated string
        decoded_file.write(bytes(decompressed_text,"utf8"))         #string to bytes to pass in write()

    print()
    print("bits before = ", len(decompressed_text)*8, "bits")
    print("bits after = ",len(encoded_text), "bits")
    compression_ratio = len(decompressed_text)*8 / len(encoded_text)
    print("compression ratio: bits before / bits after = ", len(decompressed_text)*8, "/", len(encoded_text), "=", compression_ratio)



#main
filename="./LoremIpsumLong.rtf"

huffmantree = huffmanencodefile(filename)

huffmandecodefile(filename + "COMPRESSED.huf", huffmantree)


#Reference: https://bhrigu.me/post/huffman-coding-python-implementation/