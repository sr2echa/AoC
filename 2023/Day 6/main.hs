import System.IO (readFile)

main :: IO ()
main = do

    contents <- readFile "input.txt"
    let fileLines = map (dropWhile (== ' ')) $ lines contents

    let times = map read $ tail $ words $ head fileLines :: [Int]
    let records = map read $ tail $ words $ fileLines !! 1 :: [Int]

    -- Part 1
    let total = calculateTotalWays times records
    putStrLn $ "Part 1: " ++ show total

    -- Preparing values for Part 2
    let time = read $ concatMap show times :: Int
    let record = read $ concatMap show records :: Int

    -- Part 2
    let totalWays = length $ filter (> record) $ map (\ht -> ht * (time - ht)) [0..(time-1)]
    putStrLn $ "Part 2: " ++ show totalWays

calculateTotalWays :: [Int] -> [Int] -> Int
calculateTotalWays times records = foldl (*) 1 $ zipWith calculateWays times records

calculateWays :: Int -> Int -> Int
calculateWays time record = length $ filter (> record) $ map (\ht -> ht * (time - ht)) [0..(time-1)]
