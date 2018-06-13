
PolRemainder := function (f,fs)
  p := f;
  r := 0;
  while p ne 0 do
    found := false;
    for i in [1..#fs] do
       if IsDivisibleBy(f,fs[i]) then
         found := true;
         p := p - LeadingTerm(p) div LeadingTerm(fs[i]) * fs[i];
       end if;  
       if not found then
         r := r + LeadingTerm(p);
         p := p - LeadingTerm(p);
       end if;
    end for;
  end while;
  return p;  
end function;

MDegree := function (g)
  m := LeadingTerm(g);
  if m eq 0 then
    return [0 : i in [1..Rank(Parent(g))]];
  end if;
  return Exponents(m);  
end function;

CustomSPolynomial := function(f, g)
   a := MDegree(f);
   b := MDegree(g); 
   gamma := [Max(a[i],b[i]): i in [1..#a]];
   fatX := &*[Parent(f).i ^ gamma[i]: i in [1..Rank(Parent(f))]];
   return fatX div LeadingTerm(f) * f - fatX div LeadingTerm(g) * g; 
end function;

testGrobner := function()
  F<x,y> := PolynomialRing(IntegerRing(),2);
  return GroebnerBasis([x^2*y+x-2*y^2, x^3-2*x*y]);
end function;

grobner := function (I) 
   G := I;
   while true do
     G := Sort(G);
     S := [];
     for i in [1..#G-1] do
       for j in [i+1..#G] do
         r := PolRemainder(CustomSPolynomial(G[i],G[j]), G);
         if r ne 0 then
           Append(~S, r);
         end if;
       end for;
     end for; 
     if #S eq 0 then
       return G;
     else 
       G := SetToSequence(SequenceToSet(G) join SequenceToSet(S));
     end if;
   end while;
end function;


