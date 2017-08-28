#!/bin/bash

#Lee el nombre del archivo por dia para el Dominio 1
DIA=`date +%Y-%m-%d`
AYER=`date -d "1 day ago" +%Y-%m-%d`

D1='wrfout_d01_'
FINA='_00.nc'
NOMBRE1=$D1$DIA$FINA
D2='wrfout_d02_'
OUTFILE='$OUTFILE'
DATAFOLDER=/home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/Dominio1
INPUTFOLER=respaldo_pronostico_operativo/wrf/salidas/wrfout_d01_${HOY}_00.nc.gz.

#!/bin/sh

cd $DATAFOLDER 


echo "Respaldando el archivo de ayer..."
mv Dom1.nc Dom1_$AYER.nc
mv Dom2.nc Dom2_$AYER.nc

#Ejecuta el script armado en NCL para agregar precipitación horaria al archivo
 time ncl Presion_N_Mar2.ncl
#Ejecuta el script armado en NCL para agregar precipitación horaria al archivo
 time ncl Presion_N_Mar2.ncl
#Ejecuta el script armado en NCL para agregar precipitación horaria al archivo
  ncl Precipitacion_horaria.ncl
#Ejecuta el script armado en NCL para agregar rapidez del viento a diferentes niveles de Presion hPa al archivo
  ncl WS_hPa.ncl
#Ejecuta el script armado en NCL para agregar precipitación horaria al archivo
  ncl Precipitacion_acu3.ncl
#Ejecuta el script armado en NCL para agregar la variable Tiempo al archivo
  ncl Var_Tiempo.ncl
  
 
# ===================================================================

#Extrae las variables que se necesitan del modelo WRF
#ncks -v Times,T2,RAINNC,RAINC,U,V,U10,V10,SST,P,PB,XLAT,XLONG $NOMBRE2 pronostico.nc
ncks -v Times,T2,RAINNC,RAINC,U,V,U10,V10,SST,P,PB,SLP,XLAT,XLONG $NOMBRE1 pronostico.nc
 
#Realiza las operaciones aritmeticas para obtenerlas    
ncap2 -O -s "WS10=((sqrt(U10^2+V10^2))*3.6)" pronostico.nc pronostico_1.nc 
ncap2 -O -s "PA=P+PB" pronostico_1.nc pronostico_2.nc 
ncap2 -O -s "PREC2=RAINC+RAINNC" pronostico_2.nc pronostico_3.nc      
ncap2 -O -s "PT=P+PB" pronostico_3.nc pronostico_4.nc
ncap2 -O -s "T2C=T2-273.15" pronostico_4.nc pronostico_5.nc     
ncap2 -O -s "SSTC=SST-273.15" pronostico_5.nc pronostico_6.nc
ncap2 -O -s "PREC2B=PREC2*1" pronostico_6.nc pronostico_7.nc
 
#Crea un NetCDF con las variables creadas y borra los archivos temporales
#ncks -v Times,PREC2B,SSTC,T2C,PT,PREC2,PA,WS10,XLAT,XLONG,U,V,U10,V10,P,PB,SLP  pronostico_7.nc pronostico_pf1.nc
ncks -v Times,PREC2,WS10,PA,T2C,SSTC,XLAT,XLONG,U,V,U10,V10,PREC2B,P,PB,SLP  pronostico_7.nc pronostico_pf1.nc
rm pronostico.nc
rm pronostico_1.nc
rm pronostico_2.nc
rm pronostico_3.nc
rm pronostico_4.nc
rm pronostico_5.nc
rm pronostico_6.nc
rm pronostico_7.nc

#Cambia atributos a algunas variables
ncatted -a units,'T2C',o,c,'C' pronostico_pf1.nc
ncatted -a units,'SSTC',o,c,'C' pronostico_pf1.nc
ncatted -a units,'WS10',o,c,'km/hr' pronostico_pf1.nc

#Borra el archivo temporal anterior pronostico_pf1.nc
rm pronostico_pf1.nc

# ===================================================================
#Este script genera el archivo definitivo del Dominio1    
ncks -v Times,WS10,WS250,WS500,WS700,WS850,PA,T2C,SSTC,XLAT,XLONG,PRECH,U10,V10,U250,V250,U500,V500,U700,V700,U850,V850,SLP,PREC2 pronostico_pf1.nc $OUTFILE
#ncks -v P,PA,PB,PREC2,PREC2B,PT,SLP,SSTC,T2C,Times,WS10,XLAT,XLONG,PRECH,WS250,WS500,WS700,WS850,U10,V10,U250,V250,U500,V500,U700,V700,U850,V850 pronostico_pf1.nc Dom1.nc
#Agrega atributos para formar campo vectorial. 
ncatted -a description,'WS10',o,c,'Wind Speed at 10M/Velocidad del viento a 10M' $OUTFILE
ncatted -a standard_name,'U10',o,c,'eastward_viento' $OUTFILE
ncatted -a standard_name,'V10',o,c,'northward_viento' $OUTFILE
ncatted -a standard_name,'WS10',o,c,'upward_air_velocity' $OUTFILE
ncatted -a standard_name,'U250',o,c,'eastward_viento_250' $OUTFILE
ncatted -a standard_name,'V250',o,c,'northward_viento_250' $OUTFILE
ncatted -a standard_name,'WS250',o,c,'upward_air_velocity_250' $OUTFILE
ncatted -a standard_name,'U500',o,c,'eastward_viento_500' $OUTFILE
ncatted -a standard_name,'V500',o,c,'northward_viento_500' $OUTFILE
ncatted -a standard_name,'WS500',o,c,'upward_air_velocity_500' $OUTFILE
ncatted -a standard_name,'U700',o,c,'eastward_viento_700' $OUTFILE
ncatted -a standard_name,'V700',o,c,'northward_viento_700' $OUTFILE
ncatted -a standard_name,'WS700',o,c,'upward_air_velocity_700' $OUTFILE
ncatted -a standard_name,'U850',o,c,'eastward_viento_850' $OUTFILE
ncatted -a standard_name,'V850',o,c,'northward_viento_850' $OUTFILE
ncatted -a standard_name,'WS850',o,c,'upward_air_velocity_850' $OUTFILE  

export NCARG_ROOT=/usr

# QUE ES ESTO?
time /home/tai/Local/RESPALDO_OWGIS_tesisZizu/Scripts_Finales_GMT/postproceso_visor_dominios.sh >&log_postproceso_visor


