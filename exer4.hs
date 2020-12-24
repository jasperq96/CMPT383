--zipWith (+) is applied to two lists otto produve the list of corresponding sums
pascal :: Int -> [Int]
pascal 0 = [1]
pascal n = zipWith (+) ([0] ++ pascal(n-1)) (pascal(n-1) ++ [0]) --need to add zero's because of how zip works and how the triangle is formed (outside ones).

addPair :: (Int, Int) -> Int
addPair = uncurry (+) --pointfree means no mention of the initial arguments

withoutZeros :: (Eq a, Num a) => [a] -> [a]
withoutZeros = filter (0 /= ) --applies a boolean expression onto a list

findElt :: Eq a => a -> [a] -> Maybe Int
findElt num x = index 0 num x
    where
        index acc num (x:xs)
         | xs == []     = Nothing
         | num == x     = Just acc
         | otherwise    = index (acc+1) num xs