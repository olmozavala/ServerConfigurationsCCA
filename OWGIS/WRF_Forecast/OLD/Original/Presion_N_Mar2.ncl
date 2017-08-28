 
    ;Carga las librerias a utilizar
    load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
    load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  
    ;Leer el nombre del archivo
    ini = "wrfout_d02_"
    fecha = systemfunc("date +%Y-%m-%d ")
    fin = "_00.nc"
    nombre_wrf = (/ini,fecha,fin/)                                                                
    arch = str_concat(nombre_wrf)
    print(arch)
    
    ;Agrega el archivo NetCDF
    f = addfile(arch,"w")  ; Abre el archivo NetCDF
    
    ;Carga todos los tiempos y calcula la variable
    SLP = wrf_user_getvar(f,"slp",-1)
    
    ;Crea la variable SLP en el NetCDF y la guarda en el NetCDF
    f->SLP=SLP ;Guarda la variable creada en el NetCDF                      
    quit
