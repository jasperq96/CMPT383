--to do arithmetic on type Hash, need to convert Int32 to Int using fromEnum
import RainbowAssign
import Data.Maybe
import qualified Data.Map as Map

pwLength, nLetters, width, height :: Int
filename :: FilePath
pwLength = 8            -- length of each password
nLetters = 5            -- number of letters to use in passwords: 5 -> a-e
width = 40              -- length of each chain in the table
height = 1000           -- number of "rows" in the table
filename = "hashTable.txt"  -- filename to store the table

--pwHash built in function that maps Passwd -> Hash

pwReduce :: Hash -> Passwd --first argument should be type Hash, using Int for testing
pwReduce num = conversion (fromEnum num) nLetters pwLength []
 where
     conversion number base acc lst
      | acc > 0     = conversion (number `div` base) base (acc-1) (toLetter(number `mod` base):lst)
      | acc == 0    = lst

-- easiest way to create a map (from values Type A and Type B) is to create a list of pairs
-- (of type [(A,B)]) and give that to the Map.fromList function to construct the map
-- 1 width is considered from hash -> reduce -> hash

--make pairs first, insert into a list, then pass in completed list into Map.fromList
--when passing into Map.fromList must be in a list already
--(123123,"works"):(567123, "yeap"):[]
rainbowTable :: Int -> [Passwd] -> Map.Map Hash Passwd
rainbowTable num lst = Map.fromList $ [(x,y) | y <- lst, let x = encrypt num y]
 where
     encrypt :: Int -> Passwd -> Hash
     encrypt acc pass
      | acc > 0     = encrypt (acc-1) (pwReduce $ pwHash pass)
      | otherwise   = pwHash pass

generateTable :: IO ()
generateTable = do
  table <- buildTable rainbowTable nLetters pwLength width height
  writeTable table filename

--value is the key in the mapping. Returns Just Passwd or Nothing 
--if there are matching keys, only returns one
-- test1 value = do
--   table <- readTable "passTable.txt"
--   return (Map.lookup value table) 
find :: Hash -> (Map.Map Hash Passwd) -> Maybe Passwd
find value hashTable = do 
  Map.lookup value hashTable

--once I find the row, iterate width length at most until previous Passwd hashed is equal to our original hash. 
locatePass :: Int -> Passwd -> Hash -> Maybe Passwd 
locatePass  checks posPass original
 | (pwHash posPass) == original    = Just posPass
 | checks > 0                      = locatePass (checks-1) (pwReduce $ pwHash posPass) original
 | otherwise                       = Nothing

-- reduce and hash given number until it matches something on the table
-- take password corresponding to matching hash.
-- hash and reduce until hash matches original hash, the previous password is the code
-- width tells me how many times I can hash/reduce before I know the key is not in the table
-- catMaybes [Just 1, nothing, Just 3] = [1,3] | The catMaybes function takes a list of Maybes and returns a list of all the Just values.

findPassword :: (Map.Map Hash Passwd) -> Int -> Hash -> Maybe Passwd 
findPassword table checks crack = locateRow table checks crack crack
 where
   locateRow :: (Map.Map Hash Passwd) -> Int -> Hash -> Hash -> Maybe Passwd 
   locateRow hashTable iterations currentCrack original
    | result /= Nothing       = locatePass iterations (fromJust result) original
    | iterations > 0          = locateRow hashTable (iterations-1) (pwHash $ pwReduce currentCrack) original
    | otherwise               = Nothing
     where
       result = find currentCrack hashTable