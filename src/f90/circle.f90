program circle
implicit none
real :: radius, area, volume
do
    print*, "Type in the radius, negatives will terminate"
    read*, radius
    if(radius < 0) EXIT
    area    = 3.14 * radius**2
    volume  = (4 * 3.14 * radius**3)/3
    print*, "Area of circle with radius: ", radius, " is ", &
            area
    print*, "Volume of sphere with radius: ", radius, " is ", &
            volume
end do
end program circle
