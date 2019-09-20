@echo off
REM YS 13/05/2019 V02
REM GPO installation de sketchup 2017-x64 à l'arret des machines
REM Attention prérequis :
REM dot net 4.7
REM microsoft visual c++ 2015 X64 redistribuable
REM KB2999226 x64 pour Windows 7, 8 or 8.1


REM Lance l'install en superadmin
set __COMPAT_LAYER=RunAsAdmin

REM clef du registre de la GPO ou se trouve les fichiers ATTENTION à changer par a clef de votre GPO
set CLEFREGISTRE={49A0B2AC-7DA3-4B23-B0F2-B20E37177C75}
REM Chemin Source de la GPO ou sont stockés les fichiers de SketchUp 2017-X64
set SOURCE=\\col-0310084y01.local\SysVol\col-0310084y01.local\Policies\%CLEFREGISTRE%\Machine\Scripts\Shutdown


REM Destination sur le pc local repertoire ou sketchup doit etre installé ATTENTION c'est le repertoire par defaut
REM "C:\Program Files\SketchUp\SketchUp 2017\"
set DESTINATION=C:\"Program Files"\SketchUp\"SketchUp 2017"

IF NOT EXIST %DESTINATION% GOTO :INSTALLSKETCHUP

IF EXIST %DESTINATION% GOTO :INSTALLPLUGINS

GOTO :END

:INSTALLSKETCHUP
REM On installe les KB prerequis livres avec sketchup2017
%Source%\SketchUpPrerequisites\InstallPrerequisites.exe

ECHO Installe sketchupmake-2017-2-2555-90783-fr-x64.exe en mode silencieux VERYSILENT et on log SSI il n'est pas deja present sur le pc local
ECHO -----------------------------
msiexec /i %SOURCE%\SketchUp2017-x64.msi /qn /log %source%\log\%COMPUTERNAME%_DEBUG.txt
ECHO  ----------------------------

REM --------------------nettoyage du bureau public-------------------
REM del "C:\Users\Public\Desktop\SketchUp 2016.lnk"

REM "C:\Program Files\SketchUp\SketchUp 2017\LayOut\LayOut.exe"
del "C:\Users\Public\Desktop\LayOut 2017.lnk"

REM del "C:\Users\Public\Desktop\Style Builder 2017.lnk"
del "C:\Users\Public\Desktop\Style Builder 2017.lnk"

REM ----------------------------------------------------------------

:INSTALLPLUGINS
REM ----- DEBUT Instalation des PLUGINS sketchups ------
REM Destination sur le pc local ou les plugins sketchup doit etre copiés ATTENTION c'est le repertoire par defaut
set SOURCEPLUGINS=\\col-0310084y01.local\SysVol\col-0310084y01.local\Policies\%CLEFREGISTRE%\Machine\Scripts\Shutdown\PLUGINS

REM Destination sur le pc local ou les plugins sketchup doivent etre copiés ATTENTION c'est le repertoire par defaut
set DESTINATIONPLUGINS=C:\"Program Files"\SketchUp\"SketchUp 2017"\ShippedExtensions

REM On copy le repertoire des plugins du serveur01 via la GPO dans le rep local C:\Program Files\SketchUp\SketchUp 2017\ShippedExtensions
REM Permet une mise a jour automatique en remplacant uniquement les fichiers dans le serveur01
REM /D:j-m-a   Copie les fichiers modifiés à partir de la date spécifiée.Si aucune date n'est donnée, copie uniquement les fichiers dont l'heure source est plus récente que l'heure de destination.
REM /E Copie les répertoires et sous-répertoires, y compris les répertoires vides.
REM /Y Supprime la demande de confirmation de remplacement de fichiers de destination existants.
REM /J Copie avec E/S sans mémoires tampons. Recommandé pour les gros fichiers.
REM /I assume destination is a directory
REM /R Remplace les fichiers en lecture seule.

IF EXIST %DESTINATION% XCOPY %SOURCEPLUGINS%\*.* %DESTINATIONPLUGINS% /D /EXCLUDE:%SOURCEPLUGINS%\ListeFichiersExclus.txt /Y /J /I /R

REM ----- FIN Instalation des PLUGINS sketchups ------

:END
REM FINde BATCH 
REM Unsetting the __COMPAT_LAYER Variable
set __COMPAT_LAYER=
