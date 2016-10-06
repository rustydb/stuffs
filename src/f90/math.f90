    program math_magic
      implicit none
      integer   :: input
      real      :: mod_rem
      do
          print*, "Input a positive number, negative values term."
          read*, input
          if(input <= 0) then
              print*, "Must be greater than 0, +0 doesn't count, try again"
              cycle
          endif
          print*, "We are starting with: ", input, " Best of luck...."
          do
              print*, "Currently your number is: ", input
              if(input == 1) then
                  print*, "Tada! You arrived at 1!"
                  exit
              endif
              if(input == 13) then
                   print*, "Ugh, 13 no way"
                   exit
              endif
              mod_rem = mod(input, 2)
              if(mod_rem == 0.0) then
                  input = input * .5
              elseif(mod_rem == 1.0) then
                  input = input * 3 + 1
              endif
          enddo
      enddo
    end program math_magic

