divisors :: Int -> [Int]
divisors n = [i | i <- [2..(n `div` 2)], n `mod` i == 0]

primes :: Int -> [Int]
primes n = [i | i <- [2..n], divisors i == []]

pythagorean :: Int -> [(Int, Int, Int)]
pythagorean n = [(a,b,c) | a <- [3..n], b <- [a..n], c <-[5..n], a^2 + b^2 == c^2]

join :: String -> [String] -> String
join _ [] = []
join _ [x] = x
join a (x:xs) = x ++ a ++ (join a xs)

fact' :: Integer -> Integer
fact' n = foldl (*) 1 [2..n]

hailstone n
  | mod n 2 == 0    = div n 2
  | otherwise       = 3*n+1

hailLen n = hailTail 0 n --0 is the accumulator
  where
    hailTail a 1 = a
    hailTail a n = hailTail (a+1) (hailstone n)