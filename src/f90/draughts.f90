program draughts_board
implicit none
character, dimension(1:8,1:8) :: D
D(1:8:2,1:8:2) = "w"
D(2:8:2,2:8:2) = "w"
D(2:8:2,1:8:2) = "b"
D(1:8:2,2:8:2) = "b"
print*, D
end program draughts_board
