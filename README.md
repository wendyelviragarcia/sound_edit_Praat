# sound_edit_Praat

> [!WARNING]  
> Make a copy of your files before using



# DESCRIPTION
This script runs through all the files in a folder and allows you to choose to:
1) convert the stereo sounds into mono
2) resample the files (notice that Praat does not resample long files)
3) normalize its intensity (scaling its peak amplitude to the maximum possible in .wav files) or adjust to new mean intensity 
4) remove noise

The script also offers you some extra options:
You can choose whether you want to rewrite the files or save the with a different name
- If you choose to save them with another name, when you click OK a window will appear asking you for a suffix 
	for the files
You can change the sampling frequency
	Yo can choose in which frequencies do you want noise to be remove. This option can be useful if the recording has a noise in
		a constant frequency.  							
# INSTRUCTIONS
			1) Open the script with Praat (Read from file...), the script will open. In the upper menu select Run and Run again. 
	2) The script standards are by default set to fulfill the requirements of the Amper06 software. So if you are working in the Amper project, 
		just write your file path. Don't worry if your files are already resampled or mono the script will not process them so it 
	won't take any longer.
	3) Mark the options you want the script to do
		4) Click OK
		The extension of the wav files must not be written in capital letters

		*Technical data: Resample, changing the number of channels and removing noise are actions that may cause the intensity to become clipped. 
				In order to warn you about it Praat has a warning window which is deactivated in this script. So my reccommendation is when you use this 
			script keep the normalize button always on. This way the peak amplitude of your files will be reduced to the maximum possible in a wav 
				and no samples will be clipped.
			



# Form
![image](screeshot.png)



