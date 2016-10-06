program triangle
implicit none
integer :: a, b, c
do
    print*, "Input three different positive side lengths, negative values will term."
    read*, a, b, c
    if((a.le.0.or.b.le.0).or.c.le.0) then
        print*, "A side can not be 0, try again"
        cycle
    endif
    if(2 * max(a, b, c) < (a + b + c)) then
        if(a == b.and. b == c) then
            print*, "This is an equilateral"
        elseif(a == b .or. b == c .or. a == c) then
            print*, "This is an isosoles"
        else
            print*, "This is a scalene"
        endif
    else
        print*, "Impossible.."
    endif
enddo
end program triangle
