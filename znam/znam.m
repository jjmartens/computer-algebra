function relativePrime(n, S)
    for i in S do
        if Gcd(n,i) ne 1 then
            return false;
        end if;
    end for;
    return true;
end function;

function Znam(k)
    lbound := [1 : i in [1..k]];
    ubound := [k - 1 : i in [1..k]];
    solutions := [];
    candidate := [1 : i in [1..k]];
    sindex := 1;    
    while sindex ne 0 do
        if lbound[sindex] lt ubound[sindex] then
            lbound[sindex] := lbound[sindex] + 1;
            if relativePrime(lbound[sindex], candidate) then            
                candidate[sindex] := lbound[sindex];
                if sindex lt k then
                    sindex := sindex + 1;
                    sumcount := 0;
                    //Calculate new bounds 
                    for i in [1..sindex-1] do
                        sumcount := sumcount + (1 / candidate[i]);       
                    end for;
                    lbound[sindex] := Max(Ceiling(1/(1-sumcount)), lbound[sindex-1]);
                    ubound[sindex] := Floor((k+2-sindex) * (1/ (1-sumcount)));
                else 
                    //Check if solution is correct;
                    P := &*candidate;
                    D := (1 - &+[1/i : i in candidate]) * P;
                    D := Floor(D);
                    factors := Divisors(D + P*P); 
                    for f in factors do
                        if (f mod D) eq (-P mod D) then
                            x := (f + P) / D;
                            y := ((D+ P^2) / f + P) / D;
                            if y gt x then
                                solution := Append(candidate,x);
                                solution := Append(solution, y);
                                print solution;
                                Append(~solutions, solution);
                            end if;    
                        end if; 
                    end for;
                end if;
            end if;            
        else 
            candidate[sindex] := 1;
            sindex := sindex-1;
        end if;
    end while;
    return solutions;
end function;

