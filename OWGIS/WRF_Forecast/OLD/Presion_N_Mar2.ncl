; El script recibe el nombre del archivo WRF a utilizar en la variable inputFile
;print("inputFile: "+inputFile)

;lee el archivo NetCDF
f = addfile(inputFile,"w")  ; Abre el archivo NetCDF

;Carga todos los tiempos y calcula la variable
SLP = wrf_user_getvar(f,"slp",-1)

;Crea la variable SLP en el NetCDF y la guarda en el NetCDF
f->SLP=SLP ;Guarda la variable creada en el NetCDF                      
quit
