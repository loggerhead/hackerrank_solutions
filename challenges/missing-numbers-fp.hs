import Control.Monad
import qualified Data.Map as Map

main = do
    getLine
    aa <- liftM (map (\x -> (read x, -1)) . words) getLine :: IO [(Int, Int)]
    getLine
    bb <- liftM (map (\x -> (read x, 1)) . words) getLine :: IO [(Int, Int)]

    let as = Map.fromListWith (+) aa
        bs = Map.fromListWith (+) bb
        ab = Map.filter (> 0) $ Map.unionWith (+) as bs
        res = Map.keys ab

    putStrLn $ unwords $ map show res