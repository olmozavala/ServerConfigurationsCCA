#!/bin/sh 
 
 #Lee el nombre del archivo por dia para el Dominio 2
    DIA=`date +%Y-%m-%d`
    D2='wrfout_d02_'
    FINA='_00.nc'
    NOMBRE2=$D2$DIA$FINA
    
 #Extrae las variables que se necesitan del modelo WRF
    ncks -v Times,RAINNC,RAINC,XLAT,XLONG $NOMBRE2 prec.nc
    ncap2 -O -s "PREC2B=RAINC+RAINNC" prec.nc prec2.nc 
    
  #Ejecuta la variable Precipitación horaria que se ocupa de un archivo ncl ya armado
  sudo ncl Precipitacion_horaria_acu.ncl   
  
  #Guarda la variable en un nuevo archivo NetCDF para la acumulada de 3 y 6 horas
  ncks -v Times,PRECH,XLAT,XLONG prec2.nc preca3.nc
  ncks -v Times,PRECH,XLAT,XLONG prec2.nc preca6.nc
  
  #Ejecuta la variable Precipitación acumulada cada 3 y 6 de archivos .ncl ya armados
  sudo ncl Precipitacion_acu3.ncl  
  sudo ncl Precipitacion_acu6.ncl
  
  #Borra los archivos temporales
  rm prec.nc
  rm prec2.nc
  
  #Agrega los pasos de tiempo a los NetCDF distintos
  
  sudo ncl Precipitacion_tiempo_acu3.ncl  
  sudo ncl Precipitacion_tiempo_acu6.ncl