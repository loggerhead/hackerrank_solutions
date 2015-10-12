import Control.Monad
import Data.List

readInts = getLine >>= return . map read . words :: IO [Int]

getCircle :: (Eq a, Show a) => [[a]] -> ([a], [[a]])
getCircle matrix = (concat [top, right, bottom, left], m4)
    where (top, m1) = (head matrix, tail matrix)
          (right, m2) = (map last m1, map init m1)
          (bottom, m3) = if m2 /= [] then (reverse $ last m2, init m2) else ([], [])
          (left, m4) = (reverse $ map head m3, map tail m3)

putCircle :: (Eq a, Show a) => Int -> Int -> [a] -> [[a]] -> [[a]]
putCircle 1 n circle [[]] = [circle]
putCircle m 1 circle [[]] = [[x] | x <- circle]
putCircle 2 n circle [[]] = [fst, reverse snd]
    where (fst, snd) = splitAt n circle
putCircle m 2 circle [[]] = [lfst:rfst:[]] ++ zipWith (\x y -> x:y:[]) left r2
    where lfst:c2 = circle
          (right, rleft) = splitAt m c2
          left = reverse rleft
          rfst:r2 = right
putCircle m n circle matrix = reverse rc4:mt4
    where rc1 = reverse circle
          mt1 = matrix
          (left, rc2) = splitAt (m-2) rc1
          mt2 = zipWith (:) left mt1
          (bottom, rc3) = splitAt (n-1) rc2
          mt3 = bottom : reverse mt2
          (right, rc4) = splitAt (m-1) rc3
          mt4 = reverse $ zipWith (\x y -> x ++ [y]) mt3 right

rotate :: (Eq a, Show a) => Int -> Int -> Int -> [[a]] -> [[a]]
rotate _ _ _ [] = [[]]
rotate _ _ 0 _ = [[]]
rotate _ 0 _ _ = [[]]
rotate r m n matrix = putCircle m n c2 $ rotate r (m-2) (n-2) matrix2
    where (c, matrix2) = getCircle matrix
          len = length c
          c2 = (\(_,x) -> take len x) . splitAt (mod r len) . cycle $ c

main = do
    m:n:r:[] <- readInts
    matrix <- forM [1..m] (\_ -> readInts)
    putStrLn $ unlines . map (unwords . map show) $ rotate r m n matrix
