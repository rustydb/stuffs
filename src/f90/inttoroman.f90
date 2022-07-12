program itor
implicit none
integer             :: intin, ifirst, iten, ihund
character(LEN=4)    :: rfirst, rten, rhund
! 12 is the longest roman numeral betweeen 0 - 999,
! that being 888. Therefore each digit
! is a max of 4
do
    print*, "Enter a number between 0 & 999 to be converted to roman, negs. restart"
    read*, intin
    if(intin < 0) then
        print*, "Negative Roman Numerals DNE.. try again silly.."
        cycle
    elseif(intin == 0) then
        print*, "0"
        cycle
    elseif(intin > 999) then
        print*, "That's larger than 999"
        cycle
    endif
    ifirst = mod(intin, 10)
    intin = intin * 0.1
    iten = mod(intin, 10)
    intin = intin * 0.1
    ihund  = mod(intin, 10)
    print*, "We have ihund: ", ihund, "iten: ", iten, "ifirst: ", ifirst
    select case (ihund)
        case(1)
            rhund   = "c"
        case(2)
            rhund   = "cc"
        case(3)
            rhund   = "ccc"
        case(4)
            rhund   = "cd"
        case(5)
            rhund   = "d"
        case(6)
            rhund   = "dc"
        case(7)
            rhund   = "dcc"
        case(8)
            rhund   = "dccc"
        case(9)
            rhund   = "cm"
        case default
            rhund   = ""
    end select
    select case (iten)
        case(1)
            rten    = "x"
        case(2)
            rten    = "xx"
        case(3)
            rten    = "xxx"
        case(4)
            rten    = "xl"
        case(5)
            rten    = "l"
        case(6)
            rten    = "lx"
        case(7)
            rten    = "lxx"
        case(8)
            rten    = "lxxx"
        case(9)
            rten    = "xc"
        case default
            rten   = ""
    end select
    select case (ifirst)
        case(1)
            rfirst  = "i"
        case(2)
            rfirst  = "ii"
        case(3)
            rfirst  = "iii"
        case(4)
            rfirst  = "iv"
        case(5)
            rfirst  = "v"
        case(6)
            rfirst  = "vi"
        case(7)
            rfirst  = "vii"
        case(8)
            rfirst  = "viii"
        case(9)
            rfirst  = "ix"
        case default
            rfirst = ""
    end select
    print*, "Your roman numeral is: ", rhund, rten, rfirst
    rhund = ""
    rten = ""
    rfirst = ""
enddo
end program itor
