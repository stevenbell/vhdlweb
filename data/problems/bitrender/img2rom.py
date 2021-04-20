#! /usr/bin/env python3

# Convert an image to an ASCII bin file
# Steven Bell <sbell@ece.tufts.edu>

# You'll need the pillow library to read images
# And Numpy to manipulate the image as a matrix
from PIL import Image
import numpy as np

outfile = open('rom.bin', 'w')

# Open the input image and convert it to a Numpy array
# The input image should generally be a power of 2 in width/height
img = np.asarray(Image.open('greatjob.png'))

# Iterate through all the pixels
for row in range(img.shape[0]):
  for col in range(img.shape[1]):
    # Convert the pixel data (which is 8 bits for each of R/G/B) into our
    # format for the ROM.  This code just does a simple threshold: if the input
    # pixel is "bright", then make the output pixel 1.  Otherwise, 0.
    if sum(img[row][col][0:2]) > 250:
      pixel = 0
    else:
      pixel = 1
    # Write each pixel as a binary digit
    outfile.write(str(pixel))
    if (col+1) % 8 == 0:
      # Newline after every 8 bits
      outfile.write('\n')

# All done!
outfile.close()

