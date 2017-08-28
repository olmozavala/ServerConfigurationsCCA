#!/bin/bash

#Lee el nombre del archivo por dia para el Dominio 1
#HOY=`date +%Y-%m-%d`
HOY='2016-11-07'

SN_DIM_A=(208 159)
WE_DIM_A=(325 279)

for d in `seq 1 2`; do
    DOMINIO=$d

    # Size of the South north dimension (HARD CODED)
    SN_DIM=${SN_DIM_A[$DOMINIO-1]}
    # Size of the West east dimension (HARD CODED)
    WE_DIM=${WE_DIM_A[$DOMINIO-1]}

    INPUTFOLDER=/media/storageBK/storageBK
    OUTPUTFOLDER=/media/storageBK/storageBK

    OUTFILE=$OUTPUTFOLDER/Dom${DOMINIO}_${HOY}.nc

    WRF_FILE=$INPUTFOLDER/wrfout_d0${DOMINIO}_${HOY}_00.nc

    echo "\n******* Removing all previous temporal files..."
    rm -f $OUTPUTFOLDER/pronostico*.nc

    echo "\n****** Processing file: $WRF_FILE"

    # ========================== Remove all the variables that we do not need =======
    #Ejecuta el script armado en NCL para agregar precipitación horaria al archivo
    echo "\n****** Processing Presion_N_Mar2.ncl ..."
    #time ncl  'inputFile="'${WRF_FILE}'"' Presion_N_Mar2.ncl
    echo "** Done!"

    #Extrae las variables que se necesitan del modelo WRF
    TEMP_OUT_FILE=$OUTPUTFOLDER/pronostico.nc
    echo "\n****** Reducing size of wrf file (creates ${TEMP_OUT_FILE})..."
    ncks -v Times,T2,RAINNC,RAINC,U,V,U10,V10,SST,P,PB,XLAT,XLONG $WRF_FILE $TEMP_OUT_FILE
    echo "** Done!"

