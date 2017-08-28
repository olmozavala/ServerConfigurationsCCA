;Carga las librerias a utilizar
  f = addfile(inputFile,"w"); Abre el archivo NetCDF 
  PREC2B = f->PREC2B; Toma la variable PREC2B del archivo                 
  
; Da valores a las dimensiones de la variable a crear
  Time = dimsizes(f->Time)
  ;south_north = dimsizes(f->south_north)
  south_north = snDim
  ;west_east = dimsizes(f->west_east)
  west_east = weDim
  
  ; Crea la variable prech y escribe los nombres de las dimensiones
  prech = new((/Time,south_north,west_east/),float)
  prech!0 = "Time"
  prech!1 = "south_north"
  prech!2 = "west_east"
  
  ; Crea los atributos de la variable
  prech@FieldType  = "104"
  prech@MemoryOrder = "XY"
  prech@description      = "HOURLY PRECIPITATION/PRECIPITACIÓN HORARIA"
  prech@units      = "mm"
  prech@stagger      = "''"
  prech@coordinates      = "XLONG XLAT"
  
  ;printVarSummary(prech)
  
  
  do k = 0,119; Loop do hasta un cierto tiempo n-1
  prech(k,:,:)= (PREC2B(k+1,:,:)-PREC2B(k,:,:)); Hace la operacion aritmetica de la precipitacion horaria
  end do
  
  ;Crea la variable PRECH en el NetCDF y la guarda en el NetCDF
  filevardef(f, "PRECH", typeof(PREC2B), getvardims(PREC2B)); Crea la variable en el NetCDF, con sus respectivos atributos y dimensiones
  f->PRECH = prech;Guarda la variable creada en el NetCDF                      
  quit
  

