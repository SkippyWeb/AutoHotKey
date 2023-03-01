;;#z:: ;Hotkey: Win+Z (Hotkey not used; Executed from StreamDeck)

;; AutoHotKey script
;; https://www.autohotkey.com/

;; Description:
;;    This script sets the buffer size of the Behringer X32
;;    X-USB audio interface. 
;;    A specific buffer size is hard coded in the line: Control, Choose, 8


;; Developer
;;    Antoine van Kampen
;;    www.skippyweb.eu
;;    January 2023

;; License: GPL


;; https://www.autohotkey.com/board/topic/8227-can-ahk-open-those-windows-minimized-in-sys-tray/
;; First activate window from tray
Process, Exist, XUSBAudioCplApp.exe
WinShow, X-USB Control Panel ahk_pid %ErrorLevel%
WinActivate, X-USB Control Panel ahk_pid %ErrorLevel%

;; Next select buffer size
ControlFocus,SysTabControl321,X-USB Control Panel
ControlClick x100 y47, X-USB Control Panel,,,, Pos
ControlClick ComboBox1, X-USB Control Panel,,,,

;; 1 = 8    samples
;; 2 = 16   samples
;; 3 = 32   samples
;; 4 = 64   samples
;; 5 = 128  samples
;; 6 = 256  samples
;; 7 = 512  samples
;; 8 = 1024 samples
;; 9 = 2048 samples
Control, Choose, 8, ComboBox1, X-USB Control Panel,,,
ControlClick ComboBox1, X-USB Control Panel,,,,

;; Close window
WinHide, X-USB Control Panel
