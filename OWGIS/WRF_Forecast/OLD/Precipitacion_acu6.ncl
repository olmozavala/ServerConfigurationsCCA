f = addfile(inputFile,"w"); Abre el archivo NetCDF 

; Creates the new time dimensions to be used for accumulated precipitation. 
; In this case we should have one less time value than the original time
Time = f->Time

ntimeSize = floattointeger(ceil(dimsizes(Time)/6))

ntime = Time(0:ntimeSize*6-1:6) ;Time steps 
ntime@standard_name = "time"
ntime@long_name = "Time"
ntime@extra_info = "Time for prec acu 6"
ntime@units = Time@units
ntime@calendar = Time@calendar

; ------- Add the time dimension and variable to the file ---
filedimdef(f, (/"TimePreca6"/), ntimeSize, (/ False /))
filevardef(f, "TimePreca6", typeof(ntime), (/"TimePreca6" /) ); Crea la variable en el NetCDF, con sus respectivos atributos y dimensiones
filevarattdef(f, "TimePreca6", ntime)

PRECH = f->PRECH; Toma la variable PRECH del archivo                 

south_north = snDim
west_east = weDim

; Crea la variable preca3 y escribe los nombres de las dimensiones
preca3 = new( (/ntimeSize,south_north,west_east/) ,float)

; Crea los atributos de la variable
preca3@description      = "ACCUMULATED PRECIPITATION EACH 6 HRS/PRECIPITACION ACUMULADA CADA 6 HRS"
preca3@units       = "mm"
preca3@standard_name = "hour_prec6acu"
preca3@long_name     = "Precipitation Accu 6hr"

;Llena los datos de la variable
;preca3(:,:,:) = PRECH(0:ntimeSize-6:6,:,:)+PRECH(1:ntimeSize-2:6,:,:)+PRECH(2:ntimeSize-1:6,:,:); Realiza la operación
k = 0
do while (k.lt.ntimeSize); Reliza el ciclo
    preca3(k,:,:) = (PRECH(k*6,:,:)+PRECH(k*6+1,:,:)+PRECH(k*6+2,:,:)+PRECH(k*6+3,:,:)+PRECH(k*6+4,:,:)+PRECH(k*6+5,:,:)); Realiza la operación
    k = k+1; Incrementa en 6 la variable debido a que se van sumando de 6 en 6 Por ejemplo preca3(1)=1+2+6 preca3(2)=4+5+6 
end do; Cierra loop

;Crea la variable PRECH en el NetCDF y la guarda en el NetCDF
filevardef(f, "PRECA6", typeof(preca3), (/"TimePreca6", "south_north", "west_east" /) ); Crea la variable en el NetCDF, con sus respectivos atributos y dimensiones
filevarattdef(f, "PRECA6", preca3)

f->PRECA6 = (/preca3/);Guarda la variable creada en el NetCDF                      
f->TimePreca6 = (/ntime/)
quit

