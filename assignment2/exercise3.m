/* 
  This is a really naive method to calculate the binomial.
  I suspected this to be really slow but it was not that slow after all.
  Results of the runtime naive versus the native Binomial method: 
  Input            | Naive | Native | Factorial
  2 * 10^5, 10^5   | 0.2   | 0.1    | 0.4
  2 * 10^7, 10^7   | 72.9  | 27.9   | 204   
*/ 
naiveBinomial := function(n,k)
  return Factorial(n) / (Factorial(k)* Factorial(n-k));
end function;

/*
  Method 2: Working out the numerator and denomitor 
  Observe that Binom(n,k) = Prod([(n-k+1):n]) / Factorial(k);
  Waarbij Prod het product is over de elementen.
  2 * 10^7, 10^7   | 34.6  | 27.9   | 204
  
  See that Binom(n,k) = Binom(n,n-k) , This approach is much faster if k is smaller since both sides of the equations will be smaller.
*/
customBinomial := function(n,k)
  if(k gt n div 2) then 
     k := n - k;
  end if;
  return &*[(n-k+1)..n] / Factorial(k);
end function;


