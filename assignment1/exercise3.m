integerToSequence := function (n, base)
  binSec := [];
  while n ne 0 do
    rem := n mod base;
    binSec := Append(binSec, rem);
    n := Integers() ! ((n-rem)/base); 
  end while;
  return binSec;
end function;

fastExponentiation := function(base, exponent, modulus)
  c := 1;
  binSec := integerToSequence(exponent,2);
  for i in binSec do
    if i eq 1 then
      c := c * base mod modulus;
    end if;
    base := base * base mod modulus;
  end for;
  return c;
end function;
