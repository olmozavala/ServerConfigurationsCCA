
;------- Functions (have to return a value)
function funcBasics() begin
    ;-------- Loop (start,end,step)
    do n=0,4,2
        print("Loop n val:"+n)
    end do 

    ;------- If 
    ; Options: .lt. .le. .eq. .ne. .ge. .gt. .and. .or. .xor. .not.
    if(False) then
        print("True")
    else
        print("False")
    end if
    return 1
end ; End Function

procedure funcArrays() begin
    ;--- Arrays ----
    ; Inits empty array of size 3
    myarray = new(3,integer)
    do n=0,2
        myarray(n) = n*2
    end do 
    print("-------- Printing myarray -------------")
    print(myarray)
    
    ; Second option array 
    mynewA= (/1, 2, 123.23/)
    ;mynewA= (/"sopas", "perico"/)
    print("-------- Printing mynewA-------------")
    print(mynewA)

    ; Operating on arrays
    x = (/1, 3, 3/)
    y = (/1, 3, 3/)
    print("-------- x*y-------------")
    print(x*y)

    ;----------- Range of values like Matlab
    size = 3
    step = 2
    a = ispan(-size,size,step); //Creates an array from -size to size with step 'step' (integer)
    print("-------- a -------------")
    print(a)

end

;------- Procedures do not return a value
procedure variablesNetCDF() begin
    lat_pts=(/1,2/) ; variables
    lon_pts=(/1,2,3,4/) ; variables
    lat_pts@units = "ints" ; Attributes
    lon_pts@units = "degrees" ; Attributes

    rowone = (/1,2,3,4/)
    rowtwo = (/5,6,7,8/)
    
    myvar=(/ rowone, rowtwo/)
    print("Value is: "+myvar(0,2))
    print("Next")
    print("Value is: "+myvar(1,1:2))
    myvar!0 = "lat";First Dimension
    myvar!1 = "lon";Second Dimension

    ; Assign arrays to named dimensions (Coordinates)
    myvar&lat = lat_pts
    myvar&lon = lon_pts
    print("-- My dimension var --")
    print(myvar)
    printVarSummary(myvar)
end

;res = funcBasics()
;funcArrays()
;variablesNetCDF
print("Yeah babe!")
