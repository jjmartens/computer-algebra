integerToSequenceReverse := function(n, base)
  if n eq 0 then
    return [];
  end if;
  rem := n mod base;
  next := Integers() ! ((n-rem)/base);
  return Append($$(next,base), rem);
end function;

integerToSequence := function(n,base)
  return Reverse(integerToSequenceReverse(n, base));
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
