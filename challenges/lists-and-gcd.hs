import Control.Monad
import Control.Applicative
import qualified Data.Map as Map
import qualified Data.Set as Set

main = do
    q <- readLn 
    lst <- replicateM q $ map read . words <$> getLine :: IO [[Int]]
    let pp = foldl1 Set.intersection $ map (toSet Set.empty) lst
        toMap' = toMap pp
        res = Map.toList $ foldl toMap' Map.empty lst
    forM_ res $ \(p, n) -> (putStr $ unwords $ map show [p, n]) >> putStr " "

toSet s [] = s
toSet s (p:n:factors) = toSet s2 factors
    where s2 = Set.insert p s

toMap pp m [] = m
toMap pp m (p:n:factors) = toMap pp m2 factors
    where m2 = if Set.member p pp then
                   Map.insertWith min p n m
               else
                   m
