program where
implicit none
integer, dimension(3,4) ::  w
w = reshape((/1, 2, 3, 4, 5, 6, 7, 8, 9, -2, -3, -9/), (/3,4/))
print*, w
where ((mod(w,2) .ne. 0) .and. (w > 0))
    w = -w
endwhere
print*, w
endprogram where
