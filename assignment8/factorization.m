/**
Modern computer algebra 14.3
> P<x> := PolynomialRing(GF(3));
> DistinctDegreeFactoring(x*(x+1)* (x^2+1)*(x^2 + x + 2));
[
    x^2 + x,
    x^4 + x^3 + x + 2
]
> DistinctDegreeFactorization(x*(x+1)* (x^2+1)*(x^2 + x + 2));
[
    <1, x^2 + x>,
    <2, x^4 + x^3 + x + 2>
]
*/
DistinctDegreeFactoring := function (f)
  i := 0;
  hs := [Parent(f).1];
  fs := [f];
  gs := [];
  q := #BaseRing(f);
  while fs[#fs] ne 1 do
    i := i + 1;
    hi := Modexp(hs[#hs], q, f);
    Append(~hs, hi);
    Append(~gs, Gcd(hi - Parent(f).1, fs[#fs]));
    Append(~fs, fs[#fs] div gs[#gs]);
  end while;
  return gs;
end function;

EqualDegreeSplitting := function(f,d)
  a := RandomIrreduciblePolynomial(BaseRing(Parent(f)), Random(1,Degree(f)));
  g1 := Gcd(a,f);
  if g1 ne 1 then
    return g1;
  end if;
  b:= Modexp(a,(#BaseRing(Parent(f))^d - 1) div 2,f);
  g2 := Gcd(b-1, f);
  if g2 ne 1 and g2 ne f then
    return g2;
  end if;
  return "fail";
end function;
/**
Modern computer algebra 14.10:
*/
EqualDegFactor := function(f, d)
  if Degree(f) eq d then
    return [f];
  end if;
  g := EqualDegreeSplitting(f,d);
  
  while Type(g) eq MonStgElt do 
    g:= EqualDegreeSplitting(f,d);
  end while;
  ret := [];
  Append(~ret, $$(g,d));
  Append(~ret, $$(f div g,d));
  return ret;
end function;

/**
Modern computer algebra 14.13.
*/
Factor := function(f)
  hs := [Parent(f).1];
  vs := [f div LeadingCoefficient(f)];
  i := 0;
  U := {};
  q := #BaseRing(f);
  while vs[#vs] ne 1 do 
    i := i + 1;
    Append(~hs, Modexp(hs[#hs], q, f));
    g:= Gcd(hs[#hs] - Parent(f).1, vs[#vs]);
    if g ne 1 then
      gs := EqualDegFactor(g,i);
      vi := vs[#vs];
      for j in [1..#gs] do
        e:= 0;
        while IsDivisibleBy(vi, gs[j]) do
          vi := vi div gs[j]; 
          e := e + 1;
        end while;
        Append(~vs, vi);
        U := U join {<gs[j],e>};
      end for;
    end if; 
  end while;  
  return U;
end function;

/**

> FactorizationTest();   
{
    <x^69 + x^65 + x^64 + x^63 + x^62 + x^61 + x^59 + x^58 + x^53 + x^50 + x^48 
        + x^45 + x^44 + x^43 + x^41 + x^39 + x^34 + x^33 + x^28 + x^25 + x^24 + 
        x^23 + x^20 + x^19 + x^18 + x^15 + x^13 + x^10 + x^9 + x^8 + x^6 + x^5 +
        x^4 + x^3 + x^2 + x + 1, 1>,
    <x^14 + x^12 + x^10 + x^9 + x^5 + x^4 + 1, 1>,
    <x^17 + x^15 + x^13 + x^11 + x^6 + x^5 + x^4 + x^2 + 1, 1>
}
[
    <x^14 + x^12 + x^10 + x^9 + x^5 + x^4 + 1, 1>,
    <x^17 + x^15 + x^13 + x^11 + x^6 + x^5 + x^4 + x^2 + 1, 1>,
    <x^69 + x^65 + x^64 + x^63 + x^62 + x^61 + x^59 + x^58 + x^53 + x^50 + x^48 
        + x^45 + x^44 + x^43 + x^41 + x^39 + x^34 + x^33 + x^28 + x^25 + x^24 + 
        x^23 + x^20 + x^19 + x^18 + x^15 + x^13 + x^10 + x^9 + x^8 + x^6 + x^5 +
        x^4 + x^3 + x^2 + x + 1, 1>
]
*/
FactorizationTest := function() 
  K<w> := GF(2);
  P<x> := PolynomialRing(K);
  print Factor(x^100 + x + 1);
  print Factorization(x^100 + x + 1); 
end function;

/**
Henselslifting using our own factorization implementation. 
*/
HenselsLifting := function(f)
  n := Degree(f);
  A := MaxNorm(f);
  if n eq 1 then
    return f;
  end if;
  b := LeadingCoefficient(f);
  B := (n+1)^(1/2)*2^n* A *b; 
  C := (n+1)^(2*n) * A^ (2*n-1);
  gamma := Ceiling(2 * Log(2,C));
  
end function;

