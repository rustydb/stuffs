program inq_arr
implicit none
integer, dimension(-1:1,3,2) :: A
print*, "Array size: ",     size(A)
print*, "Array shape: ",    shape(A)
print*, "Array lbound: ",   lbound(A, 2)
print*, "Array ubound: ",   ubound(A, 3)
end program inq_arr
