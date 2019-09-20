# windows_GPO_bat_install_sketchup_2017
20 septembre 2019

OS : windows 2016 serveur
Cible : serveur01
Nom : installSketchup.bat


BUT : Un simple script .bat de déploiement à integrer dans une GPO windows 2016 (serveur01) pour déployer sketchup 2019 et son plugin stl2 (pour export imprimantes 3d) à l’arrêt des machines.


 ![Alt text](gpo_sketchup_conf_01.png?raw=true "Etape 1") 
 ![Alt text](gpo_sketchup_conf_01.png?raw=true "Etape 2") 
 ![Alt text](gpo_sketchup_conf_01.png?raw=true "Etape 3") 

Note : Afin d'éviter des PBs de chemin il est préférable d'intégrer le script « installSketchup.bat » + les fichiers d'install de sketchup 2017 au seins même de la GPO, la clef de la GPO devra être intégré dans le .bat
