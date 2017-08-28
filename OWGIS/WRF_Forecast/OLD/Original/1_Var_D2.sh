#!/bin/sh
 
 #Lee el nombre del archivo por dia para el Dominio 2
    DIA=`date +%Y-%m-%d`
    D2='wrfout_d02_'
    FINA='_00.nc'
    NOMBRE2=$D2$DIA$FINA
 
 #Extrae las variables que se necesitan del modelo WRF
 ###ncks -v Times,T2,RAINNC,RAINC,U,V,U10,V10,SST,P,PB,SLP,XLAT,XLONG $NOMBRE2 pronostico.nc
    ncks -v Times,T2,RAINNC,RAINC,U,V,U10,V10,SST,P,PB,XLAT,XLONG $NOMBRE2 pronostico.nc
 
 #Realiza las operaciones aritmeticas para obtenerlas    
    ncap2 -O -s "WS10=((sqrt(U10^2+V10^2))*3.6)" pronostico.nc pronostico_1.nc 
    ncap2 -O -s "PA=P+PB" pronostico_1.nc pronostico_2.nc 
    ncap2 -O -s "PREC2=RAINC+RAINNC" pronostico_2.nc pronostico_3.nc      
    ncap2 -O -s "PT=P+PB" pronostico_3.nc pronostico_4.nc
    ncap2 -O -s "T2C=T2-273.15" pronostico_4.nc pronostico_5.nc     
    ncap2 -O -s "SSTC=SST-273.15" pronostico_5.nc pronostico_6.nc
    ncap2 -O -s "PREC2B=PREC2*1" pronostico_6.nc pronostico_7.nc
 
 #Crea un NetCDF con las variables creadas y borra los archivos temporales
 ###ncks -v Times,PREC2,WS10,PA,T2C,SSTC,XLAT,XLONG,U,V,U10,V10,PREC2B,P,PB,SLP  pronostico_7.nc pronostico_pf2.nc
    ncks -v Times,PREC2,WS10,PA,T2C,SSTC,XLAT,XLONG,U,V,U10,V10,PREC2B,P,PB  pronostico_7.nc pronostico_pf2.nc
    rm pronostico.nc
    rm pronostico_1.nc
    rm pronostico_2.nc
    rm pronostico_3.nc
    rm pronostico_4.nc
    rm pronostico_5.nc
    rm pronostico_6.nc
    rm pronostico_7.nc
  
  #Cambia atributos a algunas variables
    ncatted -a units,'T2C',o,c,'C' pronostico_pf2.nc
    ncatted -a units,'SSTC',o,c,'C' pronostico_pf2.nc
    ncatted -a units,'WS10',o,c,'km/hr' pronostico_pf2.nc

