/**
 Checks if placing a queen at position y is legal.
**/
CheckLegalAlt := function(board, y) 
  for x in [1..#board] do
    if board[x] ne 0 and x ne y then
      if board[x] eq board[y] or board[x] eq board[y] + (x-y) or board[x] eq board[y] - (x-y) then 
        return false;
      end if;
    end if;
   end for;
   return true;
end function;

/**
  Returns all open rows of a board.
**/
OpenRows := function (board)
  openRows := [];
  for i in [1..#board] do
    if board[i] eq 0 then
      Append(~openRows,i);
    end if;
  end for;
  return openRows;
end function;

MirrorX := procedure(~board)
  for x in [1..#board] do
    board[x] := #board - board[x] + 1;
  end for;
end procedure;

MirrorY := procedure(~board)
  for i in [1..(#board div 2)] do
    x := board[i];
    board[i] := board[#board-i+1];
    board[#board-i+1] := x;
  end for;
end procedure;

Transpose := procedure(~board)
  oldBoard := board;
  for i in [1..#board] do
    board[oldBoard[i]] := i; 
  end for;
end procedure;

AddIfUnique := procedure (~board, ~solutions)
  if board in solutions then 
    return;
  end if;
  MirrorX(~board);
  if board in solutions then 
    return;
  end if;
  MirrorY(~board);
  if board in solutions then
    return;
  end if;
  MirrorX(~board);
  if board in solutions then 
    return;
  end if;
  Transpose(~board);
  if board in solutions then 
    return;
  end if;
  MirrorX(~board);
  if board in solutions then 
    return;
  end if;
  MirrorY(~board);
  if board in solutions then
    return;
  end if;
  MirrorX(~board);
  if board in solutions then 
    return;
  end if;
  Append(~solutions, board);
  return;
end procedure;


/** 
 Search a solution on a n*n board, if board = [], find the total number of solutions.
 Function calls:
  time SearchQueenSolutions(9,[]);
    352
    Time: 0.290
  time SearchqueenSolutions(10,[]);
    724
    Time: 1.470
 In order to find a solution on a defined Board:
  SearchQueenSolutions(4,[2,4,0,0]); //0 is an open row. 
    [2,4,1,3] // Returns the solution found
  SearchQueenSolutions(4,[1,3,0,0]); 
    [] // no solution found.
**/
SearchQueenSolutions := function (N, board)
  if board eq [] then
    search := false;
    board := [0: i in [1..N]];
  else
    search := true;
    for i in [1..#board] do
      if board[i] ne 0 and not CheckLegalAlt(board, i) then 
        if search then
          return [];
        else 
          return 0;
        end if;
      end if;
    end for;
  end if;
  searchTree := OpenRows(board);
  // Edge case when checking an already fixed board;
  if searchTree eq [] then
    return board;
  end if;
  maxIndex := #searchTree;
  searchIndex := 1;
  solutions := [];
  while searchIndex gt 0 do
    inspect := searchTree[searchIndex];
    board[inspect] := board[inspect] + 1;
    if board[inspect] gt N then
      board[inspect] := 0;
      searchIndex := searchIndex - 1;
    elif CheckLegalAlt(board, searchTree[searchIndex]) then 
      if searchIndex lt maxIndex then 
        searchIndex := searchIndex + 1;
      elif search then
        return board;
      else
        Append(~solutions, board);
      end if;
    end if;
  end while;
  if search then
    return [];
  else
    return #solutions;
  end if;
end function;

/**
This is a different function since the bounds are little bit different 
and i had no time to implement that in 1 function.
Function outputs: 
  time SearchFundamentalQueenSolutions(9);
   46
   Time: 0.360
  time SearchFundamentalQueenSolutions(10);
   92
   Time: 1.570
**/
SearchFundamentalQueenSolutions := function (N)
  searchTree := [1.. N div 2 + N mod 2];
  board := [0: i in [1..N]];
  maxIndex := #searchTree;
  searchIndex := 1;
  solutions := [];
  while searchIndex gt 0 do
    inspect := searchTree[searchIndex];
    board[inspect] := board[inspect] + 1;
    if board[inspect] gt N then
      board[inspect] := 0;
      searchIndex := searchIndex - 1;
    elif CheckLegalAlt(board, searchTree[searchIndex]) then 
      if searchIndex lt maxIndex then 
        searchIndex := searchIndex + 1;
      else
        //AddIfUnique permutes the board
        copyBoard := SearchQueenSolutions(#board, board);
        if copyBoard ne [] then
          AddIfUnique(~copyBoard,~solutions);
        end if;
      end if;
    end if;
  end while;
  return #solutions;
end function;
