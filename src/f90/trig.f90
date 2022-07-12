program triggy
implicit none
real    :: x, y, theta, r, rtheta
do
    print*, "Input r and theta, in that order"
    read*, r, theta
    rtheta = theta * (3.14/180)
    x = r * sin(rtheta)
    y = r * cos(rtheta)
    print*, "Your coordinate is ( ", x, ", ", y, " )"
enddo
end program triggy
