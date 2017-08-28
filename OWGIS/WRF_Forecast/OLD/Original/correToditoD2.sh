#!/bin/sh

cd /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/Dominio2

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