#    # =============================== Agrega la variable de tiempo al archivo
#    #Ejecuta el script armado en NCL para agregar la variable Tiempo al archivo
#    echo "\n\n****** Processing Var_Tiempo.ncl ..."
#    time ncl  'inputFile="'${TEMP_OUT_FILE}'"' Var_Tiempo.ncl
#
#    # ===================================================================
#    #Realiza las operaciones aritmeticas para obtenerlas    
#    echo "\n****** Computing basic operations on variables (creates pronostico_7)... "
#    ncap2 -O -s "WS10=((sqrt(U10^2+V10^2))*3.6);PA=P+PB;PREC2=RAINC+RAINNC;PT=P+PB;T2C=T2-273.15;SSTC=SST-273.15;PREC2B=PREC2*1" $TEMP_OUT_FILE $OUTPUTFOLDER/pronostico_7.nc
#    echo "** Done!"
#     
#    #Crea un NetCDF con las variables creadas y borra los archivos temporales
#    TEMP_OUT_FILE=$OUTPUTFOLDER/pron_pf$DOMINIO.nc
#    echo "\n******* Removing all previous temporal files..."
#    rm -f $TEMP_OUT_FILE
#    rm -f $OUTFILE
#    echo "** Done!"
#
#    echo "\n******* Building NetCDF (creates ${TEMP_OUT_FILE})...***** "
#    #ncks -v Times,PREC2B,SSTC,T2C,PT,PREC2,PA,WS10,XLAT,XLONG,U,V,U10,V10,P,PB,SLP  pronostico_7.nc pronostico_pf1.nc
#    ncks -v Times,PREC2,WS10,PA,T2C,SSTC,XLAT,XLONG,U,V,U10,V10,PREC2B,P,PB,Time  $OUTPUTFOLDER/pronostico_7.nc $TEMP_OUT_FILE
#
#    echo "\n******* Removing all previous temporal files..."
#    rm -f $OUTPUTFOLDER/pronostico*.nc
#    echo "** Done!"
#
#    echo "\n******* Changing attributes..."
#    #Cambia atributos a algunas variables
#    ncatted -a units,'T2C',o,c,'C' $TEMP_OUT_FILE
#    ncatted -a units,'SSTC',o,c,'C' $TEMP_OUT_FILE
#    ncatted -a units,'WS10',o,c,'km/hr' $TEMP_OUT_FILE
#    echo "** Done!"
#
#    # ========================== Scripts 
#    #Ejecuta el script armado en NCL para agregar precipitación horaria al archivo
#    echo "\n******* Processing Precipitacion_horaria.ncl ..."
#    time ncl weDim=${WE_DIM} snDim=${SN_DIM} 'inputFile="'${TEMP_OUT_FILE}'"'  Precipitacion_horaria.ncl
#    echo "** Done!"
#    #Ejecuta el script armado en NCL para agregar precipitación acumulada de 3 hrs
#    echo "\n******* Processing Precipitacion_acu3.ncl ..."
#    time ncl weDim=${WE_DIM} snDim=${SN_DIM} 'inputFile="'${TEMP_OUT_FILE}'"'  Precipitacion_acu3.ncl
#    echo "** Done!"
#    #Ejecuta el script armado en NCL para agregar precipitación acumulada de 6 hrs
#    echo "\n******* Processing Precipitacion_acu6.ncl ..."
#    time ncl weDim=${WE_DIM} snDim=${SN_DIM} 'inputFile="'${TEMP_OUT_FILE}'"'  Precipitacion_acu6.ncl
#    echo "** Done!"
#    #Ejecuta el script armado en NCL para agregar rapidez del viento a diferentes niveles de Presion hPa al archivo
#    echo "\n******* Processing WS_hPa.ncl ..."
#    time ncl weDim=${WE_DIM} snDim=${SN_DIM} 'inputFile="'${TEMP_OUT_FILE}'"' WS_hPa.ncl
#    echo "** Done!"
#    #
#    # ===================================================================
#    #Este script genera el archivo definitivo del Dominio1    
#    echo "\n*******  Creating final netcdf file with ncks..."
#    #ncks -v P,PA,PB,PREC2,PREC2B,PT,SLP,SSTC,T2C,Times,WS10,XLAT,XLONG,PRECH,WS250,WS500,WS700,WS850,U10,V10,U250,V250,U500,V500,U700,V700,U850,V850 $TEMP_OUT_FILE $OUTFILE
#    ncks -v P,PA,PB,PREC2,PRECA6,PRECA3,PREC2B,SSTC,T2C,Times,WS10,XLAT,XLONG,PRECH,WS250,WS500,WS700,WS850,U10,V10,U250,V250,U500,V500,U700,V700,U850,V850 $TEMP_OUT_FILE $OUTFILE
#    echo "** Done!"
#
##    echo "\n******* Removing all previous temporal files..."
##    rm -f $TEMP_OUT_FILE
##    echo "** Done!"
##
#    echo "\n*******  Adding proper attributes to vector variables..."
#    #Agrega atributos para formar campo vectorial. 
#    ncatted -a description,'WS10',o,c,'Wind Speed at 10M/Velocidad del viento a 10M' $OUTFILE
#    ncatted -a standard_name,'U10',o,c,'eastward_viento' $OUTFILE
#    ncatted -a standard_name,'V10',o,c,'northward_viento' $OUTFILE
#    ncatted -a standard_name,'WS10',o,c,'upward_air_velocity' $OUTFILE
#    ncatted -a standard_name,'U250',o,c,'eastward_viento_250' $OUTFILE
#    ncatted -a standard_name,'V250',o,c,'northward_viento_250' $OUTFILE
#    ncatted -a standard_name,'WS250',o,c,'upward_air_velocity_250' $OUTFILE
#    ncatted -a standard_name,'U500',o,c,'eastward_viento_500' $OUTFILE
#    ncatted -a standard_name,'V500',o,c,'northward_viento_500' $OUTFILE
#    ncatted -a standard_name,'WS500',o,c,'upward_air_velocity_500' $OUTFILE
#    ncatted -a standard_name,'U700',o,c,'eastward_viento_700' $OUTFILE
#    ncatted -a standard_name,'V700',o,c,'northward_viento_700' $OUTFILE
#    ncatted -a standard_name,'WS700',o,c,'upward_air_velocity_700' $OUTFILE
#    ncatted -a standard_name,'U850',o,c,'eastward_viento_850' $OUTFILE
#    ncatted -a standard_name,'V850',o,c,'northward_viento_850' $OUTFILE
#    ncatted -a standard_name,'WS850',o,c,'upward_air_velocity_850' $OUTFILE  
#    echo "** Done!"
#
#    echo "** DONE WITH EVERYTHING FOR DOMAIN: $DOMINIO!"
done
