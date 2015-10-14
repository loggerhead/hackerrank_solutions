import Control.Monad

main = readLn >>= \t -> replicateM_ t $ 
    getLine >> fmap (isBST . map read . words) getLine >>= putStrLn 

isBST :: [Int] -> String
isBST nums = if isBST' nums then "YES" else "NO"

isBST' [] = True
isBST' (root:nodes) = (all (> root) right) && (isBST' left) && (isBST' right)
    where (left, right) = span (< root) nodes
