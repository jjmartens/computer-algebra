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

/** 
Little help function that determines the first row in which a queens needs to be placed
**/
firstZero := function (board)
  for i in [1..#board] do
    if board[i] eq 0 then
      return i;
    end if;
  end for;
  print board;
  return 0;
end function;

/** 
 Search a solution on a n*n board
**/
SearchQueenSolutions := function (N)
  board := [0: i in [1..N]];
  searchTree := [board];
  solutions := [];
  while #searchTree gt 0 do
    inspect := searchTree[#searchTree];
    Prune(~searchTree);
    if 0 in inspect then
      fz := firstZero(inspect);
      for placeQueen in [1..N] do
        inspect[fz] := placeQueen;
        if CheckLegal(inspect) then
          Append(~searchTree, inspect);
        end if;
      end for; 
    else 
      Append(~solutions,inspect);
    end if;
  end while;
  return #solutions;
end function;
