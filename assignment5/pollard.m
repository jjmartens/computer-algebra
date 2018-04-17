f := function(x,c)
  return x * x + c;
end function;

/*
 Runtime:
   Not optimalized: 
     Last prime it can calculate in a reasonable armount of time is 25 digit prime number and a 4 number prime number. With c = 2 and doing 1500 iterations. 
   Optimalized:
 Choice of C:
   According to my own empirical data we learn:
> PollardOpt(NextPrime(10^25) * NextPrime(10^11),2,1000000);
100000000003
> PollardOpt(NextPrime(10^25) * NextPrime(10^11),-2,1000000);
1
> PollardOpt(NextPrime(10^25) * NextPrime(10^11),0,1000000);
1
>
> PollardOpt(NextPrime(10^25) * NextPrime(10^13),2,1500000);
10000000000037
> PollardOpt(NextPrime(10^25) * NextPrime(10^13),1,1500000);
1
So we would estimate that 2 preforms the best and 1 preforms better than -2 and 0. From further data we learn that 0 performs the worse, so I would guess 2 > 1 > -2 > 0.

Record :  
I did find 25 digit prime * 17 digit prime by: 
> time PollardOpt(NextPrime(10^24) * NextPrime(10^16),2,50000000);
10000000000000061
Time: 95.460
18 did not work:
time PollardOpt(NextPrime(10^24) * NextPrime(10^17),2,200000000);
1
Time: 974.220   
*/
Pollard := function(n) 
  xs := [Random(n)];
  for i in [1..1500] do
    xn := f(xs[#xs], 2) mod n;
    for x in xs do
      test := (xn - x);
      gcd := Gcd(n, test);
      if gcd ne 1 and gcd ne test then
        return gcd;
      end if;
      Append(~xs,xn); 
    end for;
  end for;
  return xs;
end function;

PollardOpt := function(n, c, k) 
  xi := Random(n);
  x2i := xi;
  for i in [1..k] do 
    xi := f(xi,c) mod n;
    x2i := f(f(x2i,c) mod n,c) mod n;
    test := (x2i - xi) mod n;
    gcd := Gcd(n, test);
    if gcd ne 1 and gcd ne test then
      return gcd;
    end if;
  end for;
  return 1;
end function;

