/**
 Ik dacht dat dit mooi met een one-liner kon, het is een monster geworden. Maar het kan dus wel. 
 De one-liner is ook trager dan de iets meer uitgewerkte.
**/

CarmichaelOneLiner := function(n, k)
  return [&* x : x in &join [Subsets(SequenceToSet(PrimesInInterval(3,n)),ki) : ki in [3..k]] | &and [(&* x - 1) mod (y-1) eq 0: y in x]];
end function;


IsCarmichael := function(S)
  n := &* S;
  for i in S do
    if (n-1) mod (i-1) ne 0 then
      return false;
    end if;
  end for;
  return true;
end function;


Carmichael := function(maxPrime, maxNrPrime)
  U := {};
  for  i in [3..maxNrPrime] do
     U := U join Subsets(SequenceToSet(PrimesInInterval(3,maxPrime)),i); // 2 can't be in Carmichael numbers;
  end for;
  return [&* C: C in U | IsCarmichael(C)];
end function;


JacobiCustom := function(a,n)
   if n mod 2 eq 0 then
     print "argument 2 should not be divisible by 2";
     return "error";
   end if; 
   result := 1;
   while 1 eq 1 do
      if Gcd(a,n) ne 1 then
         return 0;
      end if;
      a := a mod n;
      while a mod 2 eq 0 do
        result := result * (-1)^((n^2-1) div 8);         
        a := a div 2; 
      end while; 
      if a eq 1 then
        return result;
      end if;
      if Gcd(a,n) ne 1 then
         return 0;
      end if;
      result := result * (-1)^(((a-1) div 2) * ((n-1) div 2));
      // Swap roles
      b := a;
      a := n;
      n := b;
   end while;
end function;

SolovayStrassen := function(n,k)
  for i in [1..k] do
    a := Random(n);
    if (JacobiCustom(a,n) mod n) ne (a^((n-1) div 2) mod n) then
       return "This number n:", n, " is composite for sure!.";
    end if;
  end for;
  return "This number n:", n , " passed the test ", k ," times, it is maybe prime.";
end function;
  
JacobiTest := function() 
  for i in [3..100] do
     for j in [x: x in  [3..100] | x mod 2 eq 1] do
        if JacobiSymbol(i,j) ne JacobiCustom(i,j) then
            return i,j;
        end if;
     end for;
  end for;
  return 1 eq 1; 
end function;
