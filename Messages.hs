module Messages where

welcome :: String
welcome = "The following commands are supported: \n\
    \1. i <filename>\n\
    \2. o <filename>\n\
    \Please enter a command:"

algorithms :: String
algorithms = "Here is a list of the supported algorithms:\n\
    \1 Two-Dimensional Error Diffusion Dithering\n\
    \2 Floyd-Steinberg Dithering\n\
    \3 Jarvis, Judice, and Ninke Dithering\n\
    \4 Stucki Dithering\n\
    \5 Atkinson Dithering\n\
    \6 Burkes Dithering\n\
    \7 Sierra Dithering 1/4\n\
    \8 Sierra Dithering 1/16\n\
    \9 Sierra Dithering 1/32\n\
    \10 Ordered Dithering Bayer 4x4\n\
    \11 Ordered Dithering Bayer 8x8\n\
    \Please enter only the number of the algorithm you want to execute:"

incorrectChoice :: String
incorrectChoice = "Incorrect algorithm choice!"

incorrectOutputFilename :: String
incorrectOutputFilename = "Incorrect output file name!"

incorrectInputFilename :: String
incorrectInputFilename = "Incorrect input file name!"

success :: String
success = "Algorithm executed succesfully. You can check the output file."