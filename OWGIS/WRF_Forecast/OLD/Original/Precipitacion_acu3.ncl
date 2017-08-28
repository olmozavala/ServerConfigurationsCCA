;Carga las librerías a utilizar
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
  
  ;Abre el archivo NetCDF en modo de escritura
  f = addfile("Dom2.nc","w") 
  PRECH = f->PRECH;Toma la variable                  
  ;printVarSummary(PRECH)
  
  ; Crea dimensiones
  Time = 121
  south_north =123
  west_east = 204
  preca = new((/Time,south_north,west_east/),float);Crea el areglo de mxnxo diensiones el primer escalar depende del Numero de pasos de tiempo entre 3, en entero
  
 ;Realiza el ciclo sumando en tres y con esto queda pero quedan espacios vacios  
  k = 0
  nn =119
  do while (k.le.nn); Reliza el ciclo
  preca(k,:,:) = (PRECH(k,:,:)+PRECH(k+1,:,:)+PRECH(k+2,:,:)); Realiza la operación
  k = k+3; Incrementa en 3 la variable debido a que se van sumando de 3 en 3 Por ejemplo preca(1)=1+2+3 preca(2)=4+5+6 
  end do; Cierra loop
  
  
  ;Se crea otro arreglo para poder guardar solo los espacios con valor
  ;Timen = 40; Este numero surge del entero de dividir pasos de tiempo entre 3 por ser hrs acumuladas
  ;preca3 = new((/Timen,south_north,west_east/),float);Crea el areglo de mxnxo diensiones el primer escalar depende del Numero de pasos de tiempo entre 3, en entero
  
  ;ii = 0
  ;jj = 0
  ;do ii =0,119
  ;resto = mod(ii,3);Residuo de ii entre 3
  ;if(resto.ne.0) then
  ;preca3(jj,:,:) = preca(ii,:,:)
  ;jj = jj+1
  ;else
  ;ii = ii+1
  ;end if
  ;end do
  
  
  ;Aqui se crean los atributos de la variable
  preca@FieldType  = "104"; Crea atributo y le da valor
  preca@MemoryOrder = "XY"
  preca@description      = "ACCUMULATED PRECIPITATION EACH 3 HRS/PRECIPITACION ACUMULADA CADA 3 HRS"
  preca@units      = "mm"
  preca@stagger      = "''"
  preca@coordinates      = "XLONG XLAT"
  
  ;Define las dimensiones de la variable
  ;preca!0 = "Time"
  ;preca!0 = "south_north"
  ;preca!0 = "west_east"
 
  ;printVarSummary(preca3)
  filevardef(f, "PRECA3", typeof(PRECH), getvardims(PRECH));Crea variable en NetCDF
  
  f->PRECA3 = preca; Guarda variable                      
  quit
   
