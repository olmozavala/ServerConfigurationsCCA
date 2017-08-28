#!/bin/sh   
  #Ejecuta el script armado en NCL para agregar la variable Tiempo al archivo
  #sudo ncl Var_Tiempo.ncl
  ncl Var_Tiempo.ncl
  
  #Borra el archivo temporal anterior pronostico_pf1.nc
  rm pronostico_pf2.nc
