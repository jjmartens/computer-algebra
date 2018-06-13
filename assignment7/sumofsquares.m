/**
> sumofsquares(73);
(-8 -3);
**/

sumofsquares := function(p) 
  g := PrimitiveRoot(p);
  h := g ^ ((p-1) div 4) mod p;
  return LLLCustom([Vector([p,0]), Vector([h,1])], 2)[1];
end function;

CustomContinuedFractions := function(p)
  a0 := Floor(p);
  an := 1 / (p - a0);
  frac := [a0, Floor(an)];
  while Floor(an) ne 2 * a0 do
    an := 1 / (an- Floor(an));
    Append(~frac, Floor(an));
  end while; 
  return frac; 
end function;


/**
> CFsumofsquares(73);
8 3
**/
CFsumofsquares := function(p)
  as := CustomContinuedFractions(Sqrt(p));
  ps := [as[1], as[1]*as[2] + 1];
  qs := [1, as[2]];
  for n in [3..#as-1] do
    nps := as[n] * ps[n-1] + ps[n-2];
    nqs := as[n] * qs[n-1] + qs[n-2];
    Append(~ps, nps);
    Append(~qs, nqs);
  end for;
  w := ps[#ps] mod p;
  a := w;
  b := p;
  while a ge Sqrt(p) do
     c := b - (b div a)* a;
     b := a;
     a := c;
  end while; 
  return a, b - (b div a) * a; 
end function;


function GSO(F, n)
  FS := [];
  M := [];
  for i in [1..n] do
    s := Vector(RealField(),[0.0: i in [1..n]]);
    mui := [];
    for j in [1..i-1] do
      if InnerProduct(FS[j], FS[j]) eq 0 then 
        Append(~mui, 0.0);
      else 
        muij := InnerProduct(Vector(F[i]), FS[j]) / InnerProduct(FS[j],FS[j]);
        Append(~mui, muij);
        s := s + muij * FS[j];
      end if;
    end for;
    for j in [i..n] do
      if j eq i then 
        muij := 1.0;
      else
        muij := 0.0;
      end if;
      Append(~mui, muij);
    end for;
    Append(~FS, Vector(F[i]) - s);
    Append(~M, mui);  
  end for;
  return FS, M;
end function;

function LLLCustom(F, n)
  m := #F;
  for i in [m..n-1] do
    Append(~F,Vector([0.0: i in [1..n]]));
  end for;
  Fstar, M := GSO(F,n);
  i := 2;
  while i le n do
    for j := i-1 to 1 by -1 do 
      F[i] := F[i] - Round(M[i][j]) * F[j];
      Fstar, M := GSO(F,n); 
    end for;
    if IsZero(F[i]) ne true and i gt 1 and InnerProduct(Fstar[i-1], Fstar[i-1]) ge 2 * InnerProduct(Fstar[i], Fstar[i])  then 
      Ft := F[i];
      F[i] := F[i-1];
      F[i-1] := Ft;
      Fstar, M := GSO(F,n);
      i := i - 1;
    else 
      i := i + 1;
    end if;
  end while;
  for i:=n to 1 by -1 do
    if IsZero(F[i]) then
      Remove(~F, i); 
    end if;
  end for;
  return F;    
end function;
