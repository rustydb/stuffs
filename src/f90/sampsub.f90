program main
implicit none
real    :: a, b
a = 2.0
b = 3.5
call sub(a,b)
contains
    subroutine sub(a,b)
        real    :: a, b
        print*, "The sum of 2 & 3.5 is: ", a + b
    end subroutine
end program main
