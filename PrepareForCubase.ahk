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
;;    Below are several mechanisms to close applications. However, not All
;;    of these programs terminate for unknown reason. Might be that these were
;;    started as a Windows Service. Thus, script will be updated in the future.
;;    For services see  
;;    https://www.autohotkey.com/board/topic/32023-service-function-set-for-handling-windows-services/

;; Developer
;;    Antoine van Kampen
;;    www.skippyweb.eu
;;    January 2023

;; License: GPL


;;
;; OPEN APPLICATIONS
;;
Run, E:\Programs Studio\nAc\nAc-0.4.24-win\nAc.exe

;;
;; CLOSE APPLICATIONS
;;

For each, proc in ["Skype", 
                 , "PDFAnnotator", "voicemeeter",  
				 , "TeamViewer_Service",
                 , "HiDriveUpdateService", ;; Cloud
				 , "AnalyticsSrv", "concentr", "wfcrun32", "redirector", "SelfServicePlugin","Receiver"  ;; Citrix programs
                 , "CoreSync", "Creative Cloud Helper", "Adobe Installer", "AdobeUpdateServe", "Adobe Desktop Service", "CCXProcess", "Creative Cloud Helper", "CCLibrary"] { ;; Adobe programs
    ;;MsgBox "Process: " %each% %proc% 
	psScript =
    (
        Stop-Process -name %proc% -Confirm -PassThrue -Force
    )
	;;MsgBox %psScript%
    RunWait PowerShell.exe -Command &{%psScript%},, hide
}
;;MsgBox %Comspec%
;;Run, %Comspec% /c "taskkill /F /IM PhoneExperienceHost /T"
;;Run, %comspec% /c "taskkill /F /IM CCleaner64 /T"
;;Run, %Comspec% /c "taskkill /F /IM bdvpnService /T"
Run, %Comspec% /c "taskkill /F /IM Spotify /T"


;; ***CLOUD APPLICATIONS***

; Dropbox
Process, Close, Dropbox.exe
;;Process, Close, DropboxUpdate.exe  ;;does not close
;; Process, Close, DbxSvc.exe  ;;Dropbox Service  ;;does not close

; HiDrive Strato
Process, Close, HiDrive UI.exe
Process, Close, HiDrive.App.exe
Process, Close, HiDrive.Sync.exe
Process, Close, HiDrive.Hub.exe
Process, Close, HiDriveUpdateService.exe

; Surfdrive
Process, Close, surfdrive.exe

;; ***VIDEO CONFERENCE***
Process, Close, Teams.exec
Process, Close, Zoom.exe
Process, Close, MsixBackgroundTaskExecutor.exe ;;Skype
Process, Close, LogiTune.exe
Process, Close, LogiTuneUpdater.exe
Process, Close, LogiTuneAgent.exe
Process, Close, ChromaCam SystemTray.exe ;Chromacam
Process, Close, PsyFrameGrabberService.exe ;Chromacam;; Does not terminate

;; ***OTHER APPLICATIONS***
Process, Close, BlackTop.exe
Process, Close, SnagitCapture.exe
Process, Close, SnagitEditor.exe
Process, Close, Spotify.exe

Process, Close, ONENOTEM.EXE
Process, Close, bdvpnapp.exe
Process, Close, bdvpnservice.exe
Process, Close, PhoneExperienceHost.exe
Process, Close, bvckup2.exe 

;; ***NOT TERMINATING AT THIS MOMENT***
;;Process, Close, nvcontainer.exe ;;NVIDIA  ;;does not terminate
;;Process, Close, AdobeUpdateServe.exe
;;Process, Close, CCleaner64.exe  ;;does not terminate
;;Process, Close, CCleaner.exe  ;;does not terminate
;;Process, Close, armsvc.exe
;;Process, Close, "Adobe Installer.exe"
;;Process, Close, "Adobe Desktop Service.exe"


;;
;; SERVICES
;;

;;MsgBox % Service_List("Active")
;;MsgBox Service_State("Citrix Workspace Updater Service")
;;Service_Stop("Citrix Workspace Updater Service")


Return

