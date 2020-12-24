det a b c = b^2 - 4*a*c
quadsol1 a b c = (-b - sqrt (det a b c))/2*a
quadsol2 a b c = (-b + sqrt (det a b c))/2*a

third_a list = list !! 2 --syntax !! grabs the index. e.g. [...] !! 2 grabs index 2, or third element

third_b :: [a] -> a --(Show a) => [a] -> String allows for the bottom comment to run, without show, cannot add variable 'x' into string output
third_b [] = error "Empty List"
third_b (_:_:x:_) = x --"Third element is: " ++ show x
third_b (_:_) = error "Not Enough Elements"

fact :: (Integral x) => x -> x --Need Integral and Integral needs to be capitalized
fact 0 = 1
fact n = n * fact(n-1)

hailstone n
  | mod n 2 == 0    = div n 2
  | otherwise       = 3*n+1

hailLen n --cannot use list to calculate length
  | n == 1              = 0
  | hailstone n == 1    = 1
  | mod n 2 == 1        = 1 + hailLen (3*n+1)
  | otherwise           = 1 + hailLen (div n 2)