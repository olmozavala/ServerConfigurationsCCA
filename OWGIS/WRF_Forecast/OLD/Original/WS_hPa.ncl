 ;Este scrip calcula el viento a diferentes presiones, a si mismo de U,V para formar el campo vectorial
 ;Carga las libreria a utilizar
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  
  ;Carga  el archivo NetCDF en forma de escritura
  f = addfile("pronostico_pf2.nc","w");  
  WS10 = f->WS10; Carga la variable WS10
  U10 = f->U10; Carga la variable U10
  V10 = f->V10; Carga la variable V10
  ;printVarSummary(WS10)
  
  ;Da valor a las dimensiones de las variables a crear
  Time = 121
  south_north =123
  west_east = 204
  
  times = wrf_user_getvar(f,"Times",-1)  ;Variable de Tiempo
  ntimes = dimsizes(times)          
  
  ;Variables a necesitar algunas estan comentadas debido a innecesidad.
   ;tc = wrf_user_getvar(f,"T2C",-1)        ; T in C
    u  = wrf_user_getvar(f,"ua",-1)        ; u averaged to mass points
    v  = wrf_user_getvar(f,"va",-1)        ; v averaged to mass points
    p  = wrf_user_getvar(f, "pressure",-1) ; pressure is our vertical coordinate
    ;z  = wrf_user_getvar(f, "z",-1)        ; grid point height
    ;rh = wrf_user_getvar(f,"RH",-1)        ; relative humidity
  
  ;Distintos niveles de Presion
  pressure_level =(/250/)
  ;nlevel = dimsizes(pressure_level)
  pressure_level1 =(/500/)
  ;nlevel = dimsizes(pressure_level1)
  pressure_level2 =(/700/)
  ;nlevel = dimsizes(pressure_level2)
  pressure_level3 =(/850/)
  ;nlevel = dimsizes(pressure_level3)  
  
  ;Aqui se realizan las interpolaciones para los calculos
  ;tc_plane = wrf_user_intrp3d(tc,p,"h",pressure_level,0.,False)
  ;z_plane  = wrf_user_intrp3d( z,p,"h",pressure_level,0.,False)
  ;rh_plane = wrf_user_intrp3d(rh,p,"h",pressure_level,0.,False)
  u_plane  = wrf_user_intrp3d( u,p,"h",pressure_level,0.,False)
  v_plane  = wrf_user_intrp3d( v,p,"h",pressure_level,0.,False)
  
  u_plane1  = wrf_user_intrp3d( u,p,"h",pressure_level1,0.,False)
  v_plane1  = wrf_user_intrp3d( v,p,"h",pressure_level1,0.,False)
  
  u_plane2  = wrf_user_intrp3d( u,p,"h",pressure_level2,0.,False)
  v_plane2  = wrf_user_intrp3d( v,p,"h",pressure_level2,0.,False)
  
  u_plane3  = wrf_user_intrp3d( u,p,"h",pressure_level3,0.,False)
  v_plane3  = wrf_user_intrp3d( v,p,"h",pressure_level3,0.,False)
  
  ;Aqui se dan atributos a las variables U y V a diferentes niveles de presion 200,500,700,850Hp
  
  ;Viento en 250 Hpa
  u_plane@FieldType = 104 ;
  u_plane@MemoryOrder = "XY " ;
  u_plane@description = "U at 250 hPA" ;
  u_plane@units = "m s-1" ;
  u_plane@stagger = "" ;
  u_plane@coordinates = "XLONG XLAT" ;
  
  v_plane@FieldType = 104 ;
  v_plane@MemoryOrder = "XY " ;
  v_plane@description = "V at 250 hPA" ;
  v_plane@units = "m s-1" ;
  v_plane@stagger = "" ;
  v_plane@coordinates = "XLONG XLAT" ;
  
  ;Viento en 500 Hpa
  u_plane@FieldType = 104 ;
  u_plane@MemoryOrder = "XY " ;
  u_plane@description = "U at 500 hPA" ;
  u_plane@units = "m s-1" ;
  u_plane@stagger = "" ;
  u_plane@coordinates = "XLONG XLAT" ;

  v_plane@FieldType = 104 ;
  v_plane@MemoryOrder = "XY " ;
  v_plane@description = "V at 500 hPA" ;
  v_plane@units = "m s-1" ;
  v_plane@stagger = "" ;
  v_plane@coordinates = "XLONG XLAT" ;
  
  ;Viento en 700 Hpa
  u_plane@FieldType = 104 ;
  u_plane@MemoryOrder = "XY " ;
  u_plane@description = "U at 700 hPA" ;
  u_plane@units = "m s-1" ;
  u_plane@stagger = "" ;
  u_plane@coordinates = "XLONG XLAT" ;

  v_plane@FieldType = 104 ;
  v_plane@MemoryOrder = "XY " ;
  v_plane@description = "V at 700 hPA" ;
  v_plane@units = "m s-1" ;
  v_plane@stagger = "" ;
  v_plane@coordinates = "XLONG XLAT" ;
  
  ;Viento en 850 Hpa
  u_plane@FieldType = 104 ;
  u_plane@MemoryOrder = "XY " ;
  u_plane@description = "U at 850 hPA" ;
  u_plane@units = "m s-1" ;
  u_plane@stagger = "" ;
  u_plane@coordinates = "XLONG XLAT" ;

  v_plane@FieldType = 104 ;
  v_plane@MemoryOrder = "XY " ;
  v_plane@description = "V at 850 hPA" ;
  v_plane@units = "m s-1" ;
  v_plane@stagger = "" ;
  v_plane@coordinates = "XLONG XLAT" ;
  
  ;Aqui se realizan los calculaos de velocidad a cierto nivel de presion y se convierten a km/hr
  
  spd250 = new((/Time,south_north,west_east/),double)
  spd250 = (((u_plane*u_plane + v_plane*v_plane)^(0.5))*3.6) ; km/hr
    spd250!0 = "Time"
    spd250!1 = "south_north"
    spd250!2 = "west_east"
    spd250@description = "Wind Speed at 250Hp/Velocidad del viento a 250Hp"
    spd250@units = "km/hr"
    spd250@coordinates = "XLONG XLAT"
    spd250@stagger = ""
    ;printVarSummary(spd250)
  
  spd500 = new((/Time,south_north,west_east/),double)
  spd500 = (((u_plane1*u_plane1 + v_plane1*v_plane1)^(0.5))*3.6) ; km/hr
    spd500!0 = "Time"
    spd500!1 = "south_north"
    spd500!2 = "west_east"
    spd500@description = "Wind Speed at 500Hp/Velocidad del viento a 500Hp"
    spd500@units = "km/hr"
    spd500@coordinates = "XLONG XLAT"
    spd500@stagger = ""
    ;printVarSummary(spd500)
    
   spd700 = new((/Time,south_north,west_east/),double)
   spd700 = (((u_plane2*u_plane2 + v_plane2*v_plane2)^(0.5))*3.6) ; km/hr
    spd700!0 = "Time"
    spd700!1 = "south_north"
    spd700!2 = "west_east"
    spd700@description = "Wind Speed at 700Hp/Velocidad del viento a 700Hp"
    spd700@units = "km/hr"
    spd700@coordinates = "XLONG XLAT"
    spd700@stagger = ""
    ;printVarSummary(spd700)
  
  spd850 = new((/Time,south_north,west_east/),double)
  spd850 = (((u_plane3*u_plane3 + v_plane3*v_plane3)^(0.5))*3.6) ; km/hr
    spd850!0 = "Time"
    spd850!1 = "south_north"
    spd850!2 = "west_east"
    spd850@description = "Wind Speed at 850Hp/Velocidad del viento a 850Hp"
    spd850@units = "km/hr"
    spd850@coordinates = "XLONG XLAT"
    spd850@stagger = ""
    ;printVarSummary(spd850)
   
  ;Se guardan U,V a diferentes niveles de presion 200,500,700,850
  filevardef(f, "U250", typeof(U10), getvardims(U10))
  f->U250 = u_plane;                      
  filevardef(f, "V250", typeof(V10), getvardims(V10))
  f->V250 = v_plane;
  
  filevardef(f, "U500", typeof(U10), getvardims(U10))
  f->U500 = u_plane1; 
  filevardef(f, "V500", typeof(V10), getvardims(V10))
  f->V500 = v_plane1;
  
  filevardef(f, "U700", typeof(U10), getvardims(U10))
  f->U700 = u_plane2;
  filevardef(f, "V700", typeof(V10), getvardims(V10))
  f->V700 = v_plane2;
  
  filevardef(f, "U850", typeof(U10), getvardims(U10))
  f->U850 = u_plane3; 
  filevardef(f, "V850", typeof(V10), getvardims(V10))
  f->V850 = v_plane3;
  
  ;Se guardan las variables de viento en el NetCDF
  filevardef(f, "WS250", typeof(WS10), getvardims(WS10))
  f->WS250 = spd250;                      
  
  filevardef(f, "WS500", typeof(WS10), getvardims(WS10))
  f->WS500 = spd500; 
  
  filevardef(f, "WS700", typeof(WS10), getvardims(WS10))
  f->WS700 = spd700; 
  
  filevardef(f, "WS850", typeof(WS10), getvardims(WS10))
  f->WS850 = spd850; 
  quit
  
