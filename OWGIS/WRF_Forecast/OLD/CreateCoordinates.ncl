f = addfile(inputFile,"w"); Abre el archivo NetCDF 

; Adding latitude variable
XLAT = f->XLAT
dim_xlat = dimsizes(XLAT)
lat = new(dim_xlat(1),float)
lat = XLAT(0,:,0)
lat@standard_name = "latitude"
lat@long_name= "Latitude"
lat@units = "degrees_north"

filevardef(f, "Latitude" ,typeof(lat),"south_north") ; lat dimension
filevarattdef(f,"Latitude",lat)                  ; copy latitude attributes
f->Latitude  = (/lat/)

; Adding lonitude variable
XLONG = f->XLONG
dim_xlon = dimsizes(XLONG)
lon = new(dim_xlon(2),float)
lon = XLONG(0,0,:)
lon@standard_name = "longitude"
lon@long_name= "Longitude"
lon@units = "degrees_east"

filevardef(f, "Longitude" ,typeof(lon),"west_east") ; lon dimension
filevarattdef(f,"Longitude",lon)                  ; copy lonitude attributes
f->Longitude  = (/lon/)

;ncks -v Times,P,XLAT,XLONG /media/storageBK/storageBK/Dom1_2016-11-07.nc /media/storageBK/storageBK/Test.nc
