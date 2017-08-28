#!/bin/sh

##sudo sh 1_Var_D1.sh
##sudo sh 2_PREC_Hor_D1.sh
##sudo sh 3_WS_Pa_D1.sh
##sudo sh 4_Dom1.sh
##sudo sh 5_Prec_acu_3_6.sh
##sudo sh 6_Tiempo_D1.sh

cd /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/Dominio2
 
 HOY=`date +%Y-%m-%d`
  #scp jorge@132.248.8.238://DATA/respaldo_pronostico_operativo/wrf/salidas/wrfout_d01_${HOY}_00.nc.gz .
 scp jorge@132.248.8.238://DATA/respaldo_pronostico_operativo/wrf/salidas/wrfout_d02_${HOY}_00.nc.gz .
 echo "Copio el archivo wrfout de ameyal..."

  #gunzip wrfout_d01_${HOY}_00.nc.gz
 gunzip wrfout_d02_${HOY}_00.nc.gz

 AYER=`date -d "1 day ago" +%Y-%m-%d`
  #mv Dom1.nc Dom1_$AYER.nc
 mv Dom2.nc Dom2_$AYER.nc
	echo "Respaldo el archivo de ayer..."
  #rm Dom1.nc
 rm Dom2.nc

	echo "Va a iniciar con los scripts..."
 time sh 0_PRESION_N_M_D2.sh 
	echo "Inicia script 1..."
 time sh 1_Var_D2_mod.sh
	echo "Inicia script 2..."
 time sh 2_PREC_Hor_D2.sh
	echo "Inicia script 3..."
 time sh 3_WS_Pa_D2.sh
	echo "Inicia script 4..."
 time sh 4_Dom2_mod.sh
	echo "Inicia script 5..."
 time sh 5_Prec_acu_3_6.sh
	echo "Inicia ultimo script..."
 time sh 6_Tiempo_D2.sh
	echo "Ha terminado todos los scripts, Dom2.nc LISTO..."
