;; AutoHotKey script
;; https://www.autohotkey.com/
;; AHK V1.0

;; Description:
;;    This script copies settings from various programs to a single
;;    directory to enable easy backup to a NAS or Cloud service
;;    This is convenient since settings of different applications are scattered
;;    around the Windows system.
 
;; Developer
;;    Antoine van Kampen
;;    www.skippyweb.eu
;;    April 2023

;; License: GPL

;; Currently the following settings are copied:
;; **** HALion ****
;; **** SPECTRALAYERS ****
;; **** SONARWORKS/SOUNDID PROFILES ****


#Requires AutoHotkey v2.0 ;; See also https://www.autohotkey.com/docs/v2/Program.htm#launcher

;;
;; First make target directory
;;
;; Note: if CopySettings_1-AHK_v1.ahk  is already executed then the TargetDir 
;; and README.txt do already exist.
;;

TimeString := FormatTime(,"yyyy-MMM-dd")
TargetDir  := "E:\Program Data\SettingsBackup\" . TimeString

if not DirExist(TargetDir)
	DirCreate(TargetDir)

FileAppend "`n`nBackup of settings (AHK V2.0). `n Time: " . TimeString . "`n Target directory: " TargetDir, TargetDir . "\0_README.txt"  ;- append to README.txt file


;;
;; Now copy all settings one-by-On
;;


;; **** HALion ****
SourceDir := "C:\Users\Skippy Studio\AppData\Roaming\Steinberg"
DirCreate TargetDir  "\HALion"

Loop Files SourceDir "\HALion*", "D"
{ 
  try
	DirCopy A_LoopFilePath, TargetDir "\HALion\" A_LoopFileName, 1
  catch
    MsgBox "HALION ROAMING. An error occurred when copying the directory.`n`n" A_LoopFilePath
}

SourceDir := "C:\Users\Skippy Studio\Documents\Steinberg"
DirCreate TargetDir  "\HALion\Documents"

Loop Files SourceDir "\HALion*", "D"
{ 
  try
	DirCopy A_LoopFilePath, TargetDir "\HALion\Documents\" A_LoopFileName, 1
  catch
    MsgBox "HALION Documents. An error occurred when copying the directory.`n`n" A_LoopFilePath
}



;; **** SPECTRALAYERS ****
SourceDir := "C:\Users\Skippy Studio\AppData\Roaming\Steinberg"

Loop Files SourceDir "\SpectraLayers*", "D"
{ 
  try
	DirCopy A_LoopFilePath, TargetDir "\SpectraLayers\" A_LoopFileName, 1
  catch
    MsgBox "SPECTRALAYERS. An error occurred when copying the directory.`n`n" A_LoopFilePath
}

;;Remove the Cache directory
Loop Files TargetDir "\SpectraLayers\SpectraLayers*", "D"
{ 
  try
	DirDelete A_LoopFilePath "\Cache", 1 ;S"\" A_LoopFileName, 1
  catch
    MsgBox "An error occurred when deleting a directory.`n`n" A_LoopFilePath "\Cache"
}


;; **** SONARWORKS/SOUNDID ****
SourceDir := "C:\Users\Skippy Studio\AppData\Local\Sonarworks\SoundID Reference\Sonarworks Projects"
DirCreate TargetDir  "\SoundID"
SplitPath SourceDir, &SourceDirName  ; Extract only the directory name from its full path.
MsgBox TargetDir SourceDir SourceDirName
try
	DirCopy SourceDir, TargetDir "\SoundID\" SourceDirName, 1
  catch
    MsgBox "SoundID. An error occurred when copying the directory.`n`n" A_LoopFilePath




