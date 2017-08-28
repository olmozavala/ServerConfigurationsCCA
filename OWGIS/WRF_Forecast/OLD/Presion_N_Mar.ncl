 
    ;Carga las librerias a utilizar
    load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
    load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  
    ;Leer el nombre del archivo
    fecha = systemfunc("date +%Y-%m-%d ")
    dom = "wrfout_d02_"
    funit = "_00.nc"
    nombre_wrf = (/dom,fecha,funit/)                                                                
    dia_wrf = str_concat(nombre_wrf)
    print(dia_wrf)
    
    ;Agrega el archivo NetCDF
    f = addfile(dia_wrf,"w"); Abre el archivo NetCDF
    PSFC = f->PSFC; Toma la variable PSFC del archivo 
    
    ;Carga todos los tiempos y calcula la variable
    time = -1
    slp = wrf_user_getvar(f,"slp",time)
    
    ;Crea el tamaño de las dimensiones
    ; Da valores a las dimensiones de la variable a crear
    Time = 121
    south_north =123
    west_east = 204
    
    ; Escribe los nombres de las dimensiones
    slp!0 = "Time"
    slp!1 = "south_north"
    slp!2 = "west_east"
    
    ; Crea los atributos de la variable
    slp@FieldType = 104 ;
    slp@MemoryOrder = "XY " ;
    slp@description = "Sea Level PRESSURE" ;
    slp@units = "Pa" ;
    slp@stagger = "" ;
    slp@coordinates = "XLONG XLAT" ;
    printVarSummary(slp)
    
    ;Crea la variable SLP en el NetCDF y la guarda en el NetCDF
    filevardef(f, "SLP", typeof(PSFC), getvardims(PSFC)); Crea la variable en el NetCDF, con sus respectivos atributos y dimensiones
    f->SLP = slp;Guarda la variable creada en el NetCDF                      
    quit