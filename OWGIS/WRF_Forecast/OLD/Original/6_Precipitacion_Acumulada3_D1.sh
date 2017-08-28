#!/bin/sh 
  
  #Lee el nombre del archivo por dia para el Dominio 1
    DIA=`date +%Y-%m-%d`
    D1='wrfout_d01_'
    FINA='_00.nc'
    NOMBRE1=$D1$DIA$FINA
 
 #Extrae las variables que se necesitan del modelo WRF
    ncks -v Times,RAINNC,RAINC $NOMBRE1 prec.nc
    ncap2 -O -s "PREC2=RAINC+RAINNC" prec.nc preca3hr.nc
    
  
  sudo ncl
  
  ;Carga las librerías a utilizar
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
  
  f = addfile("preca3hr.nc","w");Abre el archivo NetCDF 
  PREC2 = f->PREC2;Toma la variable                  
  ;printVarSummary(PREC2)
  
  ; Crea dimensiones
  Time = 121
  south_north =161
  west_east = 244
  preca = new((/40,south_north,west_east/),float);Crea el areglo de mxnxo diensiones el primer escalar depende del Numero de pasos de tiempo entre 3, en entero
  
  ; Da nombre a la dimension
  preca!0 = "Time"
  preca!1 = "south_north"
  preca!2 = "west_east"
  
  ;Aqui se crean los atributos de la variable
  preca@FieldType  = "104"; Crea atributo y le da valor
  preca@MemoryOrder = "XY"
  preca@description      = "ACCUMULATED PRECIPITATION EACH 3 HRS/PRECIPITACION ACUMULADA CADA 3 HRS"
  preca@units      = "mm"
  preca@stagger      = "''"
  preca@coordinates      = "XLONG XLAT"
  ;printVarSummary(preca)
  
  ; Se crean contadores
  k = 0
  nn = 119;Total de pasos de tiempo n-1
  zer = 0
  lim = 3
  preca3 = new((/Time,south_north,west_east/),float); Crea otro arreglo del total de los pasos de tiempo
  
  
  do while (k.le.nn); Reliza el ciclo
  preca3(k,:,:) = (PREC2(k,:,:)+PREC2(k+1,:,:)+PREC2(k+2,:,:)); Realiza la operación
  k = k+3; Incrementa en 3 la variable debido a que se van sumando de 3 en 3 Por ejemplo preca(1)=1+2+3 preca(2)=4+5+6 
  end do; Cierra loop
  
  ;Crea contadores para el segundo loop
  jj = 0
  do ii = 0,121
  resto = mod(ii,3);Residuo de ii entre 3
  if (resto.eq.0) then;Condicional if si residuo es igual a 0 se guarda la imagen
  preca(jj,:,:) = preca3(ii,:,:); Realiza la operacion
  jj =jj+1;La variable jj incrementa en 1 si se cumple
  end if
  end do
  
  printVarSummary(preca)
  filevardef(f, "PRECA3", typeof(preca), getvardims(preca));Crea variable en NetCDF
  f->PRECA3 = preca; Guarda variable                      
  quit
  