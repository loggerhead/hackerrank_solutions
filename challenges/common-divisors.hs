import Control.Monad

main = do 
    t <- readLn 
    forM [1..t] $ \i -> 
        liftM (map read.words) getLine >>= common_divisors >>= print

common_divisors [m,l] = do
    return $ sum counts
    where c = gcd m l
          ds = [1..(floor.sqrt.fromIntegral) c]
          counts = [if d^2 == c then 1 else 2 | d <- ds, c `rem` d == 0]
