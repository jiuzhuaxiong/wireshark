;
; ethereal.nsi
;
; $Id: ethereal.nsi,v 1.6 2002/09/29 18:16:42 gerald Exp $

; ============================================================================
; Header configuration
; ============================================================================
; The name of the installer
Name "Ethereal"

; The file to write
OutFile "ethereal-setup-${VERSION}.exe"

; Icon of installer
Icon "..\..\image\ethereal.ico"

; Uninstall stuff
UninstallText "This will uninstall Ethereal. Hit 'Next' to continue."

; ============================================================================
; License page configuration
; ============================================================================
LicenseText "Ethereal is distributed under the GNU General Public License."
LicenseData "GPL.txt"

; ============================================================================
; Component page configuration
; ============================================================================
ComponentText "The following components are available for installation."

; Component check boxes
EnabledBitmap "..\..\image\nsis-checked.bmp"
DisabledBitmap "..\..\image\nsis-unchecked.bmp"

; ============================================================================
; Directory selection page configuration
; ============================================================================
; The text to prompt the user to enter a directory
DirText "Choose a directory in which to install Ethereal."

; The default installation directory
InstallDir $PROGRAMFILES\Ethereal\

; See if this is an upgrade; if so, use the old InstallDir as default
InstallDirRegKey HKEY_LOCAL_MACHINE SOFTWARE\Ethereal "InstallDir"


; ============================================================================
; Install page configuration
; ============================================================================
ShowInstDetails show



; ============================================================================
; Installation execution commands
; ============================================================================

Section "-Required"
;-------------------------------------------

;
; Install for every user
;
SetShellVarContext all

SetOutPath $INSTDIR
File "..\..\wiretap\wiretap-${WTAP_VERSION}.dll"
File "${COMMON_FILES_GNU}\iconv-1.3.dll"
File "${COMMON_FILES_GNU}\glib-1.3.dll"
File "${COMMON_FILES_GNU}\gmodule-1.3.dll"
File "${COMMON_FILES_GNU}\gnu-intl.dll"
File "${COMMON_FILES_GNU}\zlib.dll"
File "..\..\FAQ"
File "..\..\README"
File "..\..\README.win32"
File "..\..\manuf"

;
; Install the Diameter DTD and XML files in the "diameter" subdirectory
; of the installation directory.
; 
SetOutPath $INSTDIR\diameter
File "..\..\dictionary.dtd"
File "..\..\dictionary.xml"
File "..\..\mobileipv4.xml"
File "..\..\nasreq.xml"
File "..\..\sunping.xml"
SetOutPath $INSTDIR

; Write the uninstall keys for Windows
WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ethereal" "DisplayName" "Ethereal ${VERSION}"
WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ethereal" "UninstallString" '"$INSTDIR\uninstall.exe"'
WriteUninstaller "uninstall.exe"
SectionEnd

Section "Ethereal"
;-------------------------------------------
SetOutPath $INSTDIR
File "..\..\ethereal.exe"
File "..\..\doc\ethereal.html"
File "${COMMON_FILES_GNU}\gtk-1.3.dll"
File "${COMMON_FILES_GNU}\gdk-1.3.dll"
SectionEnd

Section "Tethereal"
;-------------------------------------------
SetOutPath $INSTDIR
File "..\..\tethereal.exe"
File "..\..\doc\tethereal.html"
SectionEnd

Section "Editcap"
;-------------------------------------------
SetOutPath $INSTDIR
File "..\..\editcap.exe"
File "..\..\doc\editcap.html"
SectionEnd

Section "Text2Pcap"
;-------------------------------------------
SetOutPath $INSTDIR
File "..\..\text2pcap.exe"
File "..\..\doc\text2pcap.html"
SectionEnd

Section "Mergecap"
;-------------------------------------------
SetOutPath $INSTDIR
File "..\..\mergecap.exe"
File "..\..\doc\mergecap.html"
SectionEnd


Section "Plugins"
;-------------------------------------------
SetOutPath $INSTDIR\plugins\${VERSION}
File "..\..\plugins\docsis\docsis.dll"
File "..\..\plugins\giop\coseventcomm.dll"
File "..\..\plugins\giop\cosnaming.dll"
File "..\..\plugins\gryphon\gryphon.dll"
File "..\..\plugins\mgcp\mgcp.dll"
SectionEnd

SectionDivider
;-------------------------------------------

Section "Start Menu Shortcuts"
;-------------------------------------------
CreateDirectory "$SMPROGRAMS\Ethereal"

Delete "$SMPROGRAMS\Ethereal\Ethereal Web Site.lnk"
WriteINIStr "$SMPROGRAMS\Ethereal\Ethereal Web Site.url" \
          "InternetShortcut" "URL" "http://www.ethereal.com/"
CreateShortCut "$SMPROGRAMS\Ethereal\Ethereal.lnk" "$INSTDIR\ethereal.exe"
CreateShortCut "$SMPROGRAMS\Ethereal\Ethereal Documentation.lnk" "$INSTDIR\ethereal.html"
CreateShortCut "$SMPROGRAMS\Ethereal\Uninstall.lnk" "$INSTDIR\uninstall.exe"
CreateShortCut "$SMPROGRAMS\Ethereal\Ethereal Program Directory.lnk" \
          "$INSTDIR"
SectionEnd

Section "Desktop Icon"
;-------------------------------------------
CreateShortCut "$DESKTOP\Ethereal.lnk" "$INSTDIR\Ethereal.exe"
SectionEnd

Section "Uninstall"
;-------------------------------------------
DeleteRegKey HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ethereal"
DeleteRegKey HKEY_LOCAL_MACHINE SOFTWARE\Ethereal

Delete "$INSTDIR\FAQ"
Delete "$INSTDIR\README*"
Delete "$INSTDIR\manuf"
Delete "$INSTDIR\dictionary.dtd"
Delete "$INSTDIR\dictionary.xml"
Delete "$INSTDIR\mobileipv4.xml"
Delete "$INSTDIR\nasreq.xml"
Delete "$INSTDIR\sunping.xml"
Delete "$INSTDIR\*.exe"
Delete "$INSTDIR\*.html"
Delete "$INSTDIR\*.dll"
Delete "$INSTDIR\plugins\${VERSION}\coseventcomm.dll"
Delete "$INSTDIR\plugins\${VERSION}\cosnaming.dll"
Delete "$INSTDIR\plugins\${VERSION}\docsis.dll"
Delete "$INSTDIR\plugins\${VERSION}\gryphon.dll"
Delete "$INSTDIR\plugins\${VERSION}\mgcp.dll"
Delete "$SMPROGRAMS\Ethereal\*.*"
Delete "$DESKTOP\Ethereal.lnk"

RMDir "$SMPROGRAMS\Ethereal"
RMDir "$INSTDIR\plugins\${VERSION}"
RMDir "$INSTDIR\plugins"
RMDir "$INSTDIR"

SectionEnd
