#!/bin/bash

cd /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT

if [ -e ameyal/.montado ]
then
	echo "yasta montao"
else
	echo "lo montaremos..."
	sshfs jorge@ameyal://DATA/respaldo_pronostico_operativo/wrf/salidas/ /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/ameyal/
fi

 HOY=`date +%Y-%m-%d`

ya_existe=0
while ( [ $ya_existe == 0 ] )
do
	if [ -e ameyal/wrfout_d02_${HOY}_00.nc.gz ]
	then
		ya_existe=1
	else
		sleep 1m
	fi
done

zcat ameyal/wrfout_d01_${HOY}_00.nc.gz > Dominio1/wrfout_d01_${HOY}_00.nc
zcat ameyal/wrfout_d02_${HOY}_00.nc.gz > Dominio2/wrfout_d02_${HOY}_00.nc

AYER=`date -d "1 day ago" +%Y-%m-%d`
mv Dominio1/Dom1.nc Dominio1/Dom1_$AYER.nc
mv Dominio2/Dom2.nc Dominio2/Dom2_$AYER.nc

( time /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/Dominio1/correToditoD1.sh >logDom1 ) &
proc_D1_PID=$!
( time /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/Dominio2/correToditoD2.sh >logDom2 ) &
proc_D2_PID=$!

wait $proc_D1_PID

echo "Listo, Dom1.nc y Dom2.nc en owgis"
cat logDom1
echo "************************************LOG de DOM2**************************************"
cat logDom2

rm Dominio1/wrfout_d01_${HOY}_00.nc
rm Dominio2/wrfout_d02_${HOY}_00.nc
