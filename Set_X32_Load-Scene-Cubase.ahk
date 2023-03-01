;;#z:: ;Hotkey: Win+Z (Hotkey not used; Executed from StreamDeck)

;; AutoHotKey script
;; https://www.autohotkey.com/

;; Description:
;;    This script loads a specific Scene into the Behringer X32 digital mixer.
;;    This script makes use of the X32 command line utilities developed by Patrick Maillot
;;    https://sites.google.com/site/patrickmaillot/x32
;;    It takes a *.scn file that was previously saved on your computer as input. This file can 
;;    be generated with the tool X32GetScene.exe or with the X32-Edit.exe application.

;;  Note: 
;;    The transfer of a Scene to the X32 takes much longer than transfering the same Scene
;;    using X32-Edit.exe. However, X32-Edit cannot be auotmated since none of its controls are
;;    exposed to AutoHotKey.

;; Developer
;;    Antoine van Kampen
;;    www.skippyweb.eu
;;    January 2023

;; License: GPL


;; If you prefer, you can also start X32-Edit. But this will not reflect the Scene send to the X32.
;; This requires synchronisation from within the X32-Edit (Mixer -> PC)

;;Run, E:\Programs Studio\Behringer\X32-Edit\X32-Edit.exe

;; Load the Scene that is used for mixing in Cubase
Run, %ComSpec% /c ""E:\Programs Studio\Behringer\X32SetScene.exe" "-i" "192.168.178.28"  <"E:\Program Data\X32-Edit\X32-Cubase-7jan2023.scn""

return