#Requires AutoHotkey v2.0

;;#z:: ;Hotkey: Win+Z (Hotkey not used; Executed from StreamDeck)


;; AutoHotKey script
;; https://www.autohotkey.com/

;; Description:
;;    This script setups the Windows system for a smooth operation
;;    of Cubase.
;;    It opens the necessary programs (but not Cubase itself)
;;    It closes unused programs that run in the background (e.g., Dropbox) that
;;    are not required by may decrease Cubase performance

;;  Note:
;;    Below are several mechanisms to close applications. 

;;    This script does not terminate the LogiTune applications/processes.
;;    These applications are probably set to restart automatically from its own settings, 
;;    or the Windows startup list, or the Task Scheduler. You can try to check there and disable its auto startup

;; Developer
;;    Christoffel
;;    https://www.fiverr.com/christoffel16
;;
;;    Antoine van Kampen
;;    www.skippystudio.nl
;;    August 2025

;; License: GPL


; Relaunch as admin if not already
RunScriptAsAdmin()

;;
;; OPEN APPLICATIONS
;;
Run "E:\Programs Studio\nAc\nAc-0.4.24-win\nAc.exe"
Run "C:\Program Files\Solid State Logic\SSL 360\SSL360Gui.exe"


;;
;; CLOSE APPLICATIONS
;;

; Define lists
processNames := [
    "Skype", "PDFAnnotator", "voicemeeter", "TeamViewer_Service", "HiDriveUpdateService",
    "AnalyticsSrv", "concentr", "wfcrun32", "redirector", "SelfServicePlugin", "Receiver",
    "CoreSync", "CCXProcess", "Creative Cloud Helper", "CCLibrary", 'LogiTuneAgent', 'LogiTuneUpdater', 'DbxSvc', 'Discord'
]
cloudApps := [
    "Dropbox.exe", "HiDrive UI.exe", "HiDrive.App.exe", "HiDrive.Sync.exe", "HiDrive.Hub.exe",
    "HiDriveUpdateService.exe", "surfdrive.exe", "owncloud.exe"
]
videoConference := [
    "ms-teams.exe", "Teams.exe", "Zoom.exe", "MsixBackgroundTaskExecutor.exe", "LogiTune.exe", "LogiTuneUpdater.exe",
    "LogiTuneAgent.exe", "ChromaCam SystemTray.exe", "PsyFrameGrabberService.exe"
]
otherApps := [
    "BlackTop.exe", "SnagitCapture.exe", "SnagitEditor.exe", "Spotify.exe", "ONENOTEM.EXE", "Discord.exe"
    "bdvpnapp.exe", "bdvpnservice.exe", "PhoneExperienceHost.exe", "bvckup2.exe", 'armsvc.exe', 'AdobeIPCBroker.exe', 'Creative Cloud Helper.exe',
]
powershellKills := [
    'Get-Process "Adobe*" | Stop-Process -Force',
    'Get-Process "CCXProcess.exe" | Stop-Process -Force'
]

KillProcessesWithPowerShell(processNames)
RunWait(A_ComSpec ' /c "taskkill /F /IM Spotify.exe /T"', , 'Hide')
RunWait(A_ComSpec ' /c "sc stop TeamViewer"', , 'Hide')
RunWait(A_ComSpec ' /c "powershell -Command \"Set-Service -Name "armsvc" -StartupType Disabled; Stop-Service -Name "armsvc" -Force\""', , 'Hide')
RunWait(A_ComSpec ' /c "powershell -Command \"Set-Service -Name "armsvc" -StartupType Disabled; Stop-Service -Name "AnalyticsSrv" -Force\""', , 'Hide')
RunWait(A_ComSpec ' /c "powershell -Command \"Set-Service -Name "LogiTune" -StartupType Disabled; Stop-Service -Name "LogiTune" -Force\""', , 'Hide')
RunWait(A_ComSpec ' /c "powershell -Command \"Set-Service -Name "LogiTuneAgent" -StartupType Disabled; Stop-Service -Name "LogiTuneAgent" -Force\""', , 'Hide')

CloseProcesses(cloudApps)
CloseProcesses(videoConference)
CloseProcesses(otherApps)
RunPowerShellCommands(powershellKills)

MsgBox('All processes have been closed.')

; ============================================================================================================================================================================================
; ============================================================================================================================================================================================

; Modular functions
CloseProcesses(processList) {
    for proc in processList {
        while ProcessExist(proc) {
            ProcessClose(proc)
            if A_Index > 10 {
                MsgBox('Failed to close ' proc ' after 10 attempts. Press OK to continue.')
                break
            }
        }
    }
}

KillProcessesWithPowerShell(processList) {
    for proc in processList {
        psScript := 'Stop-Process -Name "' proc '" -Force'
        RunWait('powershell.exe -Command "' psScript '"', , 'Hide')
    }
}

RunPowerShellCommands(cmdList) {
    for cmd in cmdList {
        RunWait('powershell.exe -Command "' cmd '"', , 'Hide')
    }
}

RunScriptAsAdmin() {
	full_command_line := DllCall("GetCommandLine", "str")
	if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
	{
		try
		{
			if A_IsCompiled
				Run '*RunAs "' A_ScriptFullPath '" /restart'
			else
				Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
		}
		ExitApp
	}
}
