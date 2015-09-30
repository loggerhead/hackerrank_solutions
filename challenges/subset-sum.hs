import Data.List
import qualified Data.Set as S
import Control.Monad

main = do
    getLine
    aa <- liftM (sortBy (flip compare) . map read . words) getLine :: IO [Int]
    let sums = scanl1 (+) aa
        sl = last sums
        ss = S.fromList sums
    t <- readLn :: IO Int
    ress <- forM [1..t] $ (\_ -> do
        s <- readLn :: IO Int
        return $ show $ if sl < s then -1 else size_greater s ss)
    putStr . unlines $ ress
    return () 

size_greater s ss = succ $ S.size littler
    where (littler, _) = S.split s ss 
