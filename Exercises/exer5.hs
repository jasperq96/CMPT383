import Data.Ratio

myIterate :: (a -> a) -> a -> [a]
myIterate f x = x:myIterate f (f x)

mySplitAt :: Int -> [a] -> ([a], [a])
mySplitAt n lst = split n lst []
 where
     split n current taken
      | n == 0      = (taken, current)
      | otherwise   = split (n-1) (drop 1 current) (taken ++ (take 1 current))

rationalSum :: Int -> [Ratio Int]
rationalSum num = [ratio | x <- [1..(num-1)], let ratio = x % (num-x)]

rationalSumLowest :: Int -> [Ratio Int]
rationalSumLowest num = [ratio | x <- [1..(num-1)], gcd x (num-x) == 1, let ratio = x % (num-x)]

--returns [[1 % 1],[1 % 2,2 % 1]], need to find a way to concatanate (++)
rationals :: [Ratio Int]
rationals = combine [frac | x <- [1..], let frac = rationalSumLowest x]
 where
     combine (x:xs) = (++) x (combine xs)

-- convert an integer-like string to an integer
readInt :: String -> Int
readInt = read

-- split a list around a given separator value
splitAtSeparator :: Eq a => a -> [a] -> [[a]]
splitAtSeparator sep [] = []
splitAtSeparator sep content = first : splitAtSeparator sep rest
    where
    first = takeWhile (/= sep) content
    firstlen = length first
    rest = drop (firstlen+1) content

sumFile :: IO()
sumFile = do
    file <- readFile "input.txt"
    let sep_list = splitAtSeparator '\n' file
    let added_list = sum $ map readInt sep_list
    putStrLn $ show added_list