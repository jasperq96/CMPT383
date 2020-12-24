import Data.Time.Calendar
import Data.Time.Calendar.OrdinalDate

merge :: Ord a => [a] -> [a] -> [a]
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys)
 | x <= y   = (x:merge xs (y:ys))
 | y < x    = (y:merge (x:xs) ys)

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort (x:y:[]) = merge [x] [y]
mergeSort (x) = merge (mergeSort (take ((length x) `div` 2) x))  (mergeSort (drop ((length x) `div` 2) x))

daysInYear :: Integer -> [Day]
daysInYear y = [jan1..dec31]
  where jan1 = fromGregorian y 1 1
        dec31 = fromGregorian y 12 31

isFriday :: Day -> Bool
isFriday x
 | (snd $ mondayStartWeek $ x) `mod` 7 == 5   = True
 | otherwise                                = False

divisors :: Int -> [Int]
divisors n = [i | i <- [2..(n `div` 2)], n `mod` i == 0]

isPrimeDay :: Day -> Bool
isPrimeDay x
 | divisors d == []     = True
 | otherwise            = False
 where
   (y,m,d) = toGregorian x

primeFridays :: Integer -> [Day]
primeFridays x = [i | i <- daysInYear x, isFriday i, isPrimeDay i]
