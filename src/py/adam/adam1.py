#!/usr/bin/python

import random


# Encrypt a string based on a key and a given valid alphabet
def encryptMessage(plaintext, key, alphabet):
    plaintext = plaintext.lower()  # Convert to lowercase.
    ciphertext = ""  # Variable to hold new plaintext after we scan for invalid characters.
    # If the current character 'c' does not exist within 'alphabet' do not push it to 'ciphertext.'
    for c in plaintext:
        # Adam, this should be fine to use. More info. for the 'if c not in alphabet' is here:
        # http://stackoverflow.com/questions/3437059/does-python-have-a-string-contains-method
        if c not in alphabet:
            continue
        else:
            # Now we know we have a valid character. Let's get the index of that character from our alphabet string,
            # then grab the character from the matching index inside of our key string. Save that new character to our
            # ciphertext string.
            c = key[alphabet.index(c)]  # Adam, this sould also be fine to do.
            ciphertext += c
    return ciphertext


# Decrypt a string based on a key and a valid alphabet
def decryptMessage(ciphertext, key, alphabet):
    plaintext = ""  # Variable to hold plaintext after decrypting ciphertext
    # For each encrypted char. grab it's index in the key and match it up with the correct char. in alphabet
    for c in ciphertext:
        c = alphabet[key.index(c)]
        plaintext += c
    return plaintext


def makeKey(alphabet):
    alphabet_array = list(alphabet)
    random.shuffle(alphabet_array)
    alphabet = ''.join(alphabet_array)
    return alphabet

# Test encryptMessage
print(encryptMessage('Hey, this is really fun!', 'nu.t!iyvxqfl,bcjrodhkaew spzgm', 'abcdefghijklmnopqrstuvwxyz.,! '))

# Test decryptMessage
print(decryptMessage('v! zmhvxdmxdmo!nll mikbg', 'nu.t!iyvxqfl,bcjrodhkaew spzgm', 'abcdefghijklmnopqrstuvwxyz.,! '))

# Test makeKey
print(makeKey('abcdefghijklmnopqrstuvwxyz.,! '))
