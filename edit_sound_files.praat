#############################################################################################################################################################
# edit_sound_files (14 February 2016)
#  resample, denoise, normalize, convert to mono.
#  fulfilling-Amper-requirements.praat (v.1.1)
#
###########################################################################################################################
#
#									DESCRIPTION
#				This script runs through all the files in a folder and allows you to choose to:
#				1) convert the stereo sounds into mono
#				2) resample the files (notice that Praat does not resample long files)
#				3) normalize its intensity (scaling its peak amplitude to the maximum possible in .wav files)
#				4) remove noise
#
#				The script also offers you some extra options:
#				You can choose whether you want to rewrite the files or save the with a different name
#					- If you choose to save them with another name, when you click OK a window will appear asking you for a suffix 
# 				for the files
#				You can change the sampling frequency
#				Yo can choose in which frequencies do you want noise to be remove. This option can be useful if the recording has a noise in
#				a constant frequency.  
#								
#									INSTRUCTIONS
# 				1) Open the script with Praat (Read from file...), the script will open. In the upper menu select Run and Run again. 
#				2) The script standards are by default set to fulfill the requirements of the Amper06 software. So if you are working in the Amper project, 
#				just write your file path. Don't worry if your files are already resampled or mono the script will not process them so it 
#				won't take any longer.
#				3) Mark the options you want the script to do
#				4) Click OK
#				The extension of the wav files must not be written in capital letters
#
#				*Technical data: Resample, changing the number of channels and removing noise are actions that may cause the intensity to become clipped. 
#				In order to warn you about it Praat has a warning window which is deactivated in this script. So my reccommendation is when you use this 
#				script keep the normalize button always on. This way the peak amplitude of your files will be reduced to the maximum possible in a wav 
#				and no samples will be clipped.
#			
#
#		comments are always welcome 
#	Wendy Elvira-Garcia
#	wendyelviragarcia@gmail.com
#	Laboratori de Fonètica (University of Barcelona)
#
#	
####################################		FORMULARIO		###################################################################################

form Fulfilling Amper requirements
	comment All the files in the folder you write in here will be processed:
	sentence Folder C:\Users\lab\Desktop\
	comment Do you want the files to be rewritten? Or saved with another name?
	choice Rewrite 1
	button Yes
	button No, save files with another name
	comment What do you want to do to the files?
	boolean Convert_to_mono 1
	boolean Resample 0
	positive new_sampling_frequency 16000
	comment The actions below take a long time for long files:
	boolean Normalize_intensity_to_peak 0
	boolean Normalize_intensity_to_mean_value_dB 1
	integer dB 70
	boolean Remove_noise 0
	
	
endform

################################################################################################################

if remove_noise = 1 or rewrite = 2

	beginPause ("More data needed")
		if rewrite = 2
			comment ("Choose a suffix for your files")
			sentence ("suffix", "_new")
		endif
		
		if remove_noise = 1
			comment ("In which range do you want to clean?")
			integer("clean_from", "80")
			integer ("clean_to", "10000")
		endif

	endPause ("OK", 1)
endif



########################################


Create Strings as file list: "list", folder$+ "/*.wav"
numberOfFiles = Get number of strings

#empieza el bucle
for ifile to numberOfFiles
	printline Working on file 'ifile'
	select Strings list
	fileName$ = Get string: ifile
	base$ = fileName$ - ".wav"
	base$ = fileName$ - ".WAV"
	
	# Lee el Sonido
	mysound= Read from file: folder$+"/"+ fileName$


	

	######################	PASA A MONO	#############################
	if convert_to_mono = 1
		selectObject: mysound
		numberOfChannels = Get number of channels

		if numberOfChannels = 2
			mysound = do ("Convert to mono")
			do ("Rename...", "'base$'")
		else 
			printline The file 'base$' was already mono.
		endif
	endif
	

	######################	CAMBIA FRECUENCIA DE MUESTREO	##############
	if resample = 1
		selectObject: mysound
		old_sampling_frequency = Get sampling frequency
		if old_sampling_frequency <> new_sampling_frequency
			mysound =Resample: new_sampling_frequency, 50
			Rename:  base$
			
		else
			printline The file 'base$' old sampling frequency is already 'old_sampling_frequency' Hz.
		endif

	endif

	######################	RUIDO	#######################################
	if remove_noise = 1
		selectObject: mysound
		mysound = do ("Remove noise...", 0, 0, 0.025, 'clean_from', 'clean_to', 40, "Spectral subtraction")
		
	endif


	######################	NORMALIZA INTENSIDAD	######################
	if normalize_intensity_to_peak = 1
		selectObject: mysound
		Scale peak: 0.99996948
	endif

	if normalize_intensity_to_mean_value_dB = 1
		selectObject: mysound
		Scale intensity: dB
	endif


	############# GUARDA ############# 
	if rewrite = 1
		selectObject: mysound
		nowarn Write to WAV file: folder$+"/"+ fileName$
	removeObject: mysound
	endif
	
	if rewrite = 2
		newbase$ = base$ + suffix$
		nowarn Write to WAV file: folder$+"/" + newbase$+ ".wav"
		removeObject: mysound
	endif
	
endfor

	############# LIMPIA ############# 
select all
Remove
echo All files processed
	