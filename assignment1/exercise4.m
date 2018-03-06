Erathostenes := function(n)
  B := [1 : x in [1 .. n]];
  B[1] := 0;
  for index in [2 .. Floor(n/2)] do
    if B[index] eq 1 then
      k := index + index;
      while k le n do
        B[k] := 0;
        k := k + index;
      end while; 
    end if;
  end for;
  return B;  
end function;

ExtractNthPrime := function(n,B)
  for i in [1..#(B)] do
    if B[i] eq 1 then
      if n eq 1 then 
        return i;
      end if;
    n := n-1;
    end if;
  end for;    
end function;
