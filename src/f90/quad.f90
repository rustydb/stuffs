program Quad
implicit none
integer   :: a, b, c, D
real      :: Real_Part, Imag_Part, one_over_2a, sqrt_D
print*, "Type in values for a, b, and c"
read*, a, b, c
if(a /= 0) then
    ! Calc discriminant
    D = b * b - 4 * a * c
    one_over_2a = 1/(2.0 * a)
    sqrt_D = (sqrt(real(D)))
    if(D == 0) then               ! One root
        print*, "Root is ", -b * one_over_2a
    else if(D > 0) then           ! Real roots
        print*, "Roots are",(-b + sqrt_D) * one_over_2a, &
        "and",              (-b - sqrt_D) * one_over_2a
    else                          ! Complex roots
        Real_Part = -b/(2.0 * a)
        Imag_Part = (sqrt(real(-D)) * one_over_2a)
        print*, "1st root", Real_Part, "+", Imag_Part, "i"
        print*, "2nd root", Real_Part, "-", Imag_Part, "i"
    end if
else                              ! a == 0
    ! a is qual to 0 so...
    print*, "Not a quadratic eq."
end if
end Program Quad
