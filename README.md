# HaskellDithering
### Description
##### A project that executes the following dithering algorithms only on PGM and PPM file formats: 
 - Two-Dimensional Error Diffusion Dithering
 - Floyd-Steinberg Dithering
 - Jarvis, Judice, and Ninke Dithering
 - Stucki Dithering
 - Atkinson Dithering
 - Burkes Dithering
 - Sierra Dithering 1/4
 - Sierra Dithering 1/16
 - Sierra Dithering 1/32
 - Ordered Dithering Bayer 4x4
 - Ordered Dithering Bayer 8x8

### Error Difusion Algorithm
 - Let's look at Floyd-Steinberg's algorithm for error diffusion.
 We have the following error diffusion pattern:
```
     X    7/16
3/16 5/16 1/16
```
 - Now let's find a matrix **NxM**, with smallest **N** and **M** possible, in which we can fit the error pattern, filling the gaps and the current element with **0**.
```
0    0   7/16
3/16 5/16 1/16
```
 - This matrix we will call the **error matrix**.
 - For the next step let's take for granted that we have an image with **WxH** dimensions, where **W** means **width** and **H** means **height**.
 - Here comes the explanation of the most important part of the algorithm used to dither by an **error matrix**.
 - Let's say we have the following row of an image, where each number represents a pixel's value from **0** to **255** in **grayscale**:
```
16 0 96 0 0 16
```
 - In the next step we are going to calculate an **extended error matrix** for each value of this row as follows:
 
```
0    0   7/16       ->  0          (7 * 1)/16 0 0 0 0
3/16 5/16 1/16      ->  (5 * 1)/16 (1 * 1)/16 0 0 0 0
```

```
0    0   7/16       ->  0           0         (7 * 7)/16 0 0 0
3/16 5/16 1/16      ->  (3 * 7)/16 (5 * 7)/16 (1 * 7)/16 0 0 0
```
 - We multiply every element of the matrix by **7**, since it came from the previous calculation at this position because the formula is - current value + (**error matrix** !! current row !! current col) 
 - This process of **error matrix extension** to (number of rows used in the error diffusion pattern)x**W**, where **W** is the width of the image and error calculation is repeated until the whole row is processed.
 - The result **error matrix** from the above example should be:
```
0 7  3  43 18 7
6 21 38 22 11 8
```
 - After we've calculated the whole **error matrix** we process the first row of the image and calculate the first row of the new image. 
   Then we remove the first row of the **error matrix**, since it has been processed, and append at the end of the matrix another row with **0** only.
 - The same process is repeated for every row of the original image.