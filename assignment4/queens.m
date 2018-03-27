/**

**/
CheckLegal := function (board)
  illegalposvertices := {};
  illegalnegvertices := {};
  illegal := {};
  for i in [1..#board] do
    if board[i] eq 0 then
      illegalnegvertices := { x-1 : x in illegalnegvertices};
      illegalposvertices := { x+1 : x in illegalposvertices};
    elif board[i] in illegal join illegalposvertices join illegalnegvertices then
      return false;
    else 
      illegal := illegal join {board[i]};
      illegalnegvertices := { x-1 : x in illegalnegvertices join {board[i]}};
      illegalposvertices := { x+1 : x in illegalposvertices join {board[i]}};
    end if;
  end for;
  return true;
end function;

CheckLegalAlt := function(board) 
  for x in [1..#board] do
    for y in [1..x] do
       if x ne y and board[x] ne 0 then 
         if board[x] eq board[y] or board[x] eq board[y] + (x-y) or board[x] eq board[y] - (x-y) then 
            return false;
         end if;
       end if;
     end for;
   end for;
   return true;
end function;

/** 
 Little help function that determines the first row in which a queens needs to be placed
**/
firstZero := function (board)
  for i in [1..#board] do
    if board[i] eq 0 then
      return i;
    end if;
  end for;
  return 0;
end function;

/** 
 Search a solution on a n*n board
**/
SearchQueenSolutions := function (N)
  board := [0: i in [1..N]];
  searchTree := [1];
  solutions := [];
  while #searchTree gt 0 do
    inspect := searchTree[#searchTree];
    board[inspect] := board[inspect] + 1;
    if board[inspect] gt N then
      board[inspect] := 0;
      Prune(~searchTree);
    elif CheckLegalAlt(board) then 
      if 0 in board then 
        Append(~searchTree, firstZero(board));
      else
        Append(~solutions, board);    
      end if;
    end if;
  end while;
  return #solutions;
end function;
