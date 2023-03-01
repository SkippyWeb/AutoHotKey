;;#z:: ;Hotkey: Win+Z (Hotkey not used; Executed from StreamDeck)

;; AutoHotKey script
;; https://www.autohotkey.com/

;; Description:
;;    This script copies settings from various programs to a single
;;    directory to enable easy backup to a NAS or Cloud service
;;    This is convenient since settings of different applications are scattered
;;    around the Windows system.
 
;; Developer
;;    Antoine van Kampen
;;    www.skippyweb.eu
;;    January 2023

;; License: GPL

;; Currently the following settings are copied:
;; **** CUBASE SETTINGS ****
;; **** WAVELAB SETTINGS ****
;; **** DORICO SETTINGS ****
;; **** PINNED APPS STARTMENU ****
;; **** CHROME BOOKMARKS ****
;; **** FILEZILLA ****
;; **** STREAMDECK ****
;; **** OBS STUDIO ****
;; **** STUDIO SETUP DROPBOX ****
;; **** X32 SETTINGS ****
;; **** Toontrack (SD3, EZBass) saves ****
;; **** nAc/nOb settings ****
;; **** bvckup settings ****
;; **** VST3 Presets ****

;;
;; First make target directory
;;
FormatTime, TimeString,, yyyy-MMM-dd
TargetDir = E:\Program Data\SettingsBackup\%TimeString%
IfNotExist %TargetDir%  
	FileCreateDir %TargetDir%
FileAppend, Backup of settings from various programs`n%TimeString%`n%TargetDir%`n,%TargetDir%\0_README.txt  ;- create README file

;;
;; Now copy all settings one-by-On
;;

;; **** CUBASE SETTINGS ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\Steinberg\Cubase 12_64
SplitPath, SourceDir, SourceDirName  ; Extract only the folder name from its full path.
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1  ;;1 indicates overwrite directory if exist
if ErrorLevel
    MsgBox Cubase 1. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".
SourceDir = C:\Users\Skippy Studio\Documents\Steinberg
SplitPath, SourceDir, SourceDirName  ; Extract only the folder name from its full path.
FileCopyDir, %SourceDir%, %TargetDir%\%SourceDirName%, 1  ;;1 indicates overwrite directory if exist
;;Sleep 5000 ;;wait for 5 seconds during copying
FileRemoveDir, %TargetDir%\%SourceDirName%\CrashDumps, 1  ;;1 for recursion (all files and subdirectories)
if ErrorLevel
    MsgBox Cubase 2. Error "%TargetDir%\%SourceDirName%\CrashDumps"


;; **** WAVELAB SETTINGS ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\Steinberg\WaveLab Pro 11
SplitPath, SourceDir, SourceDirName  ; Extract only the folder name from its full path.
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 ;1 indicates overwrite directory if exist
if ErrorLevel
    MsgBox Wavelab/ The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".


;; **** DORICO SETTINGS ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\Steinberg\Dorico 4
SplitPath, SourceDir, SourceDirName  ; Extract only the folder name from its full path.
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 ;1 indicates overwrite directory if exist
if ErrorLevel
    MsgBox Dorico. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".


;; **** PINNED APPS STARTMENU ****
SourceDir = C:\Users\Skippy Studio\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState
FileCreateDir,%TargetDir%\PinnedApps-StartMenu
FileCopy, %SourceDir%\start*.bin, %TargetDir%\PinnedApps-StartMenu, 1
if ErrorLevel
    MsgBox Pinned apps in start menu: %ErrorCount% files could not be copied.
FileAppend, Backup of settings pinned apps in Start menu`n%TimeString%`n%TargetDir%`n,%TargetDir%\0_README.txt  ;- create README file


;; **** CHROME BOOKMARKS ****
SourceDir = C:\Users\Skippy Studio\AppData\Local\Google\Chrome\User Data\Default
FileCreateDir,%TargetDir%\Chrome
FileCopy, %SourceDir%\Bookmarks, %TargetDir%\Chrome, 1
FileCopy, %SourceDir%\Preferences, %TargetDir%\Chrome, 1
if ErrorLevel
    MsgBox Chrome: %ErrorCount% files could not be copied.
FileAppend, Backup of settings pinned apps in Start menu`n%TimeString%`n%TargetDir%`n,%TargetDir%\0_README.txt  ;- create README file


;; **** FILEZILLA ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\FileZilla
SplitPath, SourceDir, SourceDirName  ; Extract only the folder name from its full path.
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 ;1 indicates overwrite directory if exist
if ErrorLevel
    MsgBox Filezilla. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".


;; **** STREAMDECK ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\Elgato
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox Streamdeck. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".


;; **** OBS STUDIO ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\obs-studio
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox obs-studio. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".
	

;; **** STUDIO SETUP DROPBOX ****
SourceDir = F:\Cloud\Dropbox\Skippy Studio\Studio Setup
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox Studio setup dropbox. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".


;; **** X32 SETTINGS ****
SourceDir = E:\Program Data\X32-Edit
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox X32. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".
	
	
;; **** Toontrack (SD3, EZBass) saves ****
SourceDir = C:\Users\Skippy Studio\Documents\Toontrack
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox Toontrack. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".


;; **** nAc/nOb settings ****
SourceDir = C:\Users\Skippy Studio\AppData\Roaming\nac
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox nAc/nOb. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".
		
		
;; **** bvckup settings ****
SourceDir = C:\Users\Skippy Studio\AppData\Local\Bvckup2
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox bvckup. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".
		
		
;; **** VST3 Presets ****
SourceDir = C:\Users\Skippy Studio\Documents\VST3 Presets
SplitPath, SourceDir, SourceDirName  
FileCopyDir %SourceDir%, %TargetDir%\%SourceDirName%, 1 
if ErrorLevel
    MsgBox VST3 Presets. The folder could not be copied, perhaps because a folder of that name already exists in "%TargetDir%".
		
		
return