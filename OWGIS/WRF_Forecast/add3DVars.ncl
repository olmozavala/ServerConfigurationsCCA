procedure add3DVars(varNames,fin,fout,dim_time, dim_lat, dim_lon) begin
    ; Iterate over all the files and add each variable
    do varIdx =0,dimsizes(varNames)-1,1 ; This loop iterates over the variables
        print("Adding "+varNames(varIdx)+"...")
        origVar = fin->$varNames(varIdx)$
        newVar = new((/dim_time, dim_lat, dim_lon/), "float", 0)
        newVar(:,:,:) = (/origVar/)

		; ---- Copy the original variables 
        ;copy_VarAtts(origVar,newVar) ; Copy origial attributes
        ;delete_VarAtts(newVar, (/"coordinates"/))
        

		; --- Add specific attributes ----
        ; ---------- For U10 ----------
        if(varNames(varIdx) .eq. "U10") then
			newVar@units = "m/s" ;
			newVar@long_name= "U at 10 M" ;
			newVar@standard_name = "eastward_wind_ten_velocity" ;
			varNames(varIdx) = "Uat10"
        	print("Adding as "+varNames(varIdx)+"...")
        end if

        ; ---------- For V10 ----------
        if(varNames(varIdx) .eq. "V10") then
			newVar@units = "m/s" ;
			newVar@long_name= "V at 10 M" ;
			newVar@standard_name = "northward_wind_ten_velocity" ;
			varNames(varIdx) = "Vat10"
        	print("Adding as "+varNames(varIdx)+"...")
        end if

        filevardef(fout, varNames(varIdx) ,typeof(newVar), (/"Time","Latitude","Longitude" /) ) ; time dimension

        filevarattdef(fout,varNames(varIdx),newVar); copy T attributes
        fout->$varNames(varIdx)$ = (/newVar/)
        delete(newVar)
        delete(origVar)
        print("Done!")
    end do
end
