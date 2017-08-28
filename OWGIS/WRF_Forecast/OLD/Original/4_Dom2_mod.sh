#!/bin/sh
#Este script genera el archivo definitivo del Dominio2    
#ncks -v Times,WS10,WS250,WS500,WS700,WS850,PA,T2C,SSTC,XLAT,XLONG,PRECH,U10,V10,U250,V250,U500,V500,U700,V700,U850,V850,SLP,PREC2 pronostico_pf2.nc Dom2.nc
  ncks -v P,PA,PB,PREC2,PREC2B,PT,SLP,SSTC,T2C,Times,WS10,XLAT,XLONG,PRECH,WS250,WS500,WS700,WS850,U10,V10,U250,V250,U500,V500,U700,V700,U850,V850 pronostico_pf2.nc Dom2.nc
  
  #Agrega atributos para formar campo vectorial. 
  ncatted -a description,'WS10',o,c,'Wind Speed at 10M/Velocidad del viento a 10M' Dom2.nc
  ncatted -a standard_name,'U10',o,c,'eastward_viento' Dom2.nc
  ncatted -a standard_name,'V10',o,c,'northward_viento' Dom2.nc
  ncatted -a standard_name,'WS10',o,c,'upward_air_velocity' Dom2.nc
  ncatted -a standard_name,'U250',o,c,'eastward_viento_250' Dom2.nc
  ncatted -a standard_name,'V250',o,c,'northward_viento_250' Dom2.nc
  ncatted -a standard_name,'WS250',o,c,'upward_air_velocity_250' Dom2.nc
  ncatted -a standard_name,'U500',o,c,'eastward_viento_500' Dom2.nc
  ncatted -a standard_name,'V500',o,c,'northward_viento_500' Dom2.nc
  ncatted -a standard_name,'WS500',o,c,'upward_air_velocity_500' Dom2.nc
  ncatted -a standard_name,'U700',o,c,'eastward_viento_700' Dom2.nc
  ncatted -a standard_name,'V700',o,c,'northward_viento_700' Dom2.nc
  ncatted -a standard_name,'WS700',o,c,'upward_air_velocity_700' Dom2.nc
  ncatted -a standard_name,'U850',o,c,'eastward_viento_850' Dom2.nc
  ncatted -a standard_name,'V850',o,c,'northward_viento_850' Dom2.nc
  ncatted -a standard_name,'WS850',o,c,'upward_air_velocity_850' Dom2.nc
