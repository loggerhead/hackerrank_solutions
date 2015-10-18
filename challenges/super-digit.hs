import Data.Char

main = do
    [nstr, k] <- fmap words getLine 
    let n = foldl (\sum ch -> sum + (ord ch - (ord '0'))) 0 nstr
    print $ super_digit $ (read k) * super_digit n

super_digit n 
          | n < 10 = n
          | otherwise = super_digit $ sum_digit n
    where sum_digit n 
                  | n == 0 = 0
                  | otherwise = (n `mod` 10) + (sum_digit $ n `div` 10)
