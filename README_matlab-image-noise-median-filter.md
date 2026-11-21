# Image Noise Removal with a Median Filter (MATLAB)

Academic project, Master of Science in GNSS, Mohammed First University (Morocco), 2021 to 2022.

## Goal
Remove salt-and-pepper noise from images and compare filter sizes. The logic is the same as outlier handling in data cleaning: only the corrupted values are replaced, using the median of their neighbours.

## Method
1. Add 15% salt-and-pepper noise to grayscale and colour images (`imnoise`).
2. Restore the images with a median filter (`medfilt2`), which replaces only the corrupted pixels with the median of their neighbours.
3. Compare 3x3, 5x5 and 7x7 filter windows on several images.
4. For colour images, process each channel separately (red, green, blue).

## Findings
- The 3x3 window left residual noise.
- The 5x5 window gave cleaner results.

## Source and credits
Code written by me. References used for syntax and examples: the official MATLAB documentation (https://fr.mathworks.com/help/matlab/) and the Image Processing Toolbox documentation for `imnoise` and `medfilt2`. The noise types, filters and MATLAB code are documented in a 31-page report (in French).

## Files
| File | Description |
|---|---|
| `src/` | MATLAB scripts (ADD FILE NAMES) |
| `images/` | Input and result images (ADD) |
| `report/` | 31-page report in French (PDF) |

## Tools
MATLAB (Image Processing Toolbox).

## Author
Hakim El Azzouzi, github.com/Hakim-elazzouzi
