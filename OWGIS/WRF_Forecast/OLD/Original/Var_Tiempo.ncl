;Este script añade la variable tiempo al archivo NetCDF para que reconozca las horas el ncWMS
  ;Hace un cambio de hora debido a que la hora sale en UTC/GMT y se pasa a hora local considerando el horario de verano
  ;Tomando en cuenta que El Horario de verano se aplica del primer domingo de abril a las 2h00 de la mañana al último domingo de octubre a las 2h00 de la mañana.
  ;Se tomo la hora central de México
  ;Lee el huso horario de la computadora y lo convierte a entero entonces se aplica condicional para saber si se resta 6 o 5 segun el horario
  ;Se tomo de base la semana 14 que es donde empieza Abril y la semana 43 que es el ultimo domingo de Octubre 
  ;Fuente: http://espanol.epochconverter.com/fecha-y-hora/numero-de-semanas.php
  
  ;Carga las librerias a utilizar en NCL
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
  
  
  ;Crea la variable at que es el equivalente a 1hr debido a que un entero equivale a un dia en el calendario del ncWMS
  at = new((/1/),double)
  at = (24.00000399)^-1 
  
  ;Crea la variable ms que es un valor que hace que el incremento de milisegundos sea en multiplos de 8
  ms = new((/1/),double)
  ms = .000000098777777778
  
  ;Crea la variable dt que es el valor equivalente a 1 milesima de segundo
  dt = new((/1/),double)
  dt = .0000000115740747474
  
  
  ;No es necesario que se utilicen por eso estan comentadas debido a que se va a quedar en hora UTC/GMT sí fuera a cambiar a hora local si son necesarias
  ;Crea la variable chr que es el equivalente a 5hrs
  ;chr = new((/1/),double)
  ;chr = 0.208333333333
  ;Crea la variable shr que es el equivalente a 6hrs
  ;shr = new((/1/),double)
  ;shr = 0.25
  
  
  ;Carga el archivo NetCDF
  f = addfile("Dom2.nc","w") 
  
  ;Define la unica dimension del tiempo y crea un arreglo del valor de los pasos del tiempo del NetCDF
  dimt =121
  timee = new((/dimt/),double)
  
  ;Crea los atributos de la variable tiempo
  timee@long_name = "time"
  
  ;Lee segun el dia y lo define en el atributo unidades
  fecha = systemfunc("date +%Y-%m-%d ")
  dsin = "days since "
  funit = " 00:00:00"
  strs = (/dsin,fecha,funit/)                                                                
  new_str = str_concat(strs)
  print(new_str)
  
  timee@units = new_str
  timee@calendar = "standard"
  timee@axis = "T"
  
  ;Da nombre a la dimension tiempo
  timee!0 = "Time"
  
  ;No es necesario que se utilicen por eso estan comentadas debido a que se va a quedar en hora UTC/GMT sí fuera a cambiar a hora local si son necesarias
  ;Crea las variables del huso horario del pais y la lee del sistema para hacer el debido cambio si es horario de verano y decide si se restan 5 o 6 hrs a la hr GMT
  ;huso = systemfunc("date +%z")
  ;husoent = stringtointeger(huso)
  ;husohor = husoent/100
  ;horalocal = new((/1/),double)
  ;horalocal = 0
  ;if(husohor.eq.-5) then
  ;horalocal = chr;
  ;else if(husohor.eq.-6) then
  ;horalocal = shr;
  ;end if
  ;end if
  
  ;Da valores a Time y hace que queden las horas enteras cerradas restando el huso horario si es invierno o verano
  k = 0
  do k =0,120 
  timee(k)=((k*at)+(k*ms)-(k*8*dt))
  ;Se utiliza si se cambia a hora local
  ;timee(k)=((k*at)+(k*ms)-(k*8*dt))-horalocal
  end do

  ;printVarSummary(timee)
  
  ;Crea y guarda la variable tiempo en el NetCDF
  filevardef(f, "Time", typeof(timee), getvardims(timee))
  f->Time = timee;
  quit
