
****** README.txt *****

# Title: Find Circles Image Analysis

### Description
This code uses the Matlab package imfindcircles to identify the number and size of 
droplets in a given field of view. Code was manually adjusted and run for different 
data sets as appropriate. Included here is sample code used to analyze P700-Mg2+ 
condensates with pLL346 plasmid DNA. 


### Contributors
Written by: Ravi Chawla, PhD (rchawla@scripps.edu)
Demo data collected by Ravi Chawla, PhD & Tanxi Bai, PhD
Racki Lab, https://www.rackilab.org

Corresponding Author: Prof. Lisa Racki
Institution: The Scripps Research Institute
ORCID:0000-0003-2209-7301
Email: lracki@scripps.edu 

Published in: 
Ravi Chawla*, Jenna K. A. Tom*, Tumara Boyd, Nicholas Tu, Tanxi Bai, Danielle A. Grotjahn, 
Donghyun Park, Ashok A. Deniz, Lisa R. Racki. "Reentrant DNA shells tune polyphosphate 
condensate size."  

For use, please cite the above publication.


## Requirements (Version used)
- Matlab (R_2023a)

- Toolboxes: Image Processing, Statistics and Machine Learning


## File Overview
- ChawlaTomEtAl_2024_FindCircles.m: identifies circles & droplets 

- ChawlaTomEtAl_2024_TidyData_PostSegmentation.m: transforms output file of findcircles to tidydata format (.csv)



## HOW TO USE: 
1. Open ChawlaTomEtAl_2024_FindCircles.m and ChawlaTomEtAl_2024_TidyData_PostSegmentation.m in Matlab.
2. Locate data (demo data called FindCirclesDemoData available for download from Zenodo: DOI 10.5281/zenodo.13324260, 
and in GitHub: https://github.com/RackiLab/Chawla_and_Tom_2024_etal).
3. Move these image files (.tif files) to the same directory as the code. Image files must be 
   in a subdirectory relative to the code file. It should be okay if files are in
   directories n directories down, as long as n is at least 1 relative to 
   ChawlaTomEtAl_2024_FindCircles.m
4. Run ChawlaTomEtAl_2024_FindCircles.m. You will be prompted for inputs:
   (a) Press any number to proceed 
   (b) Enter the image number (starting at 1)
   (c) Parameter adjustment (to use defaults press 0, otherwise 1)
       If 1: set max radius (50, adjust as needed) & sensitivity (default = 0.85, adjust as needed)
5. At the end of ChawlaTomEtAl_2024_FindCircles.m will run ChawlaTomEtAl_2024_TidyData_PostSegmentation.m.
   (a) You will be prompted to accept the tidy data parameters. 
6. Code will prompt for the next image number. 


Notes: 
- If you are running the code and getting a blank return, change the line 
  Amov = dir('*.tif') to Amov = dir('**\*.tif') or dir('**/*.tif'). Amov should be a
  structured array. If Amov has dimensions nx0 (instead of nx1), the code is having
  trouble locating the image files. 
- Rerunning code for the same file name will overwrite old files/directories


